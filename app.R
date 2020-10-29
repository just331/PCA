# Title     : TODO
# Objective : TODO
# Created by: Justin
# Created on: 10/28/2020

library(shiny)
require(shinydashboard)
library(ggplot2)
library(dplyr)

ui <- dashboardPage(
  dashboardHeader(title= "PCA Visualization"),
  dashboardSidebar(
    menuItem("Dashboard", tabName = "dashboard", icon= icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th"))
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
        fluidRow(
          box(plotOutput("plot1", height = 250)),

          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),

      # Second tab content
      tabItem(tabName = "widgets",
        h2("Widgets tab content")
      )
    )
  )
)

server <- function(input, output){
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}
shinyApp(ui, server)