library(tidyverse);

p <- ggplot(data=studalc, aes(x = G1, y = G2, colour = G4)) + 
  geom_point(position = position_jitter(.3, .3)) + 
  geom_abline(aes(slope = 1, intercept = 0), linetype = "dashed", 
              colour = "grey", size = 2) + 
  ylim(-1, 20) + xlim(-1, 20)

ggsave("figures/figure1.png", plot=p)

