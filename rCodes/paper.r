## see local.r for folder settings
data <- readRDS("./data/data.rds")
## load config
source("./rCodes/config.r")
################################################
## Descriptives Stats use in Paper
################################################

sepline <- ggplot()+ 
    geom_vline(xintercept = 1, linetype = "dashed",size = 0.1) + 
    geom_vline(xintercept = 1.925, linetype = "dashed",size = 0.1) +
    scale_x_continuous(limits = c(0, 3)) +
    theme_void()



########################
## Participation
########################
## compute data
library(Hmisc)
wpxDta <- data[, .(wpx = wtd.mean(wpx, pop)), by = .(year, ageg, img)]

# create plot
plot <- ggplot(wpxDta, mapping = aes(
    y = wpx, x = year, color = img, linetype = img,
    group = img, shape = img
    )) +
    mygthemep + 
    geom_line(linewidth = 1) +
    facet_grid(cols = vars(ageg)) +
    scale_y_continuous(
    breaks = seq(0, 100, by = 20),
    limits = c(0, 101),
    sec.axis = dup_axis()  # Add secondary axis as duplicate
    ) +
    scale_x_continuous(
    breaks = seq(2005, 2025, by = 3),
    limits = c(2005, 2025)
    ) +
    labs(y = "%") +
  ## separator
    inset_element(sepline, left = -0.1, bottom = 0.1, right = 1.1, top = 0.9)

# dev.off()
# plot
## save the plot
ggsave(file.path("./graph/wpx.png"), plot, width = 10, height = 4)


########################
## Hours worked
########################
## compute data
library(Hmisc)
whxDta <- data[, .(whx = wtd.mean(whx, pop)), by = .(year, ageg, img)]

# create plot
plot <- ggplot(whxDta, mapping = aes(
    y = whx, x = year, color = img, linetype = img,
    group = img, shape = img
    )) +
    mygthemep + 
    geom_line(linewidth = 1) +
    facet_grid(cols = vars(ageg)) +
    scale_y_continuous(
        breaks=seq(1800,2600,by=200), 
        limits = c(1800,2600),
        name = "annual hours",
        sec.axis = sec_axis(~ ./50, breaks=seq(36,52,by=4), name = "weekly hours")) +
    scale_x_continuous(
        breaks = seq(2005, 2025, by = 3),
        limits = c(2005, 2025)
    ) +
  ## separator
    inset_element(sepline, left = -0.1, bottom = 0.1, right = 1.1, top = 0.9)

# dev.off()
# plot
## save the plot
ggsave(file.path("./graph/whx.png"), plot, width = 10, height = 4)



########################
## Hours stx
########################
## compute total populaiton by year, img and sex
stxDta <-  data[, .(pop = sum(pop)), by = .(year, ageg, img)]
## total pop img + native
stxDta[, tPop := sum(pop), by = .(year, ageg)]
## compute population structure as proxy for aging
stxDta <-  stxDta[, .(stx = 100*pop/tPop), by = .(year, ageg, img)]

# create plot
# create plot
plot <- ggplot(stxDta, mapping = aes(
    y = stx, x = year, color = img, linetype = img,
    group = img, shape = img
    )) +
    mygthemep + 
    geom_line(linewidth = 1) +
    facet_grid(cols = vars(ageg)) +
    scale_y_continuous(
    breaks = seq(0, 100, by = 20),
    limits = c(0, 101),
    sec.axis = dup_axis()  # Add secondary axis as duplicate
    ) +
    scale_x_continuous(
    breaks = seq(2005, 2025, by = 3),
    limits = c(2005, 2025)
    ) +
    labs(y = "%") +
  ## separator
    inset_element(sepline, left = -0.1, bottom = 0.1, right = 1.1, top = 0.9)

# dev.off()
# plot
## save the plot
ggsave(file.path("./graph/stx.png"), plot, width = 10, height = 4)
