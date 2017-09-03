library(RWeka)

bankdata <- read.csv("bankdata.csv")
View(bankdata)
AdaboostModel <- AdaBoostM1(pep~., data=bankdata, control=Weka_control(W=list(J48)))
adaboostpred <- bankdata
adaboostpred$predictions <- predict(AdaboostModel)
adaboostpred[1:10,]

summary(AdaboostModel)
