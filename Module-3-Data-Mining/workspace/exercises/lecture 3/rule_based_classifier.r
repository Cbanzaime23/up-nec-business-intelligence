install.packages("rJava")
library("RWeka")

bankdata <- read.csv("bankdata.csv")
J48Model <- J48(pep~., data=bankdata)
J48Model
plot(J48Model)