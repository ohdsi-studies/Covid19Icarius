OHDSI COVID-19 Studyathon: Association of angiotensin converting enzyme (ACE) inhibitors and angiotensin II receptor blockers (ARB) on coronavirus disease (COVID-19) incidence and complications
==============================

<img src="https://img.shields.io/badge/Study%20Status-Design%20Finalized-brightgreen.svg" alt="Study Status: Design Finalized"> 

- Analytics use case(s): **Population-Level Estimation**
- Study type: **Clinical Application**
- Tags: **Study-a-thon, COVID-19**
- Study lead: **Marc A. Suchard, Seng Chan You, Mitchell M. Conover**
- Study lead forums tag: **[msuchard](https://forums.ohdsi.org/u/msuchard),  [SCYou](https://forums.ohdsi.org/u/scyou/), [Conovermitch](https://forums.ohdsi.org/u/Conovermitch)**
- Study start date: **March 26, 2020**
- Study end date: **-**
- Protocol: **[Word Doc](https://github.com/ohdsi-studies/Covid19EstimationRasInhibitors/blob/master/Documents/COVID19_ACE_ARB_Protocol_Version_1_0.docx)**
- Publications: **-**
- Results explorer: **[Shiny app](https://data.ohdsi.org/Covid19EstimationAceInhibitors/)**

This study will evaluate the effect of ACE inhibitor or ARB exposure on the risk of contracting COVID-19 infection and the risk of experiencing respiratory failure, pneumonia, acute kidney injury, and death in hypertensive patients following contracting COVID-19 infection.  The analysis will be undertaken across a federated multi-national network of electronic health records and administrative claims from primary care and secondary care that have been mapped to the Observational Medical Outcomes Partnership Common Data Model in collaboration with the Observational Health Data Sciences and Informatics (OHDSI) and European Health Data and Evidence Network (EHDEN) initiatives.  These data reflect the clinical experience of patients from six European countries (Belgium, Netherlands, Germany, France, Spain, and Estonia) the United Kingdom, the United States of America, South Korea, and Japan as data becomes available.  We will use a prevalent user cohort design to estimate the relative risk of each outcome using an on-treatment analysis of monotherapy only and monotherapy or combo-therapy comparisons.  In the analysis of respiratory failure, pneumonia, acute kidney injury, and death, we will conduct separate analyses assessing prevalent use of antihypertensives at the time of any diagnosis with COVID-19 or at the time of an inpatient admission with COVID-19 diagnosis. Data driven approaches will be used to identify potential covariates for inclusion in matched or stratified propensity score models identified using regularized logistic regression. Large-scale propensity score matching and stratification strategies that allow balancing on a large number of baseline potential confounders will be used in addition to negative control outcomes to allow for evaluating residual bias in the study design as a whole as a diagnostic step.

This study is part of the [OHDSI 2020 COVID-19 study-a-thon](https://www.ohdsi.org/covid-19-updates/).

Requirements
============

- A database in [Common Data Model version 5](https://github.com/OHDSI/CommonDataModel) in one of these platforms: SQL Server, Oracle, PostgreSQL, IBM Netezza, Apache Impala, Amazon RedShift, or Microsoft APS.
- R version 3.5.0 or newer
- On Windows: [RTools](http://cran.r-project.org/bin/windows/Rtools/)
- [Java](http://java.com)
- 25 GB of free disk space

See [this video](https://youtu.be/K9_0s2Rchbo) for instructions on how to set up the R environment on Windows.

How to run
==========
1. This study consists of two analyses: [Incidence](https://github.com/ohdsi-studies/Covid19EstimationRasInhibitors/tree/master/Covid19IncidenceRasInhibitors) and [Complications](https://github.com/ohdsi-studies/Covid19EstimationRasInhibitors/tree/master/Covid19ComplicationsRasInhibitors)

2. You will ultimately build two separate libraries for these analysis: Covid19IncidenceRasInhibitors (the Incidence study) and COVID5ACESeverity (the Complications study). Each Analysis folder has specific instructions on how to install the study library.
 
 *Note: If you encounter errors in devtools pulling the study packages, you may find it easier to download the repo zip locally and uploading it through your RStudio console. Instructions to upload packages are provided in [The Book of OHDSI](https://ohdsi.github.io/TheBookOfOhdsi/PopulationLevelEstimation.html#running-the-study-package).*

3. When completed, the output will exist as a .ZIP file in the `export` directory in the `output` folder location. This file contains the results to submit to the study lead. To do so, please use the function below.  You must supply the directory location to where you have saved the `<study key name>.dat` file to the `privateKeyFileName` argument. You must contact the [study coordinator](mailto:kristin.kostka@iqvia.com) to receive the required private key.

  ```r
	keyFileName <- "<directory location of where you saved the study key name.dat>"
	username <- "study-data-site-covid19"
	OhdsiSharing::sftpUploadFile(privateKeyFileName = keyFileName,
                             userName = userName,
                             remoteFolder = "Covid19EstimationRasInhibitors",
                             fileName = "<directory location of outputFolder/export>")
  ```
  
License
=======
The Covid19IncidenceRasInhibitors (the Incidence study) and COVID5ACESeverity (the Complications study) packages are licensed under Apache License 2.0
