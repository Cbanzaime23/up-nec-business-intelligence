# Crosscut - BEGIN
library(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
getwd()
# Crosscut - END

library(RWeka)

bankdata <- read.csv("Bank Data.csv")
J48Model <- J48(pep ~ ., data = bankdata)

J48Model
summary(J48Model)
plot(J48Model)

LRFit=lm(pep ~ ., data= bankdata)
summary(LRFit)
