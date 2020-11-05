# Title     : CS5311 Assignment 2
# Created by: Justin
# Created on: 10/28/2020

library(shiny)
require(shinydashboard)
library(ggplot2)
library(dplyr)
library(DT)

ui <- dashboardPage(
  dashboardHeader(title= "PCA Visualization"),
  dashboardSidebar(
    menuItem("PCA", tabName = "pca", icon= icon("dashboard")),
    menuItem("EigenFace", tabName = "eigenface", icon = icon("dashboard"))
  ),
  dashboardBody(
    tabItems(
      # Tab content for eigenface analysis
      tabItem(tabName = "eigenface",
        fluidRow(
          box(plotOutput("plot1", height = 250)),

          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
      ),

      # Tab content for PCA analysis on various csv files
      tabItem(tabName = "pca",
        h2("PCA Analysis"),
          fluidRow(
            tabsetPanel(
              tabPanel(title = "Input/View Data",
                       p("Upload a CSV file to begin analysis!! Data is assumed to be clean."),
                       fileInput("files", "Choose File"),
                       p("Below offers a look a the data you've uploaded to check for any inconsistencies"),
                       p("Once done looking at your data you can switch over to the 'PCA Results & Visualization tab.'"),
                       DT::dataTableOutput("filetable")
              ),

              tabPanel(title = "PCA Results & Visualization",
                       p("Below is where you can select the columns from your data that you would like to run PCA on"),
                       uiOutput("pca_columns"),
                       p("Below is a table with the final PCA results from the given data:"),
                       verbatimTextOutput("pcaResults"),
                       p("Lastly is biplot from ggplot2 that allows to see your data projected onto the PCs."),
                       p("You are able to see the grouping of the data as well as change the PCs on the axis"),
                       uiOutput("grouping"),
                       plotOutput("biplot1", height = "400px"),
                       p("select principal componets to plot:"),
                       uiOutput("xVal"),
                       uiOutput("yVal"),

              )
            )
          )
      )
    )
  )
)

server <- function(input, output){

  # Read in the user's CSV file and save data
  datafile <-reactive({
    dataFile <- input$files
    if(is.null(dataFile)) return(NULL)
    mydata <- read.csv(dataFile$datapath, header = T, sep=",", quote = '"', stringsAsFactors = FALSE)
    return(mydata)
  })


  # Give table view of data entered
  output$filetable <- DT::renderDataTable({
    datafile()
  })

  # Get the columns to perform PCA on
  output$pca_columns <- renderUI({
    mydata <- datafile()
    data_with_nums <- na.omit(mydata[,sapply(mydata, is.numeric)])
    columns <- names(data_with_nums)
    checkboxGroupInput('columns', "Select Columns", choices = columns, selected = columns)

  })

  # Create the data object to be used to save results of PCA to
  pcaObj <- reactive({
    columns <- input$columns
    mydata <- na.omit(datafile())
    mydata_new <- na.omit(mydata[,columns, drop=FALSE])

    data_output <- prcomp(na.omit(mydata_new), center = TRUE, scale. = TRUE)

    pcdf <- cbind(mydata, data_output$x)

    return(list(mydata=mydata, mydata_new=mydata_new, data_output=data_output, pcdf=pcdf))
  })

  # Print table of results from PCA on columns
    output$pcaResults <- renderPrint({
    print(pcaObj()$data_output$rotation)
    summary(pcaObj()$data_output)

  })

  # Get x value for biplot axis
  output$xVal <- renderUI({
  data_output <- pcaObj()$data_output$x

  selectInput(inputId = "xVal", label = "X axis:",
              choices= colnames(data_output), selected = 'PC1')
})

  # Get y value for biplot axis
  output$yVal <- renderUI({
  data_output <- pcaObj()$data_output$x

  selectInput(inputId = "yVal",
              label = "Y axis:", choices= colnames(data_output), selected = 'PC2')
})
  # Create drop down menu for grouping data
  output$grouping <- renderUI({
    mydata <- datafile()
    group_col <- sapply(seq(1, ncol(mydata)), function(i) length(unique(mydata[,i])) < nrow(mydata)/10 )
    data_cols <- mydata[,group_col, drop=FALSE]
    selectInput(inputId = "grouping", label="Grouping:",choices = c("None",names(data_cols)))
  })

  # Create biplot graph for visualization
  dataBi <- reactive({
    pcdf <- pcaObj()$pcdf
    data_output <- pcaObj()$data_output
    labels <- rownames(data_output$x)
    grouping <- input$grouping

    if(grouping == 'None'){
      plotpc <- ggplot(pcdf, aes_string(input$xVal, input$yVal)) + geom_text(aes(label = labels), size =5)+
      theme_classic(base_size = 35)+ coord_equal()
      plotpc

    }else{
      pcdf$fill_ <-  as.character(pcdf[, grouping, drop = TRUE])
      plotpcg  <- ggplot(pcdf, aes_string(input$xVal, input$yVal,
                                          fill = 'fill_', colour = 'fill_')) +
      stat_ellipse(geom = "polygon", alpha = 0.1) + geom_text(aes(label = labels),  size = 5) +
      theme_classic(base_size = 35) + scale_colour_discrete(guide = FALSE) +
      guides(fill = guide_legend(title = "groups")) + theme(legend.position="top") + coord_equal()
      plotpcg
    }


  })
  # Display biplot in correct tab
  output$biplot1 <- renderPlot({
    dataBi()
  })


}
shinyApp(ui, server)