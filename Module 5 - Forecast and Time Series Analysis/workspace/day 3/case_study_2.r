# NEC_BI.Module5.Day3.pdf - pg. 111
# Case 2 Airlines and Chocolates.doc

library(TTR)
library(forecast)
library(partykit)

# 1. Decomposition
airline = read.csv("airline.csv")
airline

airlinets <- ts(airline[, 2] ,frequency=12, start= c(1949,1))
airlinets
airlinetsSMA2 <- SMA(chocolatests,n=2)
airlinetsSMA10 <- SMA(chocolatests, n=10)
airlinetsSMA20 <- SMA(chocolatests, n=20)
total <- cbind(airlinets, airlinetsSMA2, airlinetsSMA10, airlinetsSMA20)
plot(total, plot.type ="single", col = 1:ncol(total), lwd = c(2, 2, 2,2))
legend("bottomright", colnames(total), col=1:ncol(total), lty = c(1,1,1,1), cex =.5, y.intersp = 1)

airlinetscomponents <- decompose(airlinets)
airlinetscomponents
airlinetscomponents$x
plot(airlinetscomponents$seasonal)
plot(airlinetscomponents$trend)
plot(airlinetscomponents$random)
plot(airlinetscomponents)

# add more planes or airports

# 2. Forecasting using R 
chocolates = read.csv("Chocolates.csv")
chocolates

chocolatests <- ts(chocolates[, 2] ,frequency=4, start= c(1957,3))
chocolatests

# a. Simple Moving Average
chocolatestsSMA2 <- SMA(chocolatests,n=2)
chocolatestsSMA10 <- SMA(chocolatests, n=10)
chocolatestsSMA20 <- SMA(chocolatests, n=20)

total <- cbind(chocolatests, chocolatestsSMA2, chocolatestsSMA10, chocolatestsSMA20)
plot(total, plot.type ="single", col = 1:ncol(total), lwd = c(2, 2, 2,2))
legend("bottomright", colnames(total), col=1:ncol(total), lty = c(1,1,1,1), cex =.5, y.intersp = 1)

# b. Single Exponential Smoothing
chocolatestssesa01 <- HoltWinters(chocolatests, alpha = .1, beta = F, gamma = F)
chocolatestssesa02 <- HoltWinters(chocolatests, alpha = .2, beta = F, gamma = F)
chocolatestssesa09 <- HoltWinters(chocolatests, alpha = .9, beta = F, gamma = F)

total <- cbind(chocolatests, chocolatestssesa01$fitted[,1], chocolatestssesa02$fitted[,1], chocolatestssesa09$fitted[,1])
plot(total, plot.type = "single", col = 1:ncol(total), lwd = c(2,2,2))
legend("bottomright", c("Original", "0.1", "0.2", "0.9"), col = 1:ncol(total), lty = c(1,1), cex = .5, y.intersp =1)

chocolatestssesforecast01 <- forecast(chocolatestssesa01, h = 12)
chocolatestssesforecast02 <- forecast(chocolatestssesa02, h = 12)
chocolatestssesforecast09 <- forecast(chocolatestssesa09, h = 12)

chocolatestssesforecast01
chocolatestssesforecast02
chocolatestssesforecast09

plot(chocolatestssesforecast01)
plot(chocolatestssesforecast02)
plot(chocolatestssesforecast09)

# c. Double Exponential Smoothing
chocolatestsdep <- HoltWinters(chocolatests, alpha = .2, beta = .4, gamma = F)
total <- cbind(chocolatests, chocolatestsdep$fitted[,1])
plot(total, plot.type = "single", col = 1:ncol(total), lwd = c(2,2))
legend("bottomright", c("Original", "Double exp"), col = 1:ncol(total), lty = c(1,1), cex = .5, y.intersp =1)

chocolatestsdepforecast <- forecast(chocolatestsdep, h = 12)
plot(chocolatestsdepforecast)

accuracy(chocolatestsdepforecast)

# d. Decomposition
chocolatestscomponents <- decompose(chocolatests)
chocolatestscomponents
plot(chocolatestscomponents)
chocolatestscomponents$random
chocolatestscomponents$trend

# starting here please verify from pam's solution

#chocolatestsseasonallyadjusted <- chocolatests - chocolatestscomponents$seasonal
#plot(chocolatestsseasonallyadjusted)
#chocolatestsseasonallyadjusted

# Which of the above stated forecasting tools is/are appropriate for the Chocolates dataset?
accuracy(chocolatestsSMA2, chocolatests)
accuracy(chocolatestsSMA5, chocolatests)
accuracy(chocolatestsSMA10, chocolatests)
accuracy(chocolatestssesforecast01)
accuracy(chocolatestssesforecast02)
accuracy(chocolatestssesforecast09)
accuracy(chocolatestsdepforecast)

# Forecast plan
fit <- tslm(chocolatests~trend + season)
summary(fit)
plot(forecast(fit, h=20))

chocolatesfit <- tslm(chocolatests~trend + season, data = chocolatests)
summary(chocolatesfit)
plot(forecast(chocolatesfit, h = 20))