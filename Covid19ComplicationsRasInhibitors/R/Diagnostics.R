# Copyright 2019 Observational Health Data Sciences and Informatics
#
# This file is part of Covid19ComplicationsRasInhibitors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#' Generate diagnostics
#'
#' @details
#' This function generates analyses diagnostics. Requires the study to be executed first.
#'
#' @param outputFolder         Name of local folder where the results were generated; make sure to use forward slashes
#'                             (/). Do not use a folder on a network drive since this greatly impacts
#'                             performance.
#' @param maxCores              How many parallel cores should be used? If more cores are made
#'                              available this can speed up the analyses.
#'
#' @export
generateDiagnostics <- function(outputFolder, minSubjectsForPs = 10, maxCores) {
  cmOutputFolder <- file.path(outputFolder, "cmOutput")
  diagnosticsFolder <- file.path(outputFolder, "diagnostics")
  if (!file.exists(diagnosticsFolder)) {
    dir.create(diagnosticsFolder)
  }
  reference <- readRDS(file.path(cmOutputFolder, "outcomeModelReference.rds"))
  reference <- addCohortNames(reference, "targetId", "targetName")
  reference <- addCohortNames(reference, "comparatorId", "comparatorName")
  reference <- addCohortNames(reference, "outcomeId", "outcomeName")
  reference <- addAnalysisDescription(reference, "analysisId", "analysisDescription")
  analysisSummary <- read.csv(file.path(outputFolder, "analysisSummary.csv"))
  reference <- merge(reference, analysisSummary[, c("targetId", "comparatorId", "outcomeId", "analysisId", "logRr", "seLogRr")])
  allControls <- getAllControls(outputFolder)
  subsets <- split(reference, paste(reference$targetId, reference$comparatorId, reference$analysisId))
  #remove empty row in subsets
  subsets<-subsets[lapply(subsets,nrow)>0]
  # subset <- subsets[[1]]
  cluster <- ParallelLogger::makeCluster(min(4, maxCores))
  ParallelLogger::clusterApply(cluster = cluster,
                               x = subsets,
                               fun = createDiagnosticsForSubset,
                               allControls = allControls,
                               outputFolder = outputFolder,
                               cmOutputFolder = cmOutputFolder,
                               diagnosticsFolder = diagnosticsFolder,
                               minSubjectsForPs = minSubjectsForPs)
  ParallelLogger::stopCluster(cluster)
}

createDiagnosticsForSubset <- function(subset, allControls, outputFolder, cmOutputFolder, 
                                       diagnosticsFolder, minSubjectsForPs) {
  targetId <- subset$targetId[1]
  comparatorId <- subset$comparatorId[1]
  analysisId <- subset$analysisId[1]
  ParallelLogger::logTrace("Generating diagnostics for target ", targetId, ", comparator ", comparatorId, ", analysis ", analysisId)
  ParallelLogger::logDebug("Subset has ", nrow(subset)," entries with ", sum(!is.na(subset$seLogRr)), " valid estimates")
  title <- paste(paste(subset$targetName[1], subset$comparatorName[1], sep = " - "),
                 subset$analysisDescription[1], sep = "\n")
  controlSubset <- merge(subset,
                         allControls[, c("targetId", "comparatorId", "outcomeId", "oldOutcomeId", "targetEffectSize")])

  # Empirical calibration ----------------------------------------------------------------------------------

  # Negative controls
  negControlSubset <- controlSubset[controlSubset$targetEffectSize == 1, ]
  validNcs <- sum(!is.na(negControlSubset$seLogRr))
  ParallelLogger::logDebug("Subset has ", validNcs, " valid negative control estimates")
  if (validNcs >= 5) {
    null <- EmpiricalCalibration::fitMcmcNull(negControlSubset$logRr, negControlSubset$seLogRr)
    fileName <-  file.path(diagnosticsFolder, paste0("nullDistribution_a", analysisId, "_t", targetId, "_c", comparatorId, ".png"))
    EmpiricalCalibration::plotCalibrationEffect(logRrNegatives = negControlSubset$logRr,
                                                seLogRrNegatives = negControlSubset$seLogRr,
                                                null = null,
                                                showCis = TRUE,
                                                title = title,
                                                fileName = fileName)
  } else {
    null <- NULL
  }

  # Positive and negative controls
  validPcs <- sum(!is.na(controlSubset$seLogRr[controlSubset$targetEffectSize != 1]))
  ParallelLogger::logDebug("Subset has ", validPcs, " valid positive control estimates")
  if (validPcs >= 10) {
    model <- EmpiricalCalibration::fitSystematicErrorModel(logRr = controlSubset$logRr,
                                                           seLogRr = controlSubset$seLogRr,
                                                           trueLogRr = log(controlSubset$targetEffectSize),
                                                           estimateCovarianceMatrix = FALSE)

    fileName <-  file.path(diagnosticsFolder, paste0("controls_a", analysisId, "_t", targetId, "_c", comparatorId, ".png"))
    EmpiricalCalibration::plotCiCalibrationEffect(logRr = controlSubset$logRr,
                                                  seLogRr = controlSubset$seLogRr,
                                                  trueLogRr = log(controlSubset$targetEffectSize),
                                                  model = model,
                                                  title = title,
                                                  fileName = fileName)

    fileName <-  file.path(diagnosticsFolder, paste0("ciCoverage_a", analysisId, "_t", targetId, "_c", comparatorId, ".png"))
    evaluation <- EmpiricalCalibration::evaluateCiCalibration(logRr = controlSubset$logRr,
                                                              seLogRr = controlSubset$seLogRr,
                                                              trueLogRr = log(controlSubset$targetEffectSize),
                                                              crossValidationGroup = controlSubset$oldOutcomeId)
    EmpiricalCalibration::plotCiCoverage(evaluation = evaluation,
                                         title = title,
                                         fileName = fileName)
  }

  # Statistical power --------------------------------------------------------------------------------------
  outcomeIdsOfInterest <- subset$outcomeId[!(subset$outcomeId %in% controlSubset$outcomeId)]
  mdrrs <- data.frame()
  for (outcomeId in outcomeIdsOfInterest) {
    strataFile <- subset$strataFile[subset$outcomeId == outcomeId]
    if (strataFile == "") {
      strataFile <- subset$studyPopFile[subset$outcomeId == outcomeId]
    }
    population <- readRDS(file.path(cmOutputFolder, strataFile))
    modelFile <- subset$outcomeModelFile[subset$outcomeId == outcomeId]
    model <- readRDS(file.path(cmOutputFolder, modelFile))
    if (model$outcomeModelType == "cox") {
    mdrr <- CohortMethod::computeMdrr(population = population,
                                      alpha = 0.05,
                                      power = 0.8,
                                      twoSided = TRUE,
                                      modelType =  model$outcomeModelType)
    } else {
      mdrr <- data.frame(targetPersons = length(unique(population$subjectId[population$treatment == 1])),
                         comparatorPersons = length(unique(population$subjectId[population$treatment == 0])),
                         targetExposures = sum(population$treatment == 1),
                         comparatorExposures = sum(population$treatment == 0),
                         targetDays = sum(population$timeAtRisk[population$treatment == 1]),
                         comparatorDays = sum(population$timeAtRisk[population$treatment == 0]),
                         totalOutcomes = sum(population$outcomeCount != 0),
                         mdrr = NA,
                         se = NA)
    }

    mdrr$outcomeId <- outcomeId
    mdrr$outcomeName <- subset$outcomeName[subset$outcomeId == outcomeId]
    mdrrs <- rbind(mdrrs, mdrr)
  }
  mdrrs$analysisId <- analysisId
  mdrrs$analysisDescription <- subset$analysisDescription[1]
  mdrrs$targetId <- targetId
  mdrrs$targetName <- subset$targetName[1]
  mdrrs$comparatorId <- comparatorId
  mdrrs$comparatorName <- subset$comparatorName[1]
  fileName <-  file.path(diagnosticsFolder, paste0("mdrr_a", analysisId, "_t", targetId, "_c", comparatorId, ".csv"))
  write.csv(mdrrs, fileName, row.names = FALSE)

  # Covariate balance --------------------------------------------------------------------------------------
  outcomeIdsOfInterest <- subset$outcomeId[!(subset$outcomeId %in% controlSubset$outcomeId)]
  outcomeId = outcomeIdsOfInterest[1]
  for (outcomeId in outcomeIdsOfInterest) {
    balanceFileName <- file.path(outputFolder,
                                 "balance",
                                 sprintf("bal_t%s_c%s_o%s_a%s.rds", targetId, comparatorId, outcomeId, analysisId))
    if (file.exists(balanceFileName)) {
      balance <- readRDS(balanceFileName)
      fileName = file.path(diagnosticsFolder,
                           sprintf("bal_t%s_c%s_o%s_a%s.csv", targetId, comparatorId, outcomeId, analysisId))
      write.csv(balance, fileName, row.names = FALSE)

      outcomeTitle <- paste(paste(subset$targetName[1], subset$comparatorName[1], sep = " - "),
                            subset$outcomeName[subset$outcomeId == outcomeId],
                            subset$analysisDescription[1], sep = "\n")
      fileName = file.path(diagnosticsFolder,
                           sprintf("balanceScatter_t%s_c%s_o%s_a%s.png", targetId, comparatorId, outcomeId, analysisId))
      balanceScatterPlot <- CohortMethod::plotCovariateBalanceScatterPlot(balance = balance,
                                                                          beforeLabel = "Before PS adjustment",
                                                                          afterLabel =  "After PS adjustment",
                                                                          showCovariateCountLabel = TRUE,
                                                                          showMaxLabel = TRUE,
                                                                          title = outcomeTitle,
                                                                          fileName = fileName)

      fileName = file.path(diagnosticsFolder,
                           sprintf("balanceTop_t%s_c%s_o%s_a%s.png", targetId, comparatorId, outcomeId, analysisId))
      balanceTopPlot <- CohortMethod::plotCovariateBalanceOfTopVariables(balance = balance,
                                                                         beforeLabel = "Before PS adjustment",
                                                                         afterLabel =  "After PS adjustment",
                                                                         title = outcomeTitle,
                                                                         fileName = fileName)
    }
  }
  # Propensity score distribution --------------------------------------------------------------------------
  psFile <- subset$sharedPsFile[1]
  if (psFile != "") {
    ps <- readRDS(file.path(cmOutputFolder, psFile))
    if (nrow(ps) > minSubjectsForPs) {
      fileName <-  file.path(diagnosticsFolder, paste0("ps_a", analysisId, "_t", targetId, "_c", comparatorId, ".png"))
      CohortMethod::plotPs(data = ps,
                           targetLabel = subset$targetName[1],
                           comparatorLabel = subset$comparatorName[1],
                           showCountsLabel = TRUE,
                           showAucLabel = TRUE,
                           showEquiposeLabel = TRUE,
                           title = subset$analysisDescription[1],
                           fileName = fileName)
    }
  }
}

debug_plotCovariateBalanceScatterPlot <- function(balance,
                                            absolute = TRUE,
                                            threshold = 0,
                                            title = "Standardized difference of mean",
                                            fileName = NULL,
                                            beforeLabel = "Before matching",
                                            afterLabel = "After matching",
                                            showCovariateCountLabel = FALSE,
                                            showMaxLabel = FALSE) {
  beforeLabel <- as.character(beforeLabel)
  afterLabel <- as.character(afterLabel)
  if (absolute) {
    balance$beforeMatchingStdDiff <- abs(balance$beforeMatchingStdDiff)
    balance$afterMatchingStdDiff <- abs(balance$afterMatchingStdDiff)
  }
  limits <- c(min(c(balance$beforeMatchingStdDiff, balance$afterMatchingStdDiff), na.rm = TRUE),
              max(c(balance$beforeMatchingStdDiff, balance$afterMatchingStdDiff), na.rm = TRUE))
  plot <- ggplot2::ggplot(balance,
                          ggplot2::aes(x = beforeMatchingStdDiff, y = afterMatchingStdDiff)) +
    ggplot2::geom_point(color = rgb(0, 0, 0.8, alpha = 0.3), shape = 16) +
    ggplot2::geom_abline(slope = 1, intercept = 0, linetype = "dashed") +
    ggplot2::geom_hline(yintercept = 0) +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::ggtitle(title) +
    ggplot2::scale_x_continuous(beforeLabel, limits = limits) +
    ggplot2::scale_y_continuous(afterLabel, limits = limits)
  if (threshold != 0) {
    plot <- plot + ggplot2::geom_hline(yintercept = c(threshold,
                                                      -threshold), alpha = 0.5, linetype = "dotted")
  }
  if (showCovariateCountLabel || showMaxLabel) {
    labels <- c()
    if (showCovariateCountLabel) {
      labels <- c(labels, sprintf("Number of covariates: %s", format(nrow(balance), big.mark = ",", scientific = FALSE)))
    }
    if (showMaxLabel) {
      labels <- c(labels, sprintf("%s max(absolute): %.2f", afterLabel, max(abs(balance$afterMatchingStdDiff), na.rm = TRUE)))
    }
    dummy <- data.frame(text = paste(labels, collapse = "\n"))
    plot <- plot + ggplot2::geom_label(x = limits[1] + 0.01, y = limits[2], hjust = "left", vjust = "top", alpha = 0.8, ggplot2::aes(label = text), data = dummy, size = 3.5)
    
  }
  if (!is.null(fileName)) {
    ggplot2::ggsave(fileName, plot, width = 4, height = 4, dpi = 400)
  }
  return(plot)
}

.truncRight <- function(x, n) {
  nc <- nchar(x)
  x[nc > (n - 3)] <- paste("...",
                           substr(x[nc > (n - 3)], nc[nc > (n - 3)] - n + 1, nc[nc > (n - 3)]),
                           sep = "")
  x
}


debug_plotCovariateBalanceOfTopVariables <- function(balance,
                                               n = 20,
                                               maxNameWidth = 100,
                                               title = NULL,
                                               fileName = NULL,
                                               beforeLabel = "before matching",
                                               afterLabel = "after matching") {
  n <- min(n, nrow(balance))
  beforeLabel <- as.character(beforeLabel)
  afterLabel <- as.character(afterLabel)
  topBefore <- balance[order(-abs(balance$beforeMatchingStdDiff)), ]
  topBefore <- topBefore[1:n, ]
  topBefore$facet <- paste("Top", n, beforeLabel)
  topAfter <- balance[order(-abs(balance$afterMatchingStdDiff)), ]
  topAfter <- topAfter[1:n, ]
  topAfter$facet <- paste("Top", n, afterLabel)
  filtered <- rbind(topBefore, topAfter)
  
  data <- data.frame(covariateId = rep(filtered$covariateId, 2),
                     covariate = rep(filtered$covariateName, 2),
                     difference = c(filtered$beforeMatchingStdDiff, filtered$afterMatchingStdDiff),
                     group = rep(c(beforeLabel, afterLabel), each = nrow(filtered)),
                     facet = rep(filtered$facet, 2),
                     rowId = rep(nrow(filtered):1, 2))
  filtered$covariateName <- .truncRight(as.character(filtered$covariateName), maxNameWidth)
  data$facet <- factor(data$facet, levels = rev(levels(data$facet)))
  data$group <- factor(data$group, levels = rev(levels(data$group)))
  plot <- ggplot2::ggplot(data, ggplot2::aes(x = difference,
                                             y = rowId,
                                             color = group,
                                             group = group,
                                             fill = group,
                                             shape = group)) +
    ggplot2::geom_point() +
    ggplot2::geom_vline(xintercept = 0) +
    ggplot2::scale_fill_manual(values = c(rgb(0.8, 0, 0, alpha = 0.5),
                                          rgb(0, 0, 0.8, alpha = 0.5))) +
    ggplot2::scale_color_manual(values = c(rgb(0.8, 0, 0, alpha = 0.5),
                                           rgb(0, 0, 0.8, alpha = 0.5))) +
    ggplot2::scale_x_continuous("Standardized difference of mean") +
    ggplot2::scale_y_continuous(breaks = nrow(filtered):1, labels = filtered$covariateName) +
    ggplot2::facet_grid(facet ~ ., scales = "free", space = "free") +
    ggplot2::theme(axis.text.y = ggplot2::element_text(size = 7),
                   axis.title.y = ggplot2::element_blank(),
                   legend.position = "top",
                   legend.direction = "vertical",
                   legend.title = ggplot2::element_blank())
  if (!is.null(title)) {
    plot <- plot + ggplot2::ggtitle(title)
  }
  if (!is.null(fileName))
    ggplot2::ggsave(fileName, plot, width = 10, height = max(2 + n * 0.2, 5), dpi = 400)
  return(plot)
}
