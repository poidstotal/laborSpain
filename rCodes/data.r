## this file will contain code to generage base data for analysis. Please do not include location settings.



data <- read_excel("./data/Data.xlsx" )
data <-  as.data.table(data)
names(data) <- c("year", "age", "sex", "img", "whx", "wpx", "pop")

## remove strings from age
data[, age := gsub("from", "", age)]
data[, age := gsub("more", "", age)]
data[, age := gsub("to", "-", age)]
data[, age := gsub("and", "+", age)]
data[, age := gsub(" ", "", age)]


## recode ages into ageg
data[age %in% c("16-24", "25-34" ), ageg := "Young(16-34)"]
data[age %in% c("35-44", "45-54" ), ageg := "Adult(35-54)"]
data[age  == "55+", ageg := "Older(55+)"]

## convert pop and wpx
# assume 50 week per year
data[, whx := 50*whx]
# total labour
data[, lab := whx*wpx*pop]
labdta <- data[, .(lab = sum(lab)), by = .(year, ageg, sex, img)]
# add lines for total male and female
labdta <- rbind(labdta[, .(lab = sum(lab), sex = "Total"), by = .(year, ageg, img)], labdta)

saveRDS(labdta, "./data/labdta.rds")












## compute total populaiton by year, img and sex
data[, tPop := sum(pop), by = .(year, sex, img)]
## compute population structure as proxy for aging
data[, pStr := pop/tPop]
