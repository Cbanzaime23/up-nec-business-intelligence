library(shiny)

shinyUI(fluidPage(
  titlePanel("Airline Volume Dashboard"),
  sidebarLayout(
    sidebarPanel(
      helpText("Create a simple trend plot of historical airline volume"),
      selectInput("var", label = "Choose an airline to display",
                  choices = list("Both", "American Airlines", "Delta"),
                  selected = "Both")
    ),
    mainPanel(

    )
  )
))