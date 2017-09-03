# Read a CSV file
heisenberg <- read.csv(file="simple.csv",head=TRUE, sep=",")

trial <- c("A", "C", "D")
cost <- c(11.4, 3.3, 1.1)
trialcost <- data.frame(trial,cost)
trialcost

# Merge
innerjoin = merge(x=heisenberg,y=trialcost,by=c("trial"))
innerjoin

outerjoin = merge(x=heisenberg,y=trialcost,by=c("trial"), all=TRUE)
outerjoin

leftjoin = merge(x=heisenberg,y=trialcost,by=c("trial"), all.x=TRUE)
leftjoin

rightjoin = merge(x=heisenberg,y=trialcost,by=c("trial"), all.y=TRUE)
rightjoin
