library(RWeka)
library(ROCR)

churndata <- read.csv("churndata.csv")

#summary(churndata)
#str(churndata)
#View(churndata)


# 2.1. Modeling a Decision Tree
J48Model <- J48(Churn.~., data = churndata)
summary(J48Model)
evaluate_Weka_classifier(J48Model,
                         newdata=churndata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

## 2.1.1. Accuracy: 94.2694 %
## 2.1.2. Confusion Matrix:
## === Confusion Matrix ===
##   
##    a     b   <-- classified as
## 2803    47 |    a = False.
##  140   343 |    b = True.
## 
## 2.1.3. True Positive Rate of Churn=True Class: 0.982
## 2.1.4. Precision of Churn=True Class: 0.952
## 2.1.5. ROC Area of Churn=True Class: 0.834

# 2.2 Creating a Rule Based Classifier
JRipModel <- JRip(Churn.~., data = churndata)
evaluate_Weka_classifier(JRipModel,
                         newdata=churndata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

## 2.2.1. Accuracy: 95.1095 %
## 2.2.2. Confusion Matrix:
## === Confusion Matrix ===
##   
##    a    b   <-- classified as
## 2796   54 |    a = False.
##  109  374 |    b = True.
## 
## 2.2.3. True Positive Rate of Churn=True Class: 0.981
## 2.2.4. Precision of Churn=True Class: 0.962
## 2.2.5. ROC Area of Churn=True Class: 0.876


## 2.3. Creating an ANN
MLP <- make_Weka_classifier("weka/classifiers/functions/MultilayerPerceptron")
ANNModel <- MLP(Churn.~., data=churndata, control = Weka_control(H='5'))
evaluate_Weka_classifier(ANNModel,
                         newdata=churndata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

## 2.3.1. Accuracy: 94.3894 %
## 2.3.2. Confusion Matrix:
## === Confusion Matrix ===
##   
##    a    b   <-- classified as
## 2801   49 |    a = False.
##  138  345 |    b = True.
## 
## 2.3.3. True Positive Rate of Churn=True Class: 0.983
## 2.3.4. Precision of Churn=True Class: 0.953
## 2.3.5. ROC Area of Churn=True Class: 0.905

## 2.4. Creating an Adaboost Learner with Rule Classifiers
AdaboostModel <- AdaBoostM1(Churn.~., data=churndata, control=Weka_control(W=list(JRip)))
evaluate_Weka_classifier(AdaboostModel,
                         newdata=churndata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

## 2.4.1. Accuracy: 94.9595 %
## 2.4.2. Confusion Matrix:
## === Confusion Matrix ===
##   
##    a    b   <-- classified as
## 2801   49 |    a = False.
##  119  364 |    b = True.
## 
## 2.4.3. True Positive Rate of Churn=True Class: 0.983
## 2.4.4. Precision of Churn=True Class: 0.959
## 2.4.5. ROC Area of Churn=True Class: 0.903

## 2.5. Creating a Random Forest Model
RF <- make_Weka_classifier("weka/classifiers/trees/RandomForest")
RFModel <- RF(Churn.~., data=churndata, control = Weka_control(K=1))
evaluate_Weka_classifier(RFModel,
                         newdata=churndata,
                         numFolds = 10,
                         class = T,
                         seed = 1)

## 2.5.1. Accuracy: 90.249  %
## 2.5.2. Confusion Matrix:
## === Confusion Matrix ===
##   
##    a    b   <-- classified as
## 2847    3 |    a = False.
##  322  161 |    b = True.
## 
## 2.5.3. True Positive Rate of Churn=True Class: 0.999
## 2.5.4. Precision of Churn=True Class: 0.898
## 2.5.5. ROC Area of Churn=True Class: 0.909

## 3. ROC Curves
sample <- floor(.67 * nrow(churndata))
set.seed(123)
train_ind <- sample(seq_len(nrow(churndata)), size = sample)
churndatatrain <- churndata[train_ind,]
churndatatest <- churndata[-train_ind,]

J48ModelROC <- J48(Churn.~., data = churndatatrain)
JRipModelROC <- JRip(Churn.~., data = churndatatrain)
ANNModelROC <- MLP(Churn.~., data=churndatatrain, control = Weka_control(H='5'))
AdaboostModelROC <- AdaBoostM1(Churn.~., data=churndatatrain, control=Weka_control(W=list(JRip)))
RFModelROC <- RF(Churn.~., data=churndatatrain, control = Weka_control(K=1))

labels <- ifelse(churndatatest$Churn. == "True.", 1 ,0)

predictions <- cbind(predict(J48ModelROC,
                             newdata = churndatatest,
                             type = c("probability"))[,c("True.")],
                     predict(JRipModelROC,
                             newdata = churndatatest,
                             type = c("probability"))[,c("True.")],
                     predict(ANNModelROC,
                             newdata = churndatatest,
                             type = c("probability"))[,c("True.")],
                     predict(AdaboostModelROC,
                             newdata = churndatatest,
                             type = c("probability"))[,c("True.")],
                     predict(RFModelROC,
                             newdata = churndatatest,
                             type = c("probability"))[,c("True.")]
                )

labels <- cbind(labels, labels,labels,labels,labels) # labels must have the same count with the models you have
pred2 <- prediction(predictions, labels)
perf2 <- performance(pred2, "tpr", "fpr")
plot(perf2, col = list("red", "blue", "yellow", "black", "green"))
legend("bottomright", 
       legend = c("J48Model", "JRipModel", "ANNModel", "AdaboostModel", "RFModel"), 
       col = c("red", "blue", "yellow", "black", "green"),
       lty = 1:1,
       cex = 0.8)