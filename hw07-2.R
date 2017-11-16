#stat547 hw07 rscript02

suppressPackageStartupMessages(library(tidyverse))
#load tidyverse for this script as well

suppressWarnings(library(kableExtra))
#for making beautiful tables and saving them as images

library(broom)
#load library for linear model output data organization

library(forcats)
#for more level reordering fun

rm(newgap)
#remove from R environment to make sure I'm only using the read in file

newgap <- dget("gapminder-continents-ordered-by-life-exp.txt")
#read in new modified gapminder file

#check if the continent ordering is still as it should be:

levels(newgap$continent)
#the levels are still in order!

head(newgap)
#and the dataframe is still in order because oceania is first!

#fit a linear regression of life expectancy on year for each country:

levelinfo <- levels(newgap$continent)
#create small vector that has the ordered factor levels

modelinfo <- data.frame()
Continent <- vector()
#create relevant empty dataframe and vector for the for loop

for (i in 1:length(levels(newgap$continent))){
	filt <- filter(newgap, continent==levels(continent)[i])
	lmfit <- lm(lifeExp ~ year, filt)
	z <- tidy(lmfit)
	x <- levelinfo[i]
	Continent <- c(Continent, x, x)
	modelinfo <- rbind(z, modelinfo)
}
#for loop adding together linear model outputs for each continent

models <- cbind(Continent, modelinfo)
#add on continent info as a column

write_csv(models, "linear-model-outputs.csv")
#write the estimated intercepts, slopes and residual error variance (sd) to file

#let's make a nice table of that linear model data as well:

intercepts <- filter(models, term=="(Intercept)")
slopes <- filter(models, term=="year")
#separate intercept and slope for optimal organization

nicetable <- rbind(intercepts, slopes) %>%
	select(-term)
#combine intercept and slope info and drop column for intercept/slope term

knitr::kable(nicetable, format = "latex", booktabs = TRUE, caption = "Linear Model Outputs") %>%
	kable_styling(latex_options = "striped") %>%
	group_rows("Intercept", 1, 5) %>%
	group_rows("Slope", 6, 10) %>% 
	kable_as_image("linear-model-outputs-table")
#make a very fancy table with intercept and slope labels!

ocea <- filter(newgap, continent=="Oceania") %>%
	droplevels()

euro <- filter(newgap, continent=="Europe") %>%
	droplevels()

amer <- filter(newgap, continent=="Americas") %>%
	droplevels()

asia <- filter(newgap, continent=="Asia") %>%
	droplevels()

afrc <- filter(newgap, continent=="Africa") %>%
	droplevels()
#subset dataframes for each continent to find best/worst countries in each

dput(ocea, "oceania.txt")
dput(euro, "europe.txt")
dput(amer, "americas.txt")
dput(asia, "asia.txt")
dput(afrc, "africa.txt")
#write new subsetted dataframes to file for next script!