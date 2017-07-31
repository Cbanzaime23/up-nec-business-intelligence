bankdata <- read.csv("bankdata.csv")

# Descriptive Analytics and Visualization
library(pastecs)
options(scipen=100, digits=2)

stat.desc(bankdata)
write.csv(stat.desc(bankdata), file = "NumericalStatistics.csv")

summary(bankdata)
write.csv(summary(bankdata), file = "CategoricalStatistics.csv")

## What is the range of values of the Age variable? What is the minimum, maximum and middle value?
min(bankdata$age)
mean(bankdata$age)
max(bankdata$age)

## How many customers have a savings account? Current account?
sum(bankdata$save_act == 'YES')
sum(bankdata$current_act == 'YES')

xtabs(~married+children,data=bankdata)

# Calculate the means of Age, Income and Children by PEP, Married and has Car
library(reshape)
bankdata.m = melt(bankdata, id=c("pep","married", "car"), measure=c("age", "income", "children"))
bankdata.c = cast(bankdata.m, pep + married + car ~ variable, mean)
bankdata.c
write.csv(bankdata.c , file = "bankdataByPepStatusCar.csv")

## As Age increases, what pattern do you see in terms of buying a PEP?
## As the age increases, more possiblity to buy PEP

## In terms of the number of children what pattern do you see in terms of buying a PEP? For Being Married?
## No pattern

# Calculate for a histogram of the Income variable
hist(bankdata$income,breaks=15, col="green",xlab="Income",main="Histogram of Income")

# Calculate for a box plot of the Income variable by PEP
boxplot(income~pep,data=bankdata, main="Income by PEP Response", xlab="PEP Response", ylab="Income", col="green")

## What can you generalize from this Box Plot?
## Higher income has more possiblity to buy PEP

## Are there any outliers?
## Yes

# Generate a box plot of the Income variable by region
boxplot(income~region,data=bankdata, main="Income by Region", xlab="Region", ylab="Income", col="green")

## What can you generalize from this Box Plot?
## Rural has likely has more income

# Plot a scatter plot matrix of the Income, Age and # of Children
library(car)
scatterplotMatrix(~age+children+income|pep,data=bankdata,main="Age Children and Income by PEP")

## What can you generalize from this Scatter Plot?
## Age vs Children
### If you have more children, less likely will not buy PEP
### If you are older and has children, you mostly buy PEP
## Income
### Higher income buys PEP

# Normalize the Income Column into a [0,1] scale
IncomeData = bankdata[,5]
NormalizedIncomeData = (IncomeDatamin(IncomeData))/(max(IncomeData)-min(IncomeData))
bankdata = cbind(bankdata,NormalizedIncomeData )
View(bankdata)

# create an equal depth(frequency) variable for Income where the new variable could take in Low, Medium and High.
bins=3
cutpoints=quantile(IncomeData,(0:bins)/bins)
DiscreteIncome =cut(IncomeData, cutpoints, include.lowest=TRUE,
                      dig.lab=5, labels=c("Low", "Med", "High"))
bankdata = cbind(bankdata, DiscreteIncome)
View(bankdata)

# create dummy variables for the four values of Region
indicators=model.matrix( ~ region - 1, data = bankdata)
bankdata = cbind(bankdata,indicators)
View(bankdata)

# Sample 100 rows of the bank data without replacement
Samplebankdata = bankdata[sample(nrow(bankdata),100,replace = FALSE),]
View(Samplebankdata)

