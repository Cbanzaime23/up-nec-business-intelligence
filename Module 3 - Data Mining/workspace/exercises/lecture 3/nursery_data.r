library("RWeka")

nursery <- read.csv("nursery.csv")
NaiveBayes <- make_Weka_classifier("weka/classifiers/bayes/NaiveBayes")

NBModel <- NaiveBayes(rank ~ parents + has_nur + form + children + housing + finance + health, data = nursery)
summary(NBModel)

nurserytest <- read.csv("nurserytest.csv")
nurserytest$predictions = predict(NBModel, nurserytest)
nurserytest

View(nurserytest)


