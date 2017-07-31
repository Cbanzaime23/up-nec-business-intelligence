library(sqldf)
db <- dbConnect(SQLite(), dbname="Art.sqlite")
rs = dbSendQuery(db, "SELECT * FROM artworks")
artworks = fetch(rs, n=-1)
rs = dbSendQuery(db, "SELECT * FROM locations")
locations = fetch(rs, n=-1)
rs = dbSendQuery(db, "SELECT * FROM categories")
categories = fetch(rs, n=-1)
rs = dbSendQuery(db, "SELECT * FROM artists")
artists = fetch(rs, n=-1)
dbDisconnect(db)

#Transform Data
artworks = merge(x=artworks, y=artists, by=c("Artist_No"))
artworks = merge(x=artworks, y=categories, by=c("Category_No"))
artworks = merge(x=artworks, y=locations, by=c("Location_No"))
artworks = artworks[,c("ArtID", "Artist", "Title", "Date.Acquired", "Category", "Condition", "Location", "Appraised.Value")]
artworks$age <- as.numeric((Sys.Date()-as.Date(artworks$Date.Acquired, "%m/%d/%y"))/365)

#Loading Data
write.csv(artworks, "artworks.csv")

# Graph - Condition
freqCondition <- table(artworks$Condition)
pie(freqCondition, main="Condition", col=rainbow(length(freqCondition)),labels=names(freqCondition))
barplot(freqCondition, main="Condition", col=rainbow(length(freqCondition)), horiz = TRUE, names.arg = names(freqLocation), las=1)

# Graph - Category
freqCategory <- table(artworks$Category)
pie(freqCategory, main="Category", col=rainbow(length(freqCategory)),labels=names(freqCategory))
barplot(freqCategory, main="Category", col=rainbow(length(freqCategory)), horiz = TRUE, names.arg = names(freqCategory), las=1)

# Graph - Location
freqLocation <- table(artworks$Location)
pie(freqLocation, main="Location", col=rainbow(length(freqLocation)),labels=names(freqLocation))
barplot(freqLocation, main="Location", col=rainbow(length(freqLocation)), horiz = TRUE, names.arg = names(freqLocation), las=1)