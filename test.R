# Title     : TODO
# Objective : TODO
# Created by: Justin
# Created on: 11/2/2020

library(shiny)
require(shinydashboard)
library(ggplot2)
library(dplyr)

ui <- pageWithSidebar(
	# title
	headerPanel("Select Options"),
	# h2("Principal Components Analysis (PCA)")

	#input
	sidebarPanel
	(
		#data upload
		fileInput("files", "Choose File", multiple=TRUE),
		uiOutput("PCs"),
		# tabsetPanel(id="dist",
		# tabPanel("Data", value='norm', textInput("dist1","Xdist1", c("norm"))),
		# tabPanel("Analyze", value='unif', textInput("dist2","Xdist2", c("unif")))),
		checkboxInput("center","Center",TRUE),
		selectInput("scaling","Scale",
						list(none = "none", "unit variance" = "uv", pareto = "pareto")
						),

		selectInput("cv","cross-validation",
						list (none = "none", Q2 =  "q2")
						)
		 #helpText("Hints"),
	),

		# uiOutput("variable"), 	# depends on dataset ( set by output$variable in  server.R)
		# uiOutput("group"),  		# depends on dataset	( set by output$group in  server.R)
		# selectInput("plot.type","Plot Type:",
						# list(boxplot = "boxplot", histogram = "histogram", density = "density", bar = "bar")
						# ),
		# checkboxInput("show.points", "show points", TRUE)

	# output
	mainPanel(
		h3(textOutput('caption')),
		tabsetPanel(
			tabPanel("Data",tableOutput("filetable")),
			tabPanel("Scree Plot",plotOutput("screeplot",height = 280*2, width = 250*2)),
			tabPanel("Scores Plot",plotOutput("scores")),
			tabPanel("Loadings Plot",plotOutput("loadings"))
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