#simple main r script to run them all!

source("hw07-1.R")
#first script which outputs two graphs and one datafile
source("hw07-2.R")
#second script that reads in data and outputs multiple datafiles and a table
source("hw07-3.R")
#third script that reads in data and outputs one table and five plots!
rmarkdown::render('HW07.Rmd')
#nice neat report with everything in there

toremove <- list("africa-life-exp-by-country.png", "americas-life-exp-by-country.png", "asia-life-exp-by-country.png", "oceania-life-exp-by-country.png", "europe-life-exp-by-country.png",
								 "africa.txt", "americas.txt", "asia.txt", "oceania.txt", "europe.txt", "gapminder-continents-ordered-by-life-exp.txt",
								 "best-worst-countries-by-life-exp.png", "life-exp-over-time-all-continents.png", "life-exp-over-time-each-continent.png",
								 "linear-model-outputs-table.png", "linear-model-outputs.csv")
#make a list of all the extra stuff that need to be removed

remove(toremove)
#remove it all!