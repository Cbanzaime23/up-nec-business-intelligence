# NEC_BI.Module5.Day3.pdf

# outdated pg 18, 46, 121

# Preliminary Time Series - pg.24
library(TTR)
library(forecast)
library(partykit)

a <- ts(1:20, frequency = 12, start = c(2011, 3))
print(a)
str(a)
attributes(a)

# Simple Moving Average - pg.25
births = read.csv("births.csv")

birthsts <- ts(births[, 2] ,frequency=12, start= c(1946,1))
birthstsSMA2 <- SMA(birthsts,n=2)
birthstsSMA5 <- SMA(birthsts, n=5)
birthstsSMA10 <- SMA(birthsts, n=10)
total <- cbind(birthsts, birthstsSMA2, birthstsSMA5, birthstsSMA10)
plot(total, plot.type ="single", col = 1:ncol(total), lwd = c(2, 2, 2,2))
legend("bottomright", colnames(total), col=1:ncol(total), lty = c(1,1,1,1), cex =.5, y.intersp = 1)

# Forecast accuracy - pg.27
accuracy(birthstsSMA2, birthsts)
accuracy(birthstsSMA5, birthsts)
accuracy(birthstsSMA10, birthsts)

# Weighted Moving Average - pg.29
xx <- c(.2,.3,.5)
birthstsWMA3 = WMA(birthsts, n=3, wts=xx)
birthstsWMA3

yy <- c(.1,.2,.3,.4)
birthstsWMA4 = WMA(birthsts, n=4, wts=yy)
birthstsWMA4

total <- cbind(birthsts, birthstsWMA3, birthstsWMA4)
plot(total, plot.type = "single", col = 1:ncol(total), lwd = c(2,2,2))
legend("bottomright", colnames(total), col = 1:ncol(total), lty = c(1,1,1), cex = .5, y.intersp =1)

# Single Exponential Smoothing - pg. 36
birthstssesa01 <- HoltWinters(birthsts, alpha = .1, beta = F, gamma = F)
birthstssesa02 <- HoltWinters(birthsts, alpha = .2, beta = F, gamma = F)
birthstssesa09 <- HoltWinters(birthsts, alpha = .9, beta = F, gamma = F)

total <- cbind(birthsts, birthstssesa01$fitted[,1], birthstssesa02$fitted[,1], birthstssesa09$fitted[,1])
plot(total, plot.type = "single", col = 1:ncol(total), lwd = c(2,2,2))
legend("bottomright", c("Original", "0.1", "0.2", "0.9"), col = 1:ncol(total), lty = c(1,1), cex = .5, y.intersp =1)

birthstssesa01$coefficients
birthstssesa01$fitted[,1]

birthstssesaauto <- HoltWinters(birthsts, beta = F, gamma = F) # let R provide the alpha

# Single Exponential Smoothing - pg. 38
birthstssesforecast01 <- forecast(birthstssesa01, h =10)
birthstssesforecast02 <- forecast(birthstssesa02, h =10)
birthstssesforecast09 <- forecast(birthstssesa09, h =10)

plot(birthstssesforecast01)
plot(birthstssesforecast02)
plot(birthstssesforecast09)

# Single Exponential Smoothing - pg. 42
accuracy(birthstssesforecast01)
accuracy(birthstssesforecast02)
accuracy(birthstssesforecast09)

# Double Exponential Smoothing - pg. 51
birthstsdep <- HoltWinters(birthsts, gamma = F)
total <- cbind(birthsts, birthstsdep$fitted[,1])
plot(total, plot.type = "single", col = 1:ncol(total), lwd = c(2,2))
legend("bottomright", c("Original", "Double exp"), col = 1:ncol(total), lty = c(1,1), cex = .5, y.intersp =1)

# Double Exponential Smoothing - pg. 53
birthstsdepforecast <- forecast(birthstsdep, h=8)
plot(birthstsdepforecast)

# Winter's method - pg. 57
birthststes <- HoltWinters(birthsts)
total <- cbind(birthsts, birthststes$fitted[,1])
plot(total, plot.type = "single", col = 1:ncol(total), lwd = c(2,2))
legend("bottomright", c("Original", "Triple exp"), col = 1:ncol(total), lty = c(1,1), cex = .7, y.intersp =1)

# Forecast: Winter's method - pg. 59
birthstesforecast <- forecast(birthststes, h=12)
plot(birthstesforecast)

# Decomposition 1 - pg. 91
birthstimeseriescomponents <- decompose(birthsts)
plot(birthstimeseriescomponents)
birthstimeseriescomponents

# Seasonal Adjustment Decomposition 1 - pg. 96
birthstimeseriesseasonallyadjusted <- birthsts - birthstimeseriescomponents$seasonal
plot(birthstimeseriesseasonallyadjusted)
birthstimeseriesseasonallyadjusted

# Decomposition 2 - pg. 104
fit <- tslm(birthsts~trend + season)
summary(fit)
plot(forecast(fit, h=20))

# Dynamic Time Warping - pg. 122
library(dtw)
idx <- seq(0, 2*pi, len = 100)
aa <- sin(idx) + runif(100)/10
bb <- cos(idx)
align <- dtw(aa, bb, step = asymmetricP1, keep = T)
dtwPlotTwoWay(align)

# Synthetic Control Chart - pg. 127
sc <- read.table("synthetic_control.data", header = F, sep = "")
idx <- c(1, 101, 201, 301, 401, 501)
sample1 <- t(sc[idx,])
sample1
plot.ts(sample1, main = "")

# Synthetic Control Chart - pg. 129
n <- 10
s <- sample(1:100, n)
idx <- c(s, 100+s, 200+s, 300+s, 400+s, 500+s)
sample2 <- sc[idx,]
observedLabels <- c(rep(1,n), rep(2,n), rep(3,n), rep(4,n), rep(5,n), rep(6,n))

# Synthetic Control Chart - pg. 130
library(dtw)
distMatrix <- dist(sample2, method = "DTW")

# Synthetic Control Chart - pg. 131
# Hierarchical clustering with Euclidean distance
hc <- hclust(distMatrix, method = "ave")
plot(hc, labels = observedLabels, main = "")
