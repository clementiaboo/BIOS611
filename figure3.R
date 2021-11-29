library(tidyverse)
library(gridExtra)
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