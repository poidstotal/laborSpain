## this file will contain code to generage base data for analysis. Please do not include location settings.

setwd("/Volumes/WorkSpace/ptmDrive/research/PhD/Docs/laborSpain")

data <- read_excel("./data/Data.xlsx" )
data <-  as.data.table(data)


names(data) <- c("year", "age", "sex", "img", "whx", "wpx", "pop")

data[, ageg := gsub("from", "", age)]
data[, ageg := gsub("more", "", age)]
data[, ageg := gsub("to", "-", age)]
data[, ageg := gsub("and", "+", age)]
data[, ageg := gsub(" ", "", age)]
