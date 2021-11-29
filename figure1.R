library(tidyverse);

studalc <- read.csv("https://raw.githubusercontent.com/clementiaboo/bios-611-project/main/studalc.csv") %>%
  mutate(Gedu = factor(Gedu, 
                       levels = c("None", "Primary", "Middle", "Secondary", "Higher"),
                       labels = c("Minimal", "Minimal", "Middle", 
                                  "Secondary", "Higher")), 
         freetime = factor(freetime, c("Very Low", "Low", "Medium", "High", "Very High")), 
         famrel = factor(famrel, c("Very Bad", "Bad", "Neutral", "Good", "Excellent")), 
         G4 = as.factor(G4))

studalc %>%
  mutate(G4 = ifelse(G4 == 1, "Increased", "Decreased")) 

p <- ggplot(data=studalc, aes(x = G1, y = G2, colour = G4)) + 
  geom_point(position = position_jitter(.3, .3)) + 
  geom_abline(aes(slope = 1, intercept = 0), linetype = "dashed", 
              colour = "grey", size = 2) + 
  ylim(-1, 20) + xlim(-1, 20)

ggsave("figures/figure1.png", plot=p)

