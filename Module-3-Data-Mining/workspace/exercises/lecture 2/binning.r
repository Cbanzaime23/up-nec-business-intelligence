heisenberg <- read.csv(file="simple.csv",head=TRUE,sep=",")

bins=3
cutpoints=quantile(heisenberg$mass,(0:bins)/bins)

# Equal Width Binning
heisenberg$discretemass =cut(heisenberg$mass,
                             cutpoints, include.lowest=TRUE, 
                             labels=c("Low","Medium", "High"))

# Equal Depth Binning
heisenberg$discretevelocity =cut(heisenberg$velocity, bins,
                              include.lowest=TRUE,
                              labels=c("Low","Medium", "High"))

heisenberg



