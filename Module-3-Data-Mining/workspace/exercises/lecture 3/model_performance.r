library(RWeka)

# without unseen dataset
bankdata <- read.csv("bankdata.csv")
J48Model <- J48(pep~., data = bankdata)
summary(J48Model)
plot(J48Model)

# with unseen dataset
sample <- floor(2/3 * nrow(bankdata))
set.seed(123)

train_ind <- sample(seq_len(nrow(bankdata)),
                    size = sample)

bankdatatrain <- bankdata[train_ind,] # 2/3 of bankdata
bankdatatest <- bankdata[-train_ind,] # 1/3 of bankdata

J48ModelHoldout <- J48(pep~., data=bankdatatrain)
summary(J48ModelHoldout)
evaluate_Weka_classifier(J48ModelHoldout,
                         newdata=bankdatatest)


View(bankdatatest)

# Cross validation
J48Model <- J48(pep~., data = bankdata)
summary(J48Model)
evaluate_Weka_classifier(J48Model,
                         newdata=bankdata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

# Overfitting
J48Overfit <- J48(pep~., data = bankdata, control = Weka_control(U=T)) # using unprunned tree. Letting the model grow by itself with no limitations.
?Weka_control
WOW(J48)
J48Overfit
summary(J48Overfit)
evaluate_Weka_classifier(J48Overfit,
                         newdata = bankdata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

# Underfitting
J48Overfit <- J48(pep~., data = bankdata, control = Weka_control(M=30)) # M=30 means you are limiting to 30 leaves only for the tree
J48Overfit
summary(J48Overfit)
evaluate_Weka_classifier(J48Overfit,
                         newdata = bankdata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

# Fitting a pruned model
J48ModelWPrunning <- J48(pep~., data = bankdata)
J48ModelWPrunning
summary(J48ModelWPrunning)
evaluate_Weka_classifier(J48ModelWPrunning,
                         newdata = bankdata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

# Computing the cost of classification
J48Model <- J48(pep~., data = bankdata)
summary(J48Model)
evaluate_Weka_classifier(J48Model, 
                         cost = matrix(c(0,2,1,0), ncol = 2),
                         newdata=bankdata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

# ROC curves
sample <- floor(2/3 * nrow(bankdata))
set.seed(123)

train_ind <- sample(seq_len(nrow(bankdata)),
                    size = sample)

bankdatatrain <- bankdata[train_ind,] # 2/3 of bankdata
bankdatatest <- bankdata[-train_ind,] # 1/3 of bankdata

J48Model <- J48(pep~., data=bankdatatrain)
JRipModel <- JRip(pep~., data=bankdatatrain)

library(ROCR)

labels <- ifelse(bankdatatest$pep == "YES", 1 ,0)
predictions <- cbind(predict(J48Model,
                             newdata = bankdatatest,
                             type = c("probability"))[,c("YES")],
                     predict(JRipModel,
                             newdata = bankdatatest,
                             type = c("probability"))[,c("YES")]
                     )

labels <- cbind(labels, labels)
pred2 <- prediction(predictions, labels)
perf2 <- performance(pred2, "tpr", "fpr")
plot(perf2, col = list("red", "blue"))
legend("bottomright", 
           legend = c("J48Model", "JRipModel"), 
           col = c("red", "blue"),
           lty = 1:1,
           cex = 0.8)                     