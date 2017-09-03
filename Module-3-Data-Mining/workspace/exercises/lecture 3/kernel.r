library(RWeka)

creditsetnumericSMO <- read.csv("creditsetnumeric.csv")
creditsetnumericSMO$default10yr <- as.factor(creditsetnumericSMO$default10yr)

SVMModel <- SMO(default10yr~., data = creditsetnumericSMO, control = Weka_control(C='1', K = list("PolyKernel", E=2)))

creditsettest = read.csv("creditsettest.csv")
creditsettest$predictions <- predict(SVMModel, creditsettest)
creditsettest

summary(SVMModel)
