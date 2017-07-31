deliverytime <- read.csv("deliverytime.csv")
lrfit <- lm(deltime~., data=deliverytime)
summary(lrfit)
plot(lrfit) # need to hit Enter to see each plot

par(mfrow =c(2,2),mar=c(2,2,2,2)) # put the 4 plots in one page
plot(lrfit)

slrfit <- lm(deltime^0.5~., data=deliverytime)
summary(slrfit)
plot(slrfit)
