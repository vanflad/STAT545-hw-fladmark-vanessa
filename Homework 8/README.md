#  Homework 8

## Building a Shiny App!

### November 21st, 2017


Relevant Links:

* The [homework instructions](http://stat545.com/hw08_shiny.html)

* Behold! The [Shiny app](https://vanflad.shinyapps.io/Juvenile_Salmon_Sampling/) in all it's glory!

* The [folder](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/tree/master/Homework%208/Shiny) with all the code where [ui.R](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%208/Shiny/ui.R), [server.R](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%208/Shiny/server.R) and [app.R](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%208/Shiny/app.R) reside

* The [raw data](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/tree/master/Homework%208/data) from Hakai's sampling program if you feel so inclined to take a look!

The data I've chosen for this assignment is to assist me in choosing which stations and dates I would like to select fish samples from to analyze their stomach contents/diets and see if different species of juvenile salmon are competing for food resources during a critical time in their early marine migration. So I've included a map of the Discovery Islands (D## sites) and Johnstone Strait (J## sites) because this is the area I would like to investigate, and 2015-2016 are the relevant years, with sampling taking place from May-July each year. Since pink salmon abundance fluctuates every other year, they were the limiting species for sampling, and for my project I need to ensure I have a sufficient number of samples and enough overlap across all three species for comparisons. As I needed an interactive way to view the data and how the number of each species sampled changes over time and across sites, I thought it would be perfect for the assignment and even though it may not be relevant to you since it doesn't have cool info about booze, hopefully you still think it's really neat because I'm sure proud as hell of this fancy Shiny app!!

![](https://raw.githubusercontent.com/vanflad/STAT547-hw-fladmark-vanessa/master/Homework%208/Shiny/www/map.png)

Trouble-shooting Links:

* Cheetsheet on [Shiny](http://shiny.rstudio.com/images/shiny-cheatsheet.pdf) from R Studio

* Solving the error message when first attempting to [publish](https://support.rstudio.com/hc/en-us/articles/220339568-What-does-Disconnected-from-Server-mean-in-shinyapps-io-) onto shiny.io

* How to properly use `if(){}else{}` [functions](http://www.dummies.com/programming/r/how-to-chain-ifelse-statements-in-r/) for `conditionalPanel()` coding use

* Why isn't my [`dataTableOutput` rendering](https://github.com/rstudio/DT/issues/140) when published?! Oh, it's because the `DT` library needs to be included in both server and ui, either using `library(DT)` or `DT::dataTableOutput`, as another Github user discovered for me!

* Apparently when refering to a [reactive dataframe you have to include parenthesis](https://stackoverflow.com/questions/40185762/object-of-type-closure-is-not-subsettable-r-shiny-app) afterward such as `fish()` in my example, as I discovered troubleshooting on Stack Overflow
