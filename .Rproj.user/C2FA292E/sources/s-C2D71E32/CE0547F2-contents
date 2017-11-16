#stat547 hw07 rscript01

suppressPackageStartupMessages(library(tidyverse))
#as always load tidyverse

library(forcats)
#load forcats for level reordering

library(gapminder)
#load gapminder data

#save a couple descriptive plots to file with informative names:

p1 <- ggplot(gapminder, aes(year, lifeExp))+
  geom_point()+
  theme_bw()+
  facet_wrap(~continent)
#plot for life exp over time for each continent

ggsave("life-exp-over-time-each-continent.png", p1)
#write graph to file

p2 <- ggplot(gapminder, aes(year, lifeExp))+
  geom_point(aes(color=continent), position="jitter")+
  theme_bw()
#plot of life exp over time for all continents

ggsave("life-exp-over-time-all-continents.png", p2)
#write graph to file

#reorder the continents based on life expectancy:

newlevels <- fct_reorder(gapminder$continent, gapminder$lifeExp, mean, .desc = TRUE) %>%
	levels()
#calculate what the reordered factors should be and assign to a vector

newlevels
#see what the levels are

gapminder$continent <- fct_relevel(gapminder$continent, newlevels)
#assign the new levels to gapminder dataset

levels(gapminder$continent)
#see if it worked, it did!

#then sort the data using new continent ordering:

newgap <- data.frame()
#create empty dataframe to be used in for loop

for (i in 1:length(levels(gapminder$continent))){
    filt <- filter(gapminder, continent==levels(continent)[i])
    newgap <- rbind(newgap, filt)
  }
#create new dataframe where the rows are organized by level order!

head(newgap)
#see if it worked, it did because Oceania is first!

dput(newgap, "gapminder-continents-ordered-by-life-exp.txt")
#then write data to file and read into next r script file!