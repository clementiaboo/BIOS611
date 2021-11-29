library(tidyverse);

studalc <- read.csv("https://raw.githubusercontent.com/clementiaboo/bios-611-project/main/studalc.csv") %>%
  mutate(Gedu = factor(Gedu, 
                       levels = c("None", "Primary", "Middle", "Secondary", "Higher"),
                       labels = c("Minimal", "Minimal", "Middle", 
                                  "Secondary", "Higher")), 
         freetime = factor(freetime, c("Very Low", "Low", "Medium", "High", "Very High")), 
         famrel = factor(famrel, c("Very Bad", "Bad", "Neutral", "Good", "Excellent")), 
         G4 = as.factor(G4));

set.seed(1)
test = sample(1:nrow(studalc), 100)

write_csv(studalc, 'derived_data/studalc.csv')


