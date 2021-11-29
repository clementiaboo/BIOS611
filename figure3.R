library(tidyverse)
library(gridExtra)

studalc <- read.csv("https://raw.githubusercontent.com/kwonjhk/StudentAlcohol/master/Data/studalc-por.csv") %>%
  mutate(Gedu = factor(Gedu, 
                       levels = c("None", "Primary", "Middle", "Secondary", "Higher"),
                       labels = c("Minimal", "Minimal", "Middle", 
                                  "Secondary", "Higher")), 
         freetime = factor(freetime, c("Very Low", "Low", "Medium", "High", "Very High")), 
         famrel = factor(famrel, c("Very Bad", "Bad", "Neutral", "Good", "Excellent")), 
         G4 = as.factor(G4))

set.seed(1)
test = sample(1:nrow(studalc), 100)

g1 = ggplot(studalc) + 
  geom_point(aes(x = studytime, y = G3, colour = G3), 
             position = position_jitter(0.25, 0.25)) + 
  scale_color_gradient(low="blue", high="orange") + 
  theme(legend.position = "none")

g2 = ggplot(studalc) + 
  geom_point(aes(x = failures, y = G3, colour = G3), 
             position = position_jitter(0.25, 0.25)) + 
  scale_color_gradient(low="blue", high="orange") + ylab("") + 
  theme(legend.position = "none")

p <- grid.arrange(g1, g2, ncol = 2)

ggsave("figures/figure3.png", plot=p)