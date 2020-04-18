# Create negative control list

controlFile <- system.file("settings", "NegativeControls.csv", package = "Covid19ComplicationsRasInhibitors")
controlData <- unique(read.csv(controlFile)[, c("outcomeId", "outcomeName", "type")])
controlId <- controlData$outcomeId
controlName <- as.character(controlData$outcomeName)
which <- grepl(",", controlName)
controlName[which] <- paste0("\"", controlName[which], "\"")

tcs <- read.csv(system.file("settings", "TcosOfInterest.csv", package = "Covid19ComplicationsRasInhibitors"))[, c("targetId", "comparatorId")]
tcs.list <- split(tcs, seq(nrow(tcs)))

makeTcos <- function(row) {
  data.frame(targetId = row$targetId,
             comparatorId = row$comparatorId,
             outcomeId = controlId,
             outcomeName = controlName,
             type = "outcome")
}


result <- do.call("rbind", 
                  lapply(tcs.list, makeTcos))

write.csv(result, file = "NegativeControls.csv", quote = FALSE, row.names = FALSE)

