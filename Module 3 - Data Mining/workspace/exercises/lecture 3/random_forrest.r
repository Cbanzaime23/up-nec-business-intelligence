library(RWeka)

adult <- read.csv("adult.csv")

RF <- make_Weka_classifier("weka/classifiers/trees/RandomForest")

RFModel <- RF(income~., data = adult, control = Weka_control(K=1))
summary(RFModel)
adult$predictions <- predict(RFModel, adult, se.fit = T)
adult[1:10,]

