#stat547 hw07 rscript03

suppressPackageStartupMessages(library(tidyverse))
#live by the tidyverse, die by the tidyverse

suppressWarnings(library(kableExtra))
#for making more tables!

library(forcats)
#for more level reordering because defaults suck!

ocea <- dget("oceania.txt")
euro <- dget("europe.txt")
amer <- dget("americas.txt")
asia <- dget("asia.txt")
afrc <- dget("africa.txt")
#read in the filtered continent-only files!

#find the three worst and best countries for each continent:

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
#save africa plot to file and done!