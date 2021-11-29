library(tidyverse)
library(leaps)
library(glmnet)

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
set.seed(1)
test = sample(1:nrow(studalc), 100)

ShowSubsets=function(regout){
  z=summary(regout)
  q=as.data.frame(z$outmat)
  q$Rsq=round(z$rsq*100,2)
  q$adjRsq=round(z$adjr2*100,2)
  q$Cp=round(z$cp,2)
  return(q)
}


all = regsubsets(G3~schoolsup+famsup+paid+absences+studytime+failures+reason+firstgen, data=studalc[-test,], method="exhaustive")

best.lm = lm(G3~schoolsup+studytime+failures+reason+firstgen, 
             data = studalc[-test,])

full = lm(G3~schoolsup+famsup+paid+absences+studytime+
            failures+reason+firstgen, 
          data = studalc[-test,])

all2 = regsubsets(G3~(schoolsup+famsup+paid+absences+studytime+failures+reason+firstgen)^2, data = studalc, method = "forward")

best.lm2 = lm(G3~(studytime+failures+reason+schoolsup:studytime+schoolsup:failures+famsup:reason+absences:failures+studytime:reason), data = studalc[-test,])

full2 = lm(G3~(schoolsup+famsup+paid+absences+studytime+failures+reason+firstgen)^2, data=studalc[-test,])

best.step2 = step(full2, scale=(summary(full2)$sigma)^2, trace = FALSE, direction = "backward")

edu = model.matrix(~(schoolsup + famsup + paid + absences + studytime + failures + reason + firstgen)^2 - 1, studalc[-test,])

edu.test = model.matrix(~(schoolsup + famsup + paid + absences + studytime + failures + reason + firstgen)^2 - 1, studalc[test,])

G3 = model.matrix(~G3 - 1, studalc[-test,])


#use 10-fold CV to find best lambda for ridge and lasso
set.seed(5)
lasso = cv.glmnet(x = edu, y = G3, alpha = 1, nfolds = 10)

ridge = cv.glmnet(x = edu, y = G3, alpha = 0, nfolds = 10)

#get test RMSE for each model
G3.errors = numeric(7)
G3.errors[1] = sqrt(mean(studalc[test,"G3"] - 
                           predict(full, studalc[test,]))^2)
G3.errors[2] = sqrt(mean(studalc[test,"G3"] - 
                           predict(best.lm, studalc[test,]))^2)
G3.errors[3] = sqrt(mean(studalc[test,"G3"] - 
                           predict(full2, studalc[test,]))^2)
G3.errors[4] = sqrt(mean(studalc[test,"G3"] - 
                           predict(best.lm2, studalc[test,]))^2)
G3.errors[5] = sqrt(mean(studalc[test,"G3"] - 
                           predict(best.step2, studalc[test,]))^2)
G3.errors[6] = sqrt(mean(studalc[test,"G3"] - 
                           predict(lasso, edu.test))^2)
G3.errors[7] = sqrt(mean(studalc[test,"G3"] - 
                           predict(ridge, edu.test))^2)

q2.models = c("Full", "Best",
              "Full2", "Best2", "Back2", "Lasso", 
              "Ridge")

fills=c("Full","Best Subsets","Full","Best Subsets","Backward","Lasso","Ridge")

q2.errors = data.frame(model = q2.models, RMSE = G3.errors, fills) %>%
  mutate(model = factor(model, levels = c("Full2", "Full",
                                          "Back2", "Best", "Ridge", "Lasso", 
                                          "Best2")))

p <- ggplot(q2.errors) + geom_col(aes(x = model, y = RMSE,fill=fills)) +
  scale_fill_discrete(name = "Model Technique", labels = c("Backward","Best Subsets","Full","Lasso","Ridge"))+
  xlab("Models") + ylab("Test RMSE") +coord_flip() + ggtitle("Model Comparisons by RMSE")

ggsave("figures/figure2.png", plot=p)