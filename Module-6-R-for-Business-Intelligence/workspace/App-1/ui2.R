library(shiny)

shinyUI(fluidPage(
  titlePanel("title panel"),
  sidebarLayout(
    sidebarPanel("side panel"),
    mainPanel("main panel")
  ),
))