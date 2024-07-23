## see local.r for folder settings
labdta <- readRDS("./data/labdta.rds")

################################################
## Descriptives Stats use in Paper
################################################





plotDta <- labdta[, .(lab = sum(lab)), by = .(year, ageg, sex, img)]
# add lines for total male and female
plotDta <- rbind(plotDta[, .(lab = sum(lab), sex = "Total"), by = .(year, ageg, img)], plotDta)