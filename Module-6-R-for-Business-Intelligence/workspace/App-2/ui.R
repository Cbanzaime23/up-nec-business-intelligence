library(shiny)

shinyUI(fluidPage(
  titlePanel("Airline Volume Dashboard"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("category", label = "Category", 
                   c("All" = "All", 
                     "Painting" = "Painting", 
                     "Sculpture" = "Sculpture", 
                     "Textile" = "Textile",
                     "Installation" = "Installation"),
                  selected = "All")
    ),
    mainPanel(
      plotOutput("plot1"),
      plotOutput("plot2")
    )
  )
))