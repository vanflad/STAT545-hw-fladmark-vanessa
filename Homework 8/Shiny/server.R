server <- function(input, output){
	
	library(readr)
	library(tidyverse)
	library(stringr)
	fish <- readr::read_csv(file="fish.csv")
	fish$date <- as.character(fish$date)
	fish <- mutate(fish, year=str_trunc(date, 4, ellipsis = ""))
	fish$date <- as.Date(fish$date)
	
	colnames(fish)[5:7] <- str_trunc(colnames(fish[5:7]), 2, ellipsis = "")
	fish <- gather(fish, Species, Number, so:pi, na.rm = TRUE)
	
	fish$site.ID <- as.factor(fish$site.ID)
	 
	output$Hist_2015Fish <- renderPlot({
		if(input$filterIn==TRUE){
		if(input$yearIn=="2015"){
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn5[2],
						 site.ID %in% input$stnIn,
						 year=="2015") %>% 
			ggplot(aes(x=date, y=Number))+
			geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
			theme_classic()+
			labs(title="Juvenile Salmon Species Collected 2015", x="Date", y="Number of Salmon")+
			scale_fill_discrete(labels=c("Chum", "Pink", "Sockeye"))
		}} else{
			fish %>%
				filter(date >= input$dateIn5[1],
							 date <= input$dateIn5[2],
							 site.ID %in% input$stnIn,
							 year=="2015") %>% 
				ggplot(aes(x=date, y=Number))+
				geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
				theme_classic()+
				labs(title="Juvenile Salmon Species Collected 2015", x="Date", y="Number of Salmon")+
				scale_fill_discrete(labels=c("Chum", "Pink", "Sockeye"))
	}})
	
	output$Hist_2016Fish <- renderPlot({
		if(input$filterIn==TRUE){
		if(input$yearIn=="2016"){
		fish %>%
			filter(date >= input$dateIn6[1],
						 date <= input$dateIn6[2],
						 site.ID %in% input$stnIn,
						 year=="2016") %>% 
			ggplot(aes(x=date, y=Number))+
			geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
			theme_classic()+
			labs(title="Juvenile Salmon Species Collected 2016", x="Date", y="Number of Salmon")+
			scale_fill_discrete(labels=c("Chum", "Pink", "Sockeye"))
		}} else{
			fish %>%
				filter(date >= input$dateIn6[1],
							 date <= input$dateIn6[2],
							 site.ID %in% input$stnIn,
							 year=="2016") %>% 
				ggplot(aes(x=date, y=Number))+
				geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
				theme_classic()+
				labs(title="Juvenile Salmon Species Collected 2016", x="Date", y="Number of Salmon")+
				scale_fill_discrete(labels=c("Chum", "Pink", "Sockeye"))
	}})
	
	output$table_head <- renderTable({
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn6[2],
						 site.ID %in% input$stnIn,
						 year==input$yearIn) %>% 
			head()
	})
	
	output$textresults <- renderText({
		paste("We found",
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn6[2],
						 site.ID %in% input$stnIn,
						 Species=="pi",
						 year==input$yearIn) %>%
			summarise(sum(Number)),
		"pink,",
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn6[2],
						 site.ID %in% input$stnIn,
						 Species=="cu",
						 year==input$yearIn) %>%
			summarise(sum(Number)),
		"chum and",
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn6[2],
						 site.ID %in% input$stnIn,
						 Species=="so",
						 year==input$yearIn) %>%
			summarise(sum(Number)),
		"sockeye samples for you!")
		})
	
	output$downloadID <- downloadHandler(
		filename = function(){
			paste("salmon-data-", Sys.Date(), ".csv", sep="")
		},
		content = function(file){
			write_csv(fish %>%
									filter(date >= input$dateIn5[1],
												 date <= input$dateIn6[2],
												 site.ID %in% input$stnIn,
												 year==input$yearIn), file)
		})
	}