server <- function(input, output){
	
	library(readr)
	library(tidyverse)
	fish <- readr::read_csv(file="fish.csv")
	library(stringr)
	fish$date <- as.character(fish$date)
	fish <- mutate(fish, year=str_trunc(date, 4, ellipsis = ""))
	fish$date <- as.Date(fish$date)
	
	colnames(fish)[5:7] <- str_trunc(colnames(fish[5:7]), 2, ellipsis = "")
	fish <- gather(fish, Species, Number, so:pi, na.rm = TRUE)
	
	fish$site.ID <- as.factor(fish$site.ID)
	
	output$Hist_2015Fish <- renderPlot({
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn5[2],
						 site.ID == input$stnIn,
						 year == "2015") %>% 
			ggplot(aes(x=date, y=Number))+
			geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
			theme_classic()
	})
	
	output$Hist_2016Fish <- renderPlot({
		fish %>%
			filter(date >= input$dateIn6[1],
						 date <= input$dateIn6[2],
						 site.ID == input$stnIn,
						 year == "2016") %>% 
			ggplot(aes(x=date, y=Number))+
			geom_bar(aes(fill=Species), stat = "identity", position = "dodge")+
			theme_classic()
	})
	
	output$table_head <- renderTable({
		fish %>%
			filter(date >= input$dateIn5[1],
						 date <= input$dateIn6[2],
						 site.ID == input$stnIn) %>% 
			head()
	})
	
}