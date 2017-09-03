# Case 1

# Part 1

# 1
i <- c(1:25)
x <- sum(((2 ^ i) / i) + ((3 ^ i) / (i*i)))
x

# 2
set.seed(50)
xVec <- sample(0:999, 250, replace=T)
yVec <- sample(0:999, 250, replace=T)

# 2.a
yVec_more_than_600 <- yVec[yVec > 600]
yVec_more_than_600

# 2.b
yVec_more_than_600_pos <- which(yVec > 600)
yVec_more_than_600_pos

# Alternative answer: 
(1:length(yVec))[yVec > 600]

# 2.c
xVec[yVec_more_than_600_pos]

# Alternative answer: 
xVec[yVec > 600]

# 2.d
sqrt(abs(xVev-mean(xVec)))

# 2.e 
max(yVec)
sum(yVec > max(yVec) - 200)
# sum(yVec > 797)

# 2.f
sum(xVec %% 2 == 0)

# 2.g
xVec[order(yVec)]

# 2.h
temp_indexes <- seq(length=round(length(xVec)/3), from=1, by=3)
temp_indexes
length(temp_indexes)
yVec[temp_indexes]

# Part 2

library(MASS)
data(survey)
attach(survey)

summary(survey)
str(survey)
colnames(survey)

# 1
mean(survey$Pulse[!is.na(survey$Pulse)])

# 2
survey_ordered_by_age <- survey[order(survey$Age),]
survey_ordered_by_age_last_2 <- tail(survey_ordered_by_age,n=2)
survey_ordered_by_age_last_2$Smoke

# 3
datapulse <- survey[c("Pulse")]
datasmoke <- survey[c("Smoke")]
cleandatapulse <- datapulse[!is.na(datapulse) & !is.na(datasmoke)]
cleandatasmoke <- datasmoke[!is.na(datapulse) & !is.na(datasmoke)]
tapply(cleandatapulse, factor(cleandatasmoke),mean)

# 4
datapulse <- survey[c("Pulse")]
dataexer <- survey[c("Exer")]
cleandatapulse <- datapulse[!is.na(datapulse) & !is.na(dataexer)]
cleandataexer <- dataexer[!is.na(datapulse) & !is.na(dataexer)]
tapply(cleandatapulse, factor(cleandataexer),mean)

datapulse <- survey[c("Pulse")]
dataage <- survey[c("Age")]
cleandatapulse <- datapulse[!is.na(datapulse) & !is.na(dataage)]
cleandataage <- dataage[!is.na(datapulse) & !is.na(dataage)]
cor(cleandatapulse,cleandataage)
