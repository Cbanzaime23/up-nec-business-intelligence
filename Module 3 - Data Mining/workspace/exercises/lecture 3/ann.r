library(RWeka)

creditsetnumeric <- read.csv("creditsetnumeric.csv")
creditsetnumeric$default10yr <- as.factor(creditsetnumeric$default10yr)

MLP <- make_Weka_classifier("weka/classifiers/functions/MultilayerPerceptron")
ANNModel <- MLP(default10yr~., data=creditsetnumeric, control = Weka_control(H='5'))

creditsettest = read.csv("creditsettest.csv")
creditsettest$predictions <- predict(ANNModel, creditsettest)
creditsettest

summary(ANNModel)
