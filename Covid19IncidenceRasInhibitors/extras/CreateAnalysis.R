# Create analysis plans

makeCovariateIdsToInclude <- function(includeIndexYear = FALSE) {
  ageGroupIds <- unique(
    floor(c(18:110) / 5) * 1000 + 3
  )
  
  # Index month
  monthIds <-c(1:12) * 1000 + 7
  
  # Gender
  genderIds <- c(8507, 8532) * 1000 + 1
  
  # Index year
  if (includeIndexYear) {
    yearIds <- c(2016:2019) * 1000 + 6
  } else {
    yearIds <- c()
  }
  
  return(c(ageGroupIds,monthIds,yearIds,genderIds))
}

# ACE: http://atlas-covid19.ohdsi.org/#/conceptset/598/details
# aceConceptIds <- c(1340128,19050216,1341927,1342001,1363749,1308216,1373225,1334456,1335471,45775539,19122327,1310756,45775374,45775544,1331235,45775375,45775527,19040051,1342439,45775529,19102107)
# ARB: http://atlas-covid19.ohdsi.org/#/conceptset/599/conceptset-expression
# arbConceptIds <- c(1367500,40235485,1351557,1346686,1347384,40226742,1317640,1308842)
# THZ: http://atlas-covid19.ohdsi.org/#/conceptset/597/details
# thzConceptIds <- c(1316354,1395058,974166,978555,907013,19010493)
# dCCB: http://atlas-covid19.ohdsi.org/#/conceptset/594/details
# ccbConceptIds <- c(1332418,1353776,1326012,1318137,1318853,1319133,1319880,19020061,19089969,19004539,19015802,19071995,19102106,19113063)
# BB: http://atlas-covid19.ohdsi.org/#/conceptset/595/details
# bbConceptIds <- c(1319998,19081284,1314002,1322081,1338005,19018489,950370,19049145,1386957,932815,905531,1307046,1313200,19024904,1327978,1345858,1353766,1370109,902427,19018640,1346823,19063575,1314577,19100435,19100451)
# ndCCB: http://atlas-covid19.ohdsi.org/#/conceptset/596/details
# ndCcbConceptIds <- c(1328165,1307863,19057715)

htnIngredientConceptIds <- c(1319998,1317967,991382,1332418,1314002,40235485,1335471,1322081,1338005,932745,1351557,1340128,1346823,1395058,1398937,1328165,1363053,1341927,1309799,1346686,1353776,1363749,956874,1344965,1373928,974166,978555,1347384,1326012,1386957,1308216,1367500,1305447,907013,1307046,1309068,1310756,1313200,1314577,1318137,1318853,1319880,40226742,1327978,1373225,1345858,1350489,1353766,1331235,1334456,970250,1317640,1341238,942350,1342439,904542,1308842,1307863,1319133,19020061,19089969,19004539,19015802,19071995,19102106,19113063,1316354,19010493,19122327,1342001,19040051,19050216,19102107,45775374,45775375,45775527,45775529,45775539,45775544,19057715,902427,905531,932815,950370,1370109,19018489,19018640,19024904,19049145,19063575,19081284,19100435,19100451)

firstExposureOnly <- FALSE # TODO Reconfirm
studyStartDate <- ""
fixedPsVariance <- 1 # TODO confirm
fixedOutcomeVariance <- 4

covarSettingsWithHtnMeds <- FeatureExtraction::createDefaultCovariateSettings()
covarSettingsWithHtnMeds$mediumTermStartDays <- -90
covarSettingsWithHtnMeds$longTermStartDays <- -180

covarSettingsWithoutHtnMeds <- FeatureExtraction::createDefaultCovariateSettings(
  excludedCovariateConceptIds = htnIngredientConceptIds,
  addDescendantsToExclude = TRUE
)
covarSettingsWithoutHtnMeds$mediumTermStartDays <- -90
covarSettingsWithoutHtnMeds$longTermStartDays <- -180

getDbCmDataArgsWithHtnMeds <- CohortMethod::createGetDbCohortMethodDataArgs(
  firstExposureOnly = firstExposureOnly,
  studyStartDate = studyStartDate,
  removeDuplicateSubjects = "remove all",
  excludeDrugsFromCovariates = FALSE,
  covariateSettings = covarSettingsWithHtnMeds
)

getDbCmDataArgsWithoutHtnMeds <- CohortMethod::createGetDbCohortMethodDataArgs(
  firstExposureOnly = firstExposureOnly,
  studyStartDate = studyStartDate,
  removeDuplicateSubjects = "remove all",
  excludeDrugsFromCovariates = FALSE,
  covariateSettings = covarSettingsWithoutHtnMeds
)

createStudyPopArgs <- CohortMethod::createCreateStudyPopulationArgs(
  removeSubjectsWithPriorOutcome = TRUE,
  minDaysAtRisk = 0
)

createMinPsArgs <- CohortMethod::createCreatePsArgs(
  stopOnError = FALSE,
  maxCohortSizeForFitting = 100000,
  includeCovariateIds = makeCovariateIdsToInclude(),
  prior = Cyclops::createPrior(priorType = "normal",
                               variance = fixedPsVariance,
                               useCrossValidation = FALSE))

createLargeScalePsArgs <- CohortMethod::createCreatePsArgs(
  stopOnError = FALSE,
  maxCohortSizeForFitting = 100000,
  prior = Cyclops::createPrior(priorType = "laplace",
                               useCrossValidation = TRUE))

fitUnadjustedOutcomeModelArgs <- CohortMethod::createFitOutcomeModelArgs(
  modelType = "cox",
  useCovariates = FALSE,
  stratified = FALSE)

fitAdjustedOutcomeModelArgs <- CohortMethod::createFitOutcomeModelArgs(
  modelType = "cox",
  useCovariates = TRUE,
  includeCovariateIds = makeCovariateIdsToInclude(),
  stratified = FALSE,
  prior = Cyclops::createPrior(priorType = "normal",
                               variance = fixedOutcomeVariance,
                               useCrossValidation = FALSE))

fitPsOutcomeModelArgs <- CohortMethod::createFitOutcomeModelArgs(
  modelType = "cox",
  useCovariates = FALSE,
  stratified = TRUE)

stratifyByPsArgs <- CohortMethod::createStratifyByPsArgs(numberOfStrata = 5)

matchByPsArgs <- CohortMethod::createMatchOnPsArgs(
  maxRatio = 10
)
matchByPsArgs$allowReverseMatch <- TRUE

# Analysis 1 -- crude/unadjusted

cmAnalysis1 <- CohortMethod::createCmAnalysis(analysisId = 1,
                                              description = "Crude/unadjusted",
                                              getDbCohortMethodDataArgs = getDbCmDataArgsWithHtnMeds,
                                              createStudyPopArgs = createStudyPopArgs,
                                              createPs = FALSE,
                                              fitOutcomeModel = TRUE,
                                              fitOutcomeModelArgs = fitUnadjustedOutcomeModelArgs)

# Analysis 2 -- adjusted outcome

cmAnalysis2 <- CohortMethod::createCmAnalysis(analysisId = 2,
                                              description = "Adjusted outcome",
                                              getDbCohortMethodDataArgs = getDbCmDataArgsWithHtnMeds,
                                              createStudyPopArgs = createStudyPopArgs,
                                              createPs = FALSE,
                                              fitOutcomeModel = TRUE,
                                              fitOutcomeModelArgs = fitAdjustedOutcomeModelArgs)

# Analysis 3 -- minimal PS stratification

cmAnalysis3 <- CohortMethod::createCmAnalysis(analysisId = 3,
                                              description = "Min PS stratified",
                                              getDbCohortMethodDataArgs = getDbCmDataArgsWithoutHtnMeds,
                                              createStudyPopArgs = createStudyPopArgs,
                                              createPs = TRUE,
                                              createPsArgs = createMinPsArgs,
                                              stratifyByPs = TRUE,
                                              stratifyByPsArgs = stratifyByPsArgs,
                                              fitOutcomeModel = TRUE,
                                              fitOutcomeModelArgs = fitPsOutcomeModelArgs)

# Analysis 4 -- minimal PS matching

cmAnalysis4 <- CohortMethod::createCmAnalysis(analysisId = 4,
                                              description = "Min PS matched",
                                              getDbCohortMethodDataArgs = getDbCmDataArgsWithoutHtnMeds,
                                              createStudyPopArgs = createStudyPopArgs,
                                              createPs = TRUE,
                                              createPsArgs = createMinPsArgs,
                                              matchOnPs = TRUE,
                                              matchOnPsArgs = matchByPsArgs,
                                              fitOutcomeModel = TRUE,
                                              fitOutcomeModelArgs = fitPsOutcomeModelArgs)

# Analysis 5 -- Large-scale PS stratification

cmAnalysis5 <- CohortMethod::createCmAnalysis(analysisId = 5,
                                              description = "Full PS stratified",
                                              getDbCohortMethodDataArgs = getDbCmDataArgsWithoutHtnMeds,
                                              createStudyPopArgs = createStudyPopArgs,
                                              createPs = TRUE,
                                              createPsArgs = createLargeScalePsArgs,
                                              stratifyByPs = TRUE,
                                              stratifyByPsArgs = stratifyByPsArgs,
                                              fitOutcomeModel = TRUE,
                                              fitOutcomeModelArgs = fitPsOutcomeModelArgs)

# Analysis 6 -- Large-scale PS matching

cmAnalysis6 <- CohortMethod::createCmAnalysis(analysisId = 6,
                                              description = "Full PS matched",
                                              getDbCohortMethodDataArgs = getDbCmDataArgsWithoutHtnMeds,
                                              createStudyPopArgs = createStudyPopArgs,
                                              createPs = TRUE,
                                              createPsArgs = createLargeScalePsArgs,
                                              matchOnPs = TRUE,
                                              matchOnPsArgs = matchByPsArgs,
                                              fitOutcomeModel = TRUE,
                                              fitOutcomeModelArgs = fitPsOutcomeModelArgs)

cmAnalysisList <- list(cmAnalysis1,cmAnalysis2,cmAnalysis3,cmAnalysis4,cmAnalysis5,cmAnalysis6)

CohortMethod::saveCmAnalysisList(cmAnalysisList, "cmAnalysisList.json")

