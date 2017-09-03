# Reading And Writing Data

# Data frames
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
y <- x + 1
z <- data.frame(x,y)
z

# Attach and detach
a <- z$x + z$y
a

# Dataframes using attach and detach 
attach(z)
b <- x +y
b
detach(z)

# Another example of attacj amd detach
require(utils)
summary(women$height)
women

attach(women)
height
summary(height)
find("height")
detach(women)
find("height")

# Reading a CSV file
heisenberg <- read.csv(file="Datasets/simple.csv", head=T, sep=",")
heisenberg

# Reading from Excel
library(xlsx)
heisenberg <- read.xlsx(file="Datasets/simple.xlsx", sheetName="simple")
heisenberg

# Read large CSV file
library("data.table")
heisenberglargecsv <- as.data.frame(fread("Datasets/largecsv.csv"))
heisenberglargecsv

# Subsetting
heisenbergaonly <- heisenberg[heisenberg$trial == "A", c("trial", "mass")]
heisenbergaonly

heisenbergbonly <- heisenberg[heisenberg$trial == "B" & heisenberg$mass <= 6, c("trial", "mass")]
heisenbergbonly

# Merging
trial <- c("A", "C", "D")
cost <- c(11.4, 3.3, 1.1)
trialcost <- data.frame(trial, cost)
trialcost

innerjoin <- merge(x = heisenberg, y = trialcost, by = c("trial"))
innerjoin

outerjoin <- merge(x = heisenberg, y = trialcost, by = c("trial"), all=T)
outerjoin

leftjoin <- merge(x = heisenberg, y = trialcost, by = c("trial"), all.x=T)
leftjoin

rightjoin <- merge(x = heisenberg, y = trialcost, by = c("trial"), all.y=T)
rightjoin

# Sorting

# Sort by mass
heisenbergmass <- heisenberg[order(heisenberg$mass), ]
heisenbergmass

# Sort by trial then by mass
heisenbergtrialmass <- heisenberg[order(heisenberg$trial, heisenberg$mass),]
heisenbergtrialmass

# Sort by trial then by mass descending
heisenbergtrialmassdesc <- heisenberg[order(heisenberg$trial, -heisenberg$mass),]
heisenbergtrialmassdesc

# Database queries
library(sqldf)
library(XLConnect)
db <- dbConnect(SQLite(), dbname = "Datasets/Art.sqlite")
rs = dbSendQuery(db, "SELECT * FROM artworks")
data <- fetch(rs, n=-1)
dbDisconnect(db)
data

# Exporting data
write.csv(data, "SQLExtract.csv")
write.xlsx(data, "SQLExtract.xlsx")

# Exporting to an SQLite database
db <- dbConnect(SQLite(), dbname = "Art.sqlite")
dbWriteTable(conn = db, name = "artworks2", value = data, row.names = F, append = T)
rs <- dbSendQuery(db, "SELECT * FROM artworks2")
datatest <- fetch(rs, n=-1)
dbDisconnect(db)

# Reshaping
library(reshape2)
heisenberg.m <- melt(heisenberg, id = c("trial"), measure = c("mass", "velocity"))
heisenberg.m

# Casting
heisenberg.c <- dcast(heisenberg.m, trial ~ variable, mean)
heisenberg.c

# Filtering
library(dplyr)
flights <- read.csv("Datasets/flights.csv")
filtered <- filter(flights, month == 1, day == 1)
View(filtered)

filtered2 <- filter(flights, month == 1 | month == 7)
View(filtered2)

# Slice
slice(flights, 1:10)

# Arrange
sorted <- arrange(flights, year, month, day)
View(sorted)

descsorted <- arrange(flights, desc(arr_delay))
View(descsorted)

# Select
selectedcol <- select(flights, year, month, day)
View(selectedcol)

deselectedcol <- select(flights, -(year:day))
View(deselectedcol)

# Distinct
distinct <- distinct(select(flights, origin, dest))
View(distinct)

# Mutate
delayed <- mutate(flights, 
                  gain = arr_delay - dep_delay,
                  speed = distance / air_time * 60, 
                  gain_per_hour = gain / (air_time / 60))
View(delayed)

flights2 <- flights
newcol <- mutate(flights2, gain2 = 1.33)
View(newcol)

# Must be of the same row length
newcol2 <- mutate(flights2, gain2 = 1:336776)
View(newcol2)

# Summarize
meandelay <- summarise(flights, delay = mean(dep_delay, na.rm = T))
View(meandelay)

# Grouping
by_tailnum <- group_by(flights, tailnum)
delay <- summarise(by_tailnum, 
                   count = n(), 
                   dist = mean(distance, na.rm = T),
                   delay = mean(arr_delay, na.rm = T))
delay
delay <- filter(delay, count > 20, dist < 2000)
View(delay)

# Grouping with visualization
library(ggplot2)
ggplot(delay, aes(dist, delay)) + 
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()

# Summarize and aggregate
destinations <- group_by(flights, dest)
destsummary <- summarise(destinations, 
                   planes = n_distinct(tailnum), 
                   flights = n(),
                   delay = mean(dep_delay, na.rm = T))
View(destsummary)

# Chaining

delayreport <- flights %>% 
  group_by(year, month, day) %>% 
  select(arr_delay, dep_delay) %>% 
  summarise(
    arr = mean(arr_delay, na.rm = T),
    dep = mean(dep_delay, na.rm = T)
  ) %>% 
  filter(arr > 30 | dep > 30)
View(delayreport)

# Note: chaining only works in dplyr functions