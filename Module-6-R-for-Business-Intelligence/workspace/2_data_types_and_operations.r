# Data Types And Operations

# One dimensional vector arithmetic

# Variables
name <- "eson"
age <- 20

# Vectors

# Create a vector
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)

# Print a vector
x

# Assignments
1/x
y <- c(x, 0, x)
y

# Vector arithmetic

# Different lengths
v <- 2 * x + y + 1
v

# Arithmetic operations
z <- (2 * x + 5) ^ 2
z

# The range of x
xrange = range(x)
xrange

# The num of elements in x
xlength <- length(x)
xlength

# Statistical operations

# Mean of x
mean(x)

# Variance of x
var(x)

# Standard deviation of x
sqrt(var(x))

# Median of x
median(x)

# Arithmentic sequences

# Arithmetic sequence from 1 to 30
1:30

# Priority of operations
2*1:15

# Sequence function
seq(from=5, to=5, by=.2)
seq(length=51, from=-5, by=.2)

# Repeat function
rep(1, times=5)

# Logical vectors
x
temp <- x > 10
temp

# Missing values
z <- c(1:3, NA)
z

ind <- is.na(z)
ind

# Character vectors

# This is a character vector
"x-values"

# The use of paste
paste("Eson", "-", "Paguia")
labs <- paste(c("X"), 1:10, sep="")
labs

# Date vectors

mydates <- as.Date(c("2007-06-22", "2004-02-13"))

# Number of days between 06/22/07 and 02/13/04
days <- mydates[1] - mydates[2]
days

# Indexing

# A logical vector
z
!is.na(z)

# Select all values not NA
y <- z[!is.na(z)]
y

v

# Include using positive integers
temp <- v[1:10]
temp

# Exclude using negative integers
temp2 <- v[-(1:5)]
temp2

# Include using any number
temp3 <- v[c(1,4,6)]
temp3

# A vector character strings
fruit <- c(5, 10, 1, 20)
names(fruit) <- c("orange", "banana", "apple", "peach")
fruit
lunch <- fruit[c("apple", "orange")]
lunch

# Indexing and assignment of vectors

# Assignments of Operators
z
is.na(z)
z[is.na(z)] <- 0
z

# Changing data types
digits <- as.character(z)
mode(digits)
digits <- as.integer(digits)
mode(digits)

# Factors

# Working with factors
gender <- c("M", "F", "M", "M", "F")
genderfactors <- factor(gender)
levels(genderfactors)

# Get average income per factor
income <- c(30, 29, 35, 20, 40)
incmeans <- tapply(income, genderfactors, mean)
incmeans
income

# Multi dimensional vector arithmetic

# 2-Dimensional arrays
z 
zmatrix <- z
dim(zmatrix) <- c(2,2)
zmatrix

# Subsetting arrays

# Generate a 4 by 5 array
xindex <- array(1:20, dim=c(4,5))
xindex

# Select item [1,3], [2,2], [3,1]
indextoselect <- array(c(1:3, 3:1), dim=c(3,2))
xindex[indextoselect]

# Replace with zeroes
xindex[indextoselect] <- 0
xindex

# Traspose of a matrix

# To transpose a matrix
xindex
xtranspose <- t(xindex)
xtranspose
nrow(xtranspose)
ncol(xtranspose)

# Matrix muliplications
x <- array(c(1,3,2,4), dim = c(2,2))
y <- array(c(4,2,3,1), dim = c(2,2))
z <- array(c(1,2), dim = c(2,1))

# Element wise multiplication
x * y

# Matrix inner product
x %*% y

# Vector times matrix multiplication
t(z) %*% x

# cbind and rbind
x
y
colbinded <- cbind(x,y)
colbinded
rowbinded <- rbind(x,y)
rowbinded

# Tables and frequencies

# Frequency
table(genderfactors)

