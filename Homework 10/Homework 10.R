#STAT 547 Homework 10 on APIs!#

library(httr)
#for working with APIs
library(listviewer)
#for using jsonedit() to view lists
library(purrr)
#for using map() and working with lists
suppressPackageStartupMessages(library(tidyverse))
#data manipulation and graphs, as always
library(stringr)
#for working with strings
suppressPackageStartupMessages(library(cowplot))
#creates nice plot defaults
library(varhandle)
#for using unfactor() on numeric data
library(forcats)
#for level reordering

sunny <- GET("https://ee.iva-api.com/Shows/2472?Includes=Genres&Includes=Descriptions&Includes=Seasons&subscription-Key=e0e7cacce3d246978c4d4d2bf9f0de54")
#retrieve the first large dataset of show description and episode titles by season

iasip <- as.list(content(sunny, as="parsed"))
#extract the raw content as something we can view

jsonedit(iasip)
#view it, get familiar with how to best extract relevant info

details <- iasip[["Descriptions"]]
#grab the descriptions from the list

details[[1]]$Description
#print out description 1, short version of what the show is about

details[[2]]$Description
#print out longer description, describing the show and some of the crazy topics

seasons <- iasip[["Seasons"]]
#extract seasons so we can then get all the episode titles

jsonedit(seasons)
#view the list to see where to extract episode titles

Id <- vector()
EpisodeNumber <- vector()
SeasonNumber <- vector()
OriginalTitle <- vector()
Title <- vector()
OriginalReleaseDate <- vector()
Year <- vector()
sun <- rbind(Id, EpisodeNumber, SeasonNumber, OriginalTitle, Title,
						 OriginalReleaseDate, Year)
bind <- data.frame()
#create empty vectors and dataframes for the for loop below

for (i in 1:12) {
	for(j in 1:length(seasons[[i]]$Episodes)){
		Id[j] <- seasons[[i]]$Episodes[[j]]$Id
		EpisodeNumber[j] <- seasons[[i]]$Episodes[[j]]$EpisodeNumber
		SeasonNumber[j] <- seasons[[i]]$Episodes[[j]]$SeasonNumber
		OriginalTitle[j] <- seasons[[i]]$Episodes[[j]]$OriginalTitle
		Title[j] <- seasons[[i]]$Episodes[[j]]$Title
		OriginalReleaseDate[j] <- seasons[[i]]$Episodes[[j]]$OriginalReleaseDate
		Year[j] <- seasons[[i]]$Episodes[[j]]$Year
	}
	bind <- rbind(Id, EpisodeNumber, SeasonNumber, OriginalTitle, Title,
								OriginalReleaseDate, Year)
	sun <- cbind(sun, bind)
	#for every season i and every episode j in each season, get Id, episode, title and date info
	Id <- vector()
	EpisodeNumber <- vector()
	SeasonNumber <- vector()
	OriginalTitle <- vector()
	Title <- vector()
	OriginalReleaseDate <- vector()
	Year <- vector()
	#reset vectors to empty before repeating because seasons have different number of episodes
	#otherwise later episodes from longer seasons will be repeated in the final dataframe
}

descrip <- function(Id){
	link <- paste("https://ee.iva-api.com/Shows/Seasons/Episodes/", Id, "?Includes=Descriptions&subscription-Key=e0e7cacce3d246978c4d4d2bf9f0de54", sep = "")
	ep <- RETRY("GET", link)
	episodes <- as.list(content(ep, as="parsed"))
	episodes$Descriptions[[1]]$Description
}
#create function to retrieve episode description info for each episode according to Id

reversed <- t(sun)
#flip rows and columns of dataframe created by the loop

tail(reversed)
#see if it worked correctly

new <- as.data.frame(reversed)
#since t() forces into a matrix, turn back into dataframe

new$Id <- as.character(new$Id)
#make sure Id is a character to be properly pasted into link for API retrieval

tail(new)
#see if it worked, everything looks great so far!

alwayssunny <- mutate(new, Description=map_chr(new$Id, descrip))
#map the get-episode-info function across dataframe for each episode!

#only work "downstream" from here!* (i.e. don't unnecessarily re-download it all!)#

tail(alwayssunny$Description)
#see if it worked, cool it did!

alwayssunny$OriginalReleaseDate <- as.character(alwayssunny$OriginalReleaseDate)
#change from factor to character to strip away all those zeros

split <- str_split_fixed(alwayssunny$OriginalReleaseDate, "T0", 2)
#split up into two columns, one for relevant date info, one for all the zeros

Date <- split[, 1]
#keep only the date info and save as vector named Date

philly <- cbind(alwayssunny, Date)
#combine back onto dataframe

which(philly$OriginalTitle != philly$Title)
#see if any of the titles have changed since being released

philly <- select(philly, -OriginalReleaseDate, -OriginalTitle)
#drop release date since we've updated it, drop orig. title since same as title

tail(philly)
#see how everything looks, so far, so good!

philly$Title <- as.character(philly$Title)
#change to character variable to find which episodes focus on specific characters

Charlie <- str_detect(philly$Title, "Charlie")
#find all episodes focused on Charlie
Dennis <- str_detect(philly$Title, paste(c("Dennis", "D.E.N.N.I.S."), collapse = "|"))
#find all episodes focused on Dennis, including The D.E.N.N.I.S System episode
Mac <- str_detect(philly$Title, "Mac")
#find all episodes focused on Mac
Dee <- str_detect(philly$Title, paste(c("Dee", "Aluminum Monster"), collapse = "|"))
#find all episodes focused on Dee, including The Aluminum Monster vs. Fatty Magoo, since Dee == Aluminum Monster
Frank <- str_detect(philly$Title, "Frank")
#find all episodes focused on Frank 
The_Gang <- str_detect(philly$Title, paste(c("The Gang", "Reynolds", "Chardee MacDennis", "Paddy's"),
																					 collapse = "|"))
#find all episodes focused on the five main characters as a group, when referenced as the gang or reynolds (dee, dennis and frank's family last name)
#and including episodes centered around Paddy's Pub where they work and chardee macdennis a game they play, named after themselves
Others <- str_detect(philly$Title, paste(c("Waitress", "Cricket", "Ponderosa", "Mom", "Brother", "Pop-Pop", "Pete", "Dad", "Fatty Magoo", "Bums"), collapse = "|"))
#find all episodes focused on non-central characters because I'm curious to see how often these occur!

characters <- cbind(Charlie, Mac, Dennis, Dee, Frank, The_Gang, Others)
#combine vectors into a dataframe!

characters <- as.data.frame(characters)
#it was coerced into a character matrix so now it's a real dataframe

for (i in 1:ncol(characters)) {
	characters[, i][which(characters[, i]==TRUE)] <- 1
	characters[, i][which(characters[, i]==FALSE)] <- 0
}
#change TRUE and FALSE to 1's and 0's so we can count how many episodes each character has

chartable <- characters %>%
	summarise(Charlie = sum(Charlie), Mac = sum(Mac), Dennis = sum(Dennis), Dee = sum(Dee),
						Frank = sum(Frank), The_Gang = sum(The_Gang), Others = sum(Others))
#sum up all the totals

knitr::kable(chartable, format = "markdown")
#print out as a table

charplot <- gather(chartable, "Characters", "NumEpisodes")
#gather to plot a histogram of same data presented in table

charplot$Characters <- as.factor(charplot$Characters)
#change to factor to make bars in bar chart in descending order

ggplot(charplot, aes(fct_reorder(Characters, NumEpisodes, .desc = TRUE), NumEpisodes))+
	geom_bar(stat = "identity")+
	labs(x=NULL)
#plot of which characters come up most frequently in episode titles

details[[2]]$Description
#print description again, the second half is how we will determine whether an episode is on an offensive topic

badwords <- str_split_fixed(details[[2]]$Description, "including", 2)
#split into two main chunks, the second one is the one we want here

badwords <- badwords[, 2]
#ditch the first half of that description chunk

badwords <- str_split(badwords, paste(c(",", "\\.", "and", "the", "physical"), collapse = "|"))
#split up by comma, get rid of any words like "and" or "the" and eliminate period from the end
#also, I put "physical" here because I wanted to drop it from "physical disabilities" (too long)

controversy <- as.data.frame(badwords[[1]])
#change from a list to a dataframe
colnames(controversy) <- "words"
#change the column name to something I can reference more easily
controversy$words <- as.character(controversy$words)
#change from factor to character (why is factor always the default?! *curses the skies*)

controversy <- str_split_fixed(controversy$words, " ", 2)
#split into two list items by first space to strip away space present before each entry
controversy <- controversy[, 2]
#keep only the second list item with words entries, drop empty one

controversy <- as.data.frame(controversy)
colnames(controversy) <- "words"
controversy$words <- as.character(controversy$words)
#because str_split always returns a list, repeat process as before
#i.e. remaking it a dataframe, renaming it, and making variables characters

controversy <- filter(controversy, words != "")
#filter out any empty values left over from string splitting
controversy <- str_split_fixed(controversy$words, " ", 2)
#split up multiple words into two list items (or two columns, as I visualize them)
controversy <- controversy[, 1]
#drop the second list item, only keeping the first word from each phrase

controversy <- as.data.frame(controversy)
colnames(controversy) <- "words"
controversy$words <- as.character(controversy$words)
#repeat list <- dataframe one last time (I know, next time I'll make a function!)

for (i in 1:nrow(controversy)) {
	controversy$words[i] <- str_trunc(controversy$words[i], width = 7, side = "right", ellipsis = "*")
}
#for each word, if longer than seven letters, truncate and add an asterix for easier matching!

controversy <- as.vector(controversy[, 1])
#change to a vector to be pasted together to find matches to episode descriptions

Offensive <- str_detect(philly$Description, str_c(controversy, collapse = "|"))
#find matches between controversial topics and episode descriptions

length(which(Offensive==TRUE))
#there are fifteen (out of 133) terribly offensive episodes!

which(Offensive==TRUE)
#it seems they are earlier in the show's history but we'll see in a plot as well

for (i in 1:length(Offensive)) {
	Offensive[i][which(Offensive[i]==TRUE)] <- 1
	Offensive[i][which(Offensive[i]==FALSE)] <- 0
}
#change TRUE and FALSE to 1's and 0's for offensive category episodes as well

always <- cbind(philly, characters, Offensive)
#combine dataframes with season info, character in title data, and offensive data

always$SeasonNumber <- unfactor(always$SeasonNumber)
#change from factor to numeric without the numbers acting weird like they do with `as.numeric(factor)`

write_csv(always, "alwayssunny.csv")
#write new dataframe to file to save!

seasonsums <- always %>%
	group_by(SeasonNumber) %>%
	summarise(Charlie = sum(Charlie), Mac = sum(Mac), Dennis = sum(Dennis), Dee = sum(Dee),
						Frank = sum(Frank), The_Gang = sum(The_Gang), Others = sum(Others), Offensive = sum(Offensive)) %>%
	gather(MainCharacters, NumEpisodes, Charlie:Frank, Others)
#get data for each season, summarizing all necessary character info

ggplot(seasonsums, aes(SeasonNumber, NumEpisodes))+
	geom_bar(aes(fill=MainCharacters), stat = "identity")+
	facet_wrap(~MainCharacters)+
	scale_x_continuous(breaks = seq(1:12))+
	theme(legend.position = "none")+
	ggtitle("Number of Episodes with Character in Title")
#plot of how frequently a character has a title episode and how it changed over time

ggplot(always, aes(SeasonNumber, Offensive))+
	stat_summary(fun.y = sum, geom = "bar", fill = "red", color = "black")+
	scale_x_continuous(breaks = seq(1:12))
#simple bar chart of how the frequency of offensive episodes has decreased over time

ggplot(always, aes(SeasonNumber, The_Gang))+
	stat_summary(fun.y = sum, geom = "bar", fill = "blue", color = "black")+
	scale_x_continuous(breaks = seq(1:12))
#simple bar chart of how frequently episodes are focused on "The Gang" as a whole