server <- function(input, output){
	
	library(readr)
	library(tidyverse)
	library(stringr)
	library(DT)
	library(shiny)
	library(ggvis)
	library(cowplot)
	library(dplyr)
	#load any libraries used within this file, maybe even extra just in case?
	fishy <- readr::read_csv(file="fish.csv")
	#read in file
	fishy$date <- as.character(fishy$date)
	#change to character to extract year from the date
	fishy <- mutate(fishy, year=str_trunc(date, 4, ellipsis = ""))
	#make a column for year
	fishy <- filter(fishy, is.na(lat) != TRUE )
	#remove useless rows that are full of NAs but still have site and date
	fishy$date <- as.Date(fishy$date)
	#change date back into date format for proper usage
	
	colnames(fishy) <- c("Date", "Site", "Latitude", "Longitude", "Sockeye", "Chum", "Pink", "Year")
	#change column names so things are easier and look nicer later on!
	fishy <- gather(fishy, Species, Number, Sockeye:Pink, na.rm = TRUE)
	#change to long format with columns for species and for the number of samples
	
	fishy$Number <- as.numeric(fishy$Number)
	#make sure number is in the right format to prevent errors!
	
	fishy$Site <- as.factor(fishy$Site)
	#make sure site is a factor so it works properly as well

	fish <- reactive({
		if(input$yearIn == "2015"){
			filter(fishy, Site %in% input$stnIn, Date >= input$dateIn5[1],
						 Date <= input$dateIn5[2], Number != 0,
						 Year=="2015")
		} else{
			filter(fishy, Site %in% input$stnIn, Date >= input$dateIn6[1],
								 Date <= input$dateIn6[2], Number != 0,
								 Year=="2016")
			}
	})
	#create a reactive dataframe where it returns inputs chosen by the user
	#it filters by date range relevant to year, site and year itself
	#also drops any rows with 0 for number of fish since not relevant
	
	output$Hist_Fish <- renderPlot({
		fish() %>% 
			ggplot(aes(x=Date, y=Number))+ 
			geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
				labs(title="Juvenile Salmon Species Collected", y="Number of Salmon")
	})
	#graph of the number of salmon collected, by site, by date, by species, by year!
	
	pink <- reactive({
		fish() %>%
			filter(Species=="Pink") %>%
			summarise(sum(Number)) %>%
			as.character()
	})
	#create reactive dataframe that further filters previous reactive dataframe
	#so that it will return the number of pink salmon samples the user has selected
	
	chum <- reactive({
		fish() %>%
			filter(Species=="Chum") %>%
			summarise(sum(Number)) %>%
			as.character()
	})
	#repeat process to find number of chum salmon samples currently selected
	
	sock <- reactive({
		fish() %>%
			filter(Species=="Sockeye") %>%
			summarise(sum(Number)) %>%
			as.character()
	})
	#repeat once more so that it also prints out number of sockeye salmon samples
	
	output$textresults <- renderText({
		paste("We found", pink(), "Pink,", chum(), "Chum and", sock(), "Sockeye samples for you!")
		})
	#combine into a text output that says how many fish are being viewed
	
	output$downloadID <- downloadHandler(
		filename = function(){
			paste("salmon-data-", Sys.Date(), ".csv", sep="")
		},
		content = function(file){
			write_csv(fish(), file)
		})
	#gives an option to download the current datatable, with recent date attached
	
	output$table <- renderDataTable({
			fish() %>% 
				spread(Species, Number, fill = 0) %>%
				select(Year, Date, Site, Pink, Chum, Sockeye)
	})
	#interactive table that displays the detailed numbers of fish per site per date
}
