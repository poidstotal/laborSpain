## see local.r for folder settings
data <- readRDS("./data/data.rds")
## load config
source("./rCodes/config.r")
################################################
## Descriptives Stats use in Paper
################################################



########################
## Participation
########################
library(Hmisc)
wpxDta <- data[, .(wpx = wtd.mean(wpx, pop)), by = .(year, ageg, img)]



plot <- ggplot(wpxDta, mapping = aes(
  y = wpx, x = year, color = img, linetype = img,
  group = img, shape = img
)) +
  mygthemep + 
   theme(panel.background = element_rect(fill = NA, color = "black"))+
  geom_line(linewidth = 1) +
 geom_vline(xintercept = 2024, linetype = "dashed",size = 0.1  )+
  facet_grid(cols = vars(ageg)) +
  scale_y_continuous(
    breaks = seq(0, 100, by = 20),
    limits = c(0, 101),
    sec.axis = dup_axis()  # Add secondary axis as duplicate
  ) +
  scale_x_continuous(
    breaks = seq(2006, 2023, by = 4),
    limits = c(2006, 2024)
  ) +
  labs(y = "%")
# dev.off()

ggsave(file.path("./graph/wpx.png"), plot, width = 10, height = 4)



segments <- ggplot(data = data.frame(x = c(0, 2, 2, 4, 4, 6),
                                     y = c(2, 2, 1, 1, 0, 0)),
                   aes(x=x, y=y)) +
  geom_path() +
  theme_void()
