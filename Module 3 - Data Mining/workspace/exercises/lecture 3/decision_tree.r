library(RWeka)

# Decision tree
bankdata <- read.csv("bankdata.csv")
J48Model <- J48(pep~., data = bankdata)
J48Model
plot(J48Model)

# Rule-based
JRipModel <- JRip(pep ~ ., data = bankdata)
JRipModel
