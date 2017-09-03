library(shiny)
library(TTR)

art <- read.csv("art.csv")
#View(art)

shinyServer(function(input, output) {
  dataInput <- reactive({
    switch(input$category,
           All = All,
           Painting = Painting,
           Sculpture = Sculpture,
           Textile = Textile,
           Installation = Installation
    )
  })
  output$plot1 <- renderPlot({
    cat <- input$category
    if (cat == "All"){
      plot(art$Condition, 
           main = "Bar plot of Aprraised Value", 
           xlab = "Condition", 
           ylab = "Count") 
    } else {
      temp <- art[art$Category == cat,]
      plot(temp$Condition, 
           main = "Bar plot of Aprraised Value", 
           xlab = "Condition", 
           ylab = "Count") 
    }
  })
  

  #output$plot2 <- renderPlot({
  #  cat <- input$category
  #  if (cat == "All"){
  #    plot(art$Condition, art$Age, 
  #        main = "Distribution plot of Age", 
  #        xlab = "Condition", 
  #        ylab = "Age") 
  #  } else {
  #    temp <- art[art$Category == cat]
  #    plot(temp$Condition, art$Age, 
  #        main = "Distribution plot of Age", 
  #        xlab = "Condition", 
  #        ylab = "Age") 
  #  }
  #})
})