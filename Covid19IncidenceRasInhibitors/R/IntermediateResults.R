packageIntermediateResults <- function(outputFolder,
                                       databaseId,
                                       databaseName,
                                       databaseDescription,
                                       minCellCount = 5,
                                       maxCores = 4,
                                       makePlots = TRUE) {
  
  cmOutputFolder <- file.path(outputFolder, "cmOutput")
  if (!file.exists(cmOutputFolder)) {
    stop("cmOutput directory has not yet been created.")
  }
  cmAnalysisListFile <- system.file("settings",
                                    "cmAnalysisList.json",
                                    package = "Covid19IncidenceRasInhibitors")
  cmAnalysisList <- CohortMethod::loadCmAnalysisList(cmAnalysisListFile)
  # tcosList <- createTcos(outputFolder = outputFolder)
  outcomesOfInterest <- getOutcomesOfInterest()
  
  # Remove TC pairs with 0-count cohorts
  # cohortCounts <- read.csv(paste0(outputFolder, "/CohortCounts.csv"))
  # nonZeroCount <- unlist(lapply(tcosList, function(tco) {
  #   return(tco$targetId %in% cohortCounts$cohortDefinitionId &&
  #            tco$comparatorId %in% cohortCounts$cohortDefinitionId)
  # }))
  
  #Make results objects
  results <- readRDS(file.path(outputFolder, "outcomeModelReference.rds"))
  
  ParallelLogger::logInfo("Summarizing results")
  analysisSummary <- CohortMethod::summarizeAnalyses(referenceTable = results, 
                                                     outputFolder = cmOutputFolder)
  analysisSummary <- addCohortNames(analysisSummary, "targetId", "targetName")
  analysisSummary <- addCohortNames(analysisSummary, "comparatorId", "comparatorName")
  analysisSummary <- addCohortNames(analysisSummary, "outcomeId", "outcomeName")
  analysisSummary <- addAnalysisDescription(analysisSummary, "analysisId", "analysisDescription")
  write.csv(analysisSummary, file.path(outputFolder, "analysisSummary.csv"), row.names = FALSE)
  
  ParallelLogger::logInfo("Computing covariate balance") 
  balanceFolder <- file.path(outputFolder, "balance")
  if (!file.exists(balanceFolder)) {
    dir.create(balanceFolder)
  }
  subset <- results[results$outcomeId %in% outcomesOfInterest,]
  subset <- subset[subset$strataFile != "", ]
  if (nrow(subset) > 0) {
    subset <- split(subset, seq(nrow(subset)))
    cluster <- ParallelLogger::makeCluster(min(3, maxCores))
    ParallelLogger::clusterApply(cluster, subset, computeCovariateBalance, cmOutputFolder = cmOutputFolder, balanceFolder = balanceFolder)
    ParallelLogger::stopCluster(cluster)
  }
  
  ParallelLogger::logInfo("Running diagnostics")
  generateDiagnostics(outputFolder = outputFolder,
                      makePlots = makePlots,
                      maxCores = maxCores)
  
  ParallelLogger::logInfo("Packaging results")
  exportResults(outputFolder = outputFolder,
                databaseId = databaseId,
                databaseName = databaseName,
                databaseDescription = databaseDescription,
                minCellCount = minCellCount,
                maxCores = maxCores)
}
