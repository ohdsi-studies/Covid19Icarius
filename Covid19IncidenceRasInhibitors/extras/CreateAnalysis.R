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

htnIngredientConceptIds <- c(1319998,1317967,991382,1332418,1314002,40235485,1335471,1322081,1338005,932745,1351557,1340128,1346823,1395058,1398937,1328165,1363053,1341927,1309799,1346686,1353776,1363749,956874,1344965,1373928,974166,978555,1347384,1326012,1386957,1308216,1367500,1305447,907013,1307046,1309068,1310756,1313200,1314577,1318137,1318853,1319880,40226742,1327978,1373225,1345858,1350489,1353766,1331235,1334456,970250,1317640,1341238,942350,1342439,904542,1308842,1307863)

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
  includeCovariateIds = makeCovariateIdsToInclude(),
  prior = Cyclops::createPrior(priorType = "normal",
                               variance = fixedPsVariance,
                               useCrossValidation = FALSE))

createLargeScalePsArgs <- CohortMethod::createCreatePsArgs(
  stopOnError = FALSE,
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
  maxRatio = 1 # TODO Allow for multiple matches
)

# Analysis 1 -- crude/adjusted

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
                                              description = "Full PS match",
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


