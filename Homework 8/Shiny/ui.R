ui <- fluidPage(
	#Application title
	titlePanel("Hakai Salmon Sampling"),
	
	sidebarPanel("Juvenile salmon collected in 2015-2016 for the Salmon Early Marine Survival Program,
							 by species and site to select for my thesis research on salmon diets.",
							 br(),
							 img(src="map.png", width = "100%"),
							 br(), br(),
							 dateRangeInput("dateIn5", "Dates of Sampling for 2015",
							 						min = "2015-05-12", max = "2015-07-14",
							 						start = "2015-06-20", end = "2015-06-30"),
							 dateRangeInput("dateIn6", "Dates of Sampling for 2016",
							 							 min = "2015-05-06", max = "2016-07-06",
							 							 start = "2016-06-15", end = "2016-06-27"),
							 checkboxInput("filterIn", "Filter by year?"),
							 conditionalPanel("input.filterIn==true", selectInput("yearIn", "Year", choices = c("2015", "2016"), selected = "2015")),
							 checkboxGroupInput("stnIn", "Which stations?",
							 									 choices=c("D06", "D07", "D08", "D09", "D10", "D11", "J02",
							 									 					"J04", "J05", "J06", "J07", "J08", "J09"),
							 									 selected = c("D07", "D09", "J05", "J07", "J09"))),
	
	mainPanel(textOutput("textresults"),
						downloadButton("downloadID", label = "Download"),
						br(), br(),
						plotOutput("Hist_2015Fish"),
						plotOutput("Hist_2016Fish"),
						br(), br(),
						tableOutput("table_head"))
)
