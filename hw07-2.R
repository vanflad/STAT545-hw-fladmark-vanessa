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

#find the three worst and best countries for each continent:

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
#create subsets of dataframes for each continent

ocealevels <- fct_reorder(ocea$country, ocea$lifeExp, mean, .desc = TRUE) %>%
	levels()
#reorder country levels from highest mean life expectancy to lowest mean life exp.

oceatop3 <- ocealevels[1:3]
ocealow3 <- c(ocealevels[2:1], NA)
#oceania only has two countries so we have to add one NA value

eurolevels <- fct_reorder(euro$country, euro$lifeExp, mean, .desc = TRUE) %>%
	levels()
#reorder country levels again from high to low mean life expectancy

eurotop3 <- eurolevels[1:3]
eurolow3 <- eurolevels[length(eurolevels):(length(eurolevels)-2)]
#create vectors for the top three and the bottom three countries

amerlevels <- fct_reorder(amer$country, amer$lifeExp, mean, .desc = TRUE) %>%
	levels()
#repeat process, reorder levels

amertop3 <- amerlevels[1:3]
amerlow3 <- amerlevels[length(amerlevels):(length(amerlevels)-2)]
#repeat process, find three best and worst countries

asialevels <- fct_reorder(asia$country, asia$lifeExp, mean, .desc = TRUE) %>%
	levels()

asiatop3 <- asialevels[1:3]
asialow3 <- asialevels[length(asialevels):(length(asialevels)-2)]
#same for asia

afrclevels <- fct_reorder(afrc$country, afrc$lifeExp, mean, .desc = TRUE) %>%
	levels()

afrctop3 <- afrclevels[1:3]
afrclow3 <- afrclevels[length(afrclevels):(length(afrclevels)-2)]
#same for africa then we'll combine into a nice table

values <- rbind(oceatop3, eurotop3, amertop3, asiatop3, afrctop3, ocealow3, eurolow3, amerlow3, asialow3, afrclow3)
#add vectors on top of each other so each is one row

bestnworst <- cbind(levelinfo, values)
#add on continent information

colnames(bestnworst) <- c("Continent", "Country #1", "Country #2", "Country #3")
#rename so it looks nice

rownames(bestnworst) <- NULL
#eliminate vector names such as "oceatop3" from appearing in table

options(knitr.kable.NA="")
#make NA values in Oceania appear blank instead "NA"

knitr::kable(bestnworst, format = "latex", booktabs = TRUE) %>%
	kable_styling(latex_options = "striped") %>%
	group_rows("Best Countries", 1, 5) %>%
	group_rows("Worst Countries", 6, 10) %>% 
	kable_as_image("best-worst-country-by-life-exp")
#really fancy table saved to image to be embedded in final report

#create a figure for each continent and write each one to file with informative names:

lmocea <- lm(lifeExp ~ year, ocea)
#redo simple linear model since can't retrieve from for loop (oops!)

predocea <- data.frame(predlifeExp=predict(lmocea, ocea), year=ocea$year)
#create predicted values in order to plot linear model onto data

p3 <- ggplot(ocea, aes(year, lifeExp))+ 
	geom_point()+
	geom_line(color="blue", data = predocea, aes(year, predlifeExp))+
	facet_wrap(~country)+
	theme_bw()+
	guides(fill="none")
#create plot for oceania, factors are already in order (Aus, NZ)!

ggsave("oceania-life-exp-by-country.png", p3)
#save oceania plot to file

euro <- filter(euro, country %in% c(eurotop3, eurolow3))
#filter down to only top three and bottom three countries for europe

euro$country <- fct_relevel(euro$country, c(eurotop3, eurolow3))
#relevel the factors so they're in order on the plot

lmeuro <- lm(lifeExp ~ year, euro)
#redo simple linear model for europe

predeuro <- data.frame(predlifeExp=predict(lmeuro, euro), year=euro$year)
#create predicted values for europe

p4 <- ggplot(euro, aes(year, lifeExp))+ 
	geom_point()+
	geom_line(color="blue", data = predeuro, aes(year, predlifeExp))+
	facet_wrap(~country)+
	theme_bw()+
	guides(fill="none")
#create plot for europe!

ggsave("europe-life-exp-by-country.png", p4)
#save europe plot to file

amer <- filter(amer, country %in% c(amertop3, amerlow3))
#filter down to only top three and bottom three countries for the americas

amer$country <- fct_relevel(amer$country, c(amertop3, amerlow3))
#relevel the factors so they're in order on the plot

lmamer <- lm(lifeExp ~ year, amer)
#redo simple linear model for the americas

predamer <- data.frame(predlifeExp=predict(lmamer, amer), year=amer$year)
#create predicted values for the americas

p5 <- ggplot(amer, aes(year, lifeExp))+ 
	geom_point()+
	geom_line(color="blue", data = predamer, aes(year, predlifeExp))+
	facet_wrap(~country)+
	theme_bw()+
	guides(fill="none")
#create plot for the americas!

ggsave("americas-life-exp-by-country.png", p5)
#save the americas plot to file

asia <- filter(asia, country %in% c(asiatop3, asialow3))
#filter down to only top three and bottom three countries for asia

asia$country <- fct_relevel(asia$country, c(asiatop3, asialow3))
#relevel the factors so they're in order on the plot

lmasia <- lm(lifeExp ~ year, asia)
#redo simple linear model for asia

predasia <- data.frame(predlifeExp=predict(lmasia, asia), year=asia$year)
#create predicted values for asia

p6 <- ggplot(asia, aes(year, lifeExp))+ 
	geom_point()+
	geom_line(color="blue", data = predasia, aes(year, predlifeExp))+
	facet_wrap(~country)+
	theme_bw()+
	guides(fill="none")
#create plot for asia!

ggsave("asia-life-exp-by-country.png", p6)
#save asia plot to file

afrc <- filter(afrc, country %in% c(afrctop3, afrclow3))
#filter down to only top three and bottom three countries for africa

afrc$country <- fct_relevel(afrc$country, c(afrctop3, afrclow3))
#relevel the factors so they're in order on the plot

lmafrc <- lm(lifeExp ~ year, afrc)
#redo simple linear model for africa

predafrc <- data.frame(predlifeExp=predict(lmafrc, afrc), year=afrc$year)
#create predicted values for africa

p7 <- ggplot(afrc, aes(year, lifeExp))+ 
	geom_point()+
	geom_line(color="blue", data = predafrc, aes(year, predlifeExp))+
	facet_wrap(~country)+
	theme_bw()+
	guides(fill="none")
#create plot for africa!

ggsave("africa-life-exp-by-country.png", p7)
#save africa plot to file