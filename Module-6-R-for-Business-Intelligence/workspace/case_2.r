# Case 2

library(sqldf)
library(XLConnect)

db <- dbConnect(SQLite(), dbname = "Datasets/Art.sqlite")
dbListTables(db)

rs_artworks = dbSendQuery(db, "SELECT * FROM artworks")
rs_locations = dbSendQuery(db, "SELECT * FROM locations")
rs_categories = dbSendQuery(db, "SELECT * FROM categories")
rs_artists = dbSendQuery(db, "SELECT * FROM artists")

artworks <- fetch(rs_artworks, n=-1)
locations <- fetch(rs_locations, n=-1)
categories <- fetch(rs_categories, n=-1)
artists <- fetch(rs_artists, n=-1)

# Check row counts of each tables
nrow(artworks)
nrow(locations)
nrow(categories)
nrow(artists)

dbDisconnect(db)

# Merge all tables
artworks <- merge(x = data_artworks, y = data_locations, by = c("Location_No"), all.x=T)
artworks <- merge(x = artworks, y = data_categories, by = c("Category_No"), all.x=T)
artworks <- merge(x = artworks, y = data_artists, by = c("Artist_No"), all.x=T)

# Select columns
artworks <- select(joined_all, ArtID, Artist, Title, Date.Acquired, Category, Condition, Location, Appraised.Value, Date.Acquired)
# Alternative: arts <- joined_all[,c("ArtID", "Artist", "Title", "Date.Acquired", "Category", "Condition", "Location", "Appraised.Value", "Date.Acquired")]

# Append age column
artworks$Age <- (Sys.Date() - as.Date(artworks$Date.Acquired, format="%m/%d/%y")) / 365

# Export to csv
write.csv(artworks, "art.csv")

# 2

# a
appraised_value = summarise(art,
                      average = mean(Appraised.Value, na.rm=T),
                      stdev = sqrt(var(Appraised.Value, na.rm=T)),
                      median = median(Appraised.Value, na.rm=T),
                      mode = mode(Appraised.Value),
                      variance = var(Appraised.Value, na.rm=T),
                      min = min(Appraised.Value, na.rm=T),
                      max = max(Appraised.Value, na.rm=T),
                      sum = sum(Appraised.Value, na.rm=T),
                      range = max-min,
                      count = n())
appraised_value

# b
by_location <- group_by(artworks, Location)
art_by_locations <- summarise(by_location, 
                   count = n(), 
                   average_value = mean(Appraised.Value, na.rm = T),
                   total_value = sum(Appraised.Value, na.rm = T))
View(art_by_locations)


# c
by_artist <- group_by(artworks, Artist)
art_by_artists <- summarise(by_artist, 
                              count = n(), 
                              average_value = mean(Appraised.Value, na.rm = T),
                              total_value = sum(Appraised.Value, na.rm = T))
View(art_by_artists)

# d

# e
