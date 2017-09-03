# Case 3: Writing functions

# Part 1: Correlation between two vectors
standardizefunc <- function(vec) {
  stvec <- (vec-mean(vec)/sd(vec))
  return(stvec)
}

correlationfunc <- function(xVec, yVec) {
  rho <-(xVec %*% yVec)/(length(xVec)-1)
  return(rho)
}

data <- read.csv("Datasets/deliverytime.csv", header=T, sep=",")
deltimestand <- standardizefunc(data$deltime)
ncasesstand <- standardizefunc(data$ncases)
rho <- correlationfunc(deltimestand,ncasesstand)
rho

# 2nd way

cor2 <- function (xVec, yVec) {
  stxvec = (xVec-mean(xVec))/sd(xVec)
}

# Part 2
tmpFn <- function(vec) {
  for (i in 1:length(vec)) {
    x <- vec[i]
    if (x < 0) { 
      x <- (x ^ 2) + (2 * x) + 3
    } else if(x >= 0 & x < 2) {
      x <- x + 3
    } else if(x >= 2) {
      x <- (x ^ 2) + (4 * x) - 7
    }
    vec[i] <- x
  }
  return(vec)
}
tmpFn(c(-1,0,2,5))

tmpFn2 <- function(x) {
  if (x < 0) { 
    y <- (x ^ 2) + (2 * x) + 3
  } else if(x >= 0 & x < 2) {
    y <- x + 3
  } else if(x >= 2) {
    y <- (x ^ 2) + (4 * x) - 7
  }
  return(y)
}

tmpFn2(-1)
tmpFn2(0)
tmpFn2(2)
tmpFn2(5)

# Part 3
library(dplyr)

call_center_data_2013 <- read.csv("Datasets/Call Center Data/2013.csv", header=T, sep=",")
call_center_data_2014 <- read.csv("Datasets/Call Center Data/2014.csv", header=T, sep=",")
call_center_data_2015 <- read.csv("Datasets/Call Center Data/2015.csv", header=T, sep=",")

all_data <- rbind(call_center_data_2013, call_center_data_2014, call_center_data_2015)

all_data$MONTH <- month.name[all_data$MONTH]
all_data$MONTH <- as.factor(all_data$MONTH)
levels(all_data$MONTH)
str(all_data)
View(all_data)

summy <- function(data, questionNum){
  if (questionNum == 1) {
    print("Answer 1")
    return(data %>%  group_by(YEAR, MONTH) %>% summarise(count=n()))
  } else if (questionNum == 2) {
    countofcalls <- data %>%  group_by(YEAR, MONTH) %>% summarise(count=n())
    return(countofcalls %>% summarise(average=mean(count)))
    print("Answer 2")
  } else if (questionNum == 3) {
    
    print("Answer 3")
  } else if (questionNum == 4) {
    print("Answer 4")
    
  } else if (questionNum == 5) {
    print("Answer 5")
    
  } else {
    print("Invalid question")
    
  }
  
}

anwser1 <- summy(all_data, 1)
View(anwser1)
answer2 <- summy(all_data, 2)
View(anwser2)
warnings()
summy(all_data, 3)
summy(all_data, 4)
summy(all_data, 5)

