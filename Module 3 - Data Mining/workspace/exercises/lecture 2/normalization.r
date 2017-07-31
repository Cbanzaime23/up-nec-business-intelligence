heisenberg <- read.csv(file="simple.csv",head=TRUE,sep=",")
heisenberg

# min-max normalization
heisenberg$smass = heisenberg$mass-min(heisenberg$mass) / (max(heisenberg$mass)-min(heisenberg$mass))*(5-1)+1
heisenberg

# z-score standization
heisenberg$svelocity = (heisenberg$velocity-mean(heisenberg$velocity))/sd(heisenberg$velocity)
heisenberg
