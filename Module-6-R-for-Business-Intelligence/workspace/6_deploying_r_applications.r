# Deploying R Applications

library(shiny)
runExample("01_hello")

runApp("App-1")

library(shiny)

shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    x <- faithful[,2]
    bins <- seq(min(x), max(x),
                length.out = input$bins +1)
    hist(x, breaks = bins, 
         col = "darkgray", border = "white")
  })
})

library(shiny)

shinyUI(fluidPage(
  titlePanel("Hello Eson!"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", 
                  "Number of bins:",
                  min = 5, 
                  max = 50,
                  value = 30)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
))