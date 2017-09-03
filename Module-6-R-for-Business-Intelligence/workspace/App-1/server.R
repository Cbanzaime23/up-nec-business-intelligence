library(shiny)
library(TTR)

tempdata <- read.csv("../Datasets/airline.csv")
totalvolume <- ts(tempdata[,4], frequency= 12, start = c(1949,1))
AAvolume <- ts(tempdata[,5], frequency= 12, start = c(1949,1))
Deltavolume <- ts(tempdata[,6], frequency= 12, start = c(1949,1))
total <- cbind(totalvolume, AAvolume, Deltavolume)

shinyServer(function(input, output) {
  dataInput <- reactive({
    switch(input$var,
           "Both" = total,
           "American Airlines" = AAvolume,
           "Delta" = Deltavolume
    )
  })
  
  colorInput <- reactive({
    switch(input$var,
           "Both" = 1:3,
           "American Airlines" = 2,
           "Delta" = 3
    )
  })
  
  output$plot1 <- renderPlot({
    plot(dataInput(), plot.type = "single", col = colorInput(),
         lwd = c(2,2,2,2))
    legend("bottomright", colnames(total), col = 1:ncol(total), 
           lty = c(1,1,1,1), cex = .5, y.intersp = 1)
  })
})