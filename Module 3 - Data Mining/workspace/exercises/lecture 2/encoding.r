heisenberg <- read.csv(file="simple.csv",head=TRUE,sep=",")

# Binary encoding
indicators=model.matrix( ~ trial-1, data =heisenberg )
heisenberg = cbind(heisenberg,indicators)
heisenberg

# Class-based encoding
library("reshape2")
heisenberg.m = melt(heisenberg, id=c('trial'), measure=c('mass'))
heisenberg.c = dcast(heisenberg.m, trial ~ variable, mean) 
names(heisenberg.c)[names(heisenberg.c) == 'mass'] <- 'trialencoded'
heisenberg = merge(x=heisenberg,y=heisenberg.c,by=c("trial"))
heisenberg

