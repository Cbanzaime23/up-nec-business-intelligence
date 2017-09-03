# Control structures

# Control structures

## Conditional statements
x = 4
if (x > 3) {
  y <- 10
} else {
  y <- 0
}
y

## Vectorized condtional statements
## ifelse
x <- c(6:-4)
x
sqrt(x)
sqrt(ifelse(x >= 0, x, NA))

## While loops
x <- 1
while (x < 5) {
  x <- x + 1
  print(x)
}

## For loops
x <- c("a", "b", "c", "d")
x
for (i in 1:4) {
  print(x[i])
}

for (letter in x) {
  print(letter)
}

for (i in 1:4) print(x[i])

## Nested loops
x <- matrix(1:6, 2, 3)

for (i in seq_len(nrow(x))) {
  for (j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}

## Vector versus cursor based algorithms
zVec <- sample(0:999, 10000000, replace=T)
## Cursor based example
avg <- mean(zVec)
dev <- 0

for (i in 1:length(zVec)) {
  dev <- dev + (zVec[i]-avg) ^ 2
}

sdev <- (dev/(length(zVec)-1)) ^ 0.5
sdev

## Vector based example
vdev <- (sum((zVec-mean(zVec))^2/(length(zVec)-1))) ^ 0.5
vdev

# Functions

# Declare a function
squarethis <- function(number) {
  return (number ^ 2)
}

# Call the function
squarethis(1)
squarethis(4)
squarethis(12)

# Function argument matching
args(lm)

# The following two calls are equivalent
mydata <- read.csv("Datasets/deliverytime.csv")
lm(data=mydata, deltime ~ ncases, model = F, 1:100)
lm(deltime ~ ncases, data=mydata, 1:100, model = F)

# Source the function
source("arithmeticsum.R")

# call the function
arithmeticsum(3)
arithmeticsum(10)
arithmeticsum(100)