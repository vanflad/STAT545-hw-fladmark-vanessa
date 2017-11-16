#simple main r script to run them all!

source("hw07-1.R")
#first script which outputs two graphs and one datafile
source("hw07-2.R")
#second script that reads in data and outputs multiple datafiles and a table
source("hw07-3.R")
#third script that reads in data and outputs one table and five plots!
rmarkdown::render('HW07.Rmd')
#nice neat report with everything in there