ui <- fluidPage(
	titlePanel("Hakai Salmon Sampling"),
	#title
	
	sidebarPanel("Juvenile salmon collected in 2015-2016 for the Salmon Early Marine Survival Program,
							 by species and site to select for my thesis research on salmon diets.",
							 br(),
							 #subtitle and insert a break
							 img(src="map.png", width = "100%"),
							 br(), br(),
							 #add an image of map and add breaks
							 dateRangeInput("dateIn5", "Dates of Sampling for 2015",
							 						min = "2015-05-12", max = "2015-07-14",
							 						start = "2015-06-20", end = "2015-06-30"),
							 #give options for 2015 dates
							 dateRangeInput("dateIn6", "Dates of Sampling for 2016",
							 							 min = "2015-05-06", max = "2016-07-06",
							 							 start = "2016-06-15", end = "2016-06-27"),
							 #give options for 2016 dates
							 radioButtons("yearIn", "Year", c("2015", "2016"), "2015"),
							 #choose which year to look at
							 checkboxGroupInput("stnIn", "Which stations?",
							 									 choices=c("D06", "D07", "D08", "D09", "D10", "D11", "J02",
							 									 					"J04", "J05", "J06", "J07", "J08", "J09"),
							 									 selected = c("D07", "D09", "J05", "J07", "J09"))),
	#the relevant stations to investigate, can choose multiple stations!
	
	mainPanel(textOutput("textresults"),
						#prints out how many species of each fish were sampled
						downloadButton("downloadID", label = "Download"),
						#gives an option to download once decided on important stations/dates!
						br(), br(),
						plotOutput("Hist_Fish"),
						#gives a graph to display sampling data
						br(), br(),
						DT::dataTableOutput("table"))
	#prints out an interactive table of the selected sampling data
)