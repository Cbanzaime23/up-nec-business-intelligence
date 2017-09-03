# Plotting

options(scipen = 100, digits = 4)
plotdata <- read.csv("Datasets/nSQLExtract.csv", header = T, sep = ",")

attach(plotdata)
View(plotdata)
# Plot appraised value only
plot(Appraised_Value)

# Bar graph of condition
data.class(Condition)
plot(Condition)

# Box plot of condition by Appraised Value
plot(Condition, Appraised_Value)

# Plotting a scatterplot
plot(plotdata)
pairs(plotdata[,c("Artist_No", "Appraised_Value", "Category_No", "Condition")])

# Distribution comparison plots
qqnorm(Appraised_Value)
qqline(Appraised_Value)

# Histogram
hist(Appraised_Value)
hist(Appraised_Value, nclass = 3)

# Dot chart
dotchart(mtcars$mpg, labels = row.names(mtcars), cex=.7)

# Plotting arguments
plot(Appraised_Value, type = "o", 
     main = "Plot of Appraised Value",
     xlab = "Art ID", 
     ylab = "Appraised Value")

# The par() function
par()
opar <- par()
par(col.lab = "red")
plot(Appraised_Value, type = "o", 
     main = "Plot of Appraised Value",
     xlab = "Art ID", 
     ylab = "Appraised Value")
par(opar)

# Text size
plot(Appraised_Value, type = "o", 
     main = "Plot of Appraised Value",
     xlab = "Art ID", 
     ylab = "Appraised Value",
     cex = 2.0,
     cex.main = 0.75)

# Line types
plot(Appraised_Value, type = "o", 
     main = "Plot of Appraised Value",
     xlab = "Art ID", 
     ylab = "Appraised Value",
     lty = 2,
     lwd = 2)

# Colors
plot(Appraised_Value, type = "o", 
     main = "Plot of Appraised Value",
     xlab = "Art ID", 
     ylab = "Appraised Value",
     col=28)

# Fonts
plot(1:10, 1:10, type="n")
windowsFonts(
  A = windowsFont("Arial Black"),
  B = windowsFont("Bookman Old Style"),
  C = windowsFont("Comic Sans Ms"),
  D = windowsFont("Symbol")
)
text(3, 3, "Hello World Default")
text(4, 4, family = "A", "Hello World from Arial Black")
text(5, 5, family = "B", "Hello World from Bookman Old Style")
text(6, 6, family = "C", "Hello World from Comic Sans Ms")
text(7, 7, family = "D", "Hello World from Symbol")

# Margins and legends
attach(mtcars)
boxplot(mpg ~ cyl, main = "Milage by Car Weight", yaxt = "n",
        xlab = "Milage",
        horizontal = T,
        col = terrain.colors(3))
legend("topright", 
       inset = .05,
       title = "Number of Cylinders",
       c("4", "6", "8"),
       fill = terrain.colors(3),
       horiz = T)

# Combining plots
attach(mtcars)
par(mfrow = c(2,2))
plot(wt, mpg, main = "Scatterplot of wt vs. mpg")
plot(wt, disp, main = "Scatterplot of wt vs. disp")
hist(wt, main = "Histogram of wt")
boxplot(wt, main = "Boxplot of wt")

# Kernel density plots

# Kernel density plots for mpg
# grouped by number of gears (indicated by color)
library(ggplot2)
qplot(mpg, data = mtcars,
      geom = "density",
      fill = as.factor(gear),
      alpha = I(.5),
      main = "Distribution of Gas Mileage",
      xlab = "Miles Per Gallon",
      ylab = "Density")

# Scatterplot using ggplot
?qplot
# Scatterplot of mpg vs. hp for each combination of gears and cylinders
# in each facet, transmission type is represented by shape and color
qplot(hp, 
      mpg, 
      data = mtcars,
      shape = as.factor(am),
      color = am,
      facets = gear~cyl,
      size = I(3),
      xlab = "Horsepower",
      ylab = "Miles Per Gallon")

qplot(wt, mpg, data = mtcars)
qplot(wt, mpg, data = mtcars, color = cyl)
qplot(wt, mpg, data = mtcars, size = cyl)
qplot(wt, mpg, data = mtcars, facets = cyl)

# Line plots
# Separate regressions of mpg on weight for each number of cylinders
qplot(wt, 
      mpg, 
      data = mtcars,
      geom = c("point", "smooth"),
      color = as.factor(cyl),
      main = "Regression of MPG on Weight",
      xlab = "Weight",
      ylab = "Miles Per Gallon")

qplot(wt, 
      mpg, 
      data = mtcars,
      color = as.factor(cyl),
      main = "Regression of MPG on Weight",
      xlab = "Weight",
      ylab = "Miles Per Gallon")

qplot(wt, 
      mpg, 
      data = mtcars,
      geom = c("smooth"),
      color = as.factor(cyl),
      main = "Regression of MPG on Weight",
      xlab = "Weight",
      ylab = "Miles Per Gallon")

# Box plots
# Observations (points) are overlayed and jittered
qplot(gear, 
      mpg, 
      data = mtcars,
      geom = c("boxplot", "jitter"),
      fill = as.factor(gear),
      main = "Mileage by Gear Number",
      xlab = "",
      ylab = "Miles Per Gallon")

# statmethods.net