# Homework 3

## October 3rd, 2017

### Use dplyr to manipulate and explore data (also use ggplot2)
[Link to the STAT545 homework website!](http://stat545.com/hw03_dplyr-and-more-ggplot2.html)

Markdown file can be found [here](https://github.com/vanflad/STAT545-hw-fladmark-vanessa/blob/master/Homework%203/HW03.md) and R Markdown file, [here.](https://github.com/vanflad/STAT545-hw-fladmark-vanessa/blob/master/Homework%203/HW03.Rmd)

#### Troubleshooting:

It was tough to decide what graph to use to visualize min and max gdp for continents, I was oringinally thinking of a barplot but couldn't figure out how to get it to work the way I wanted it to, so I compared the min and max values in a scatterplot instead.

At first I couldn't figure out how to answer the "determine how many countries on each continent have a life expectancy less than this benchmark, for each year" question because it required two separate group_by functions, one for continent and one for year. I originally tried a number of error-creating or incorrect-table-creating combinations before discovering they could both be specified in one argument!

#### Helpful Links:

[Stack Overflow](https://stackoverflow.com/questions/5677885/ignore-outliers-in-ggplot2-boxplot) helped guide me on how to remove outliers and fix axis for ggplot boxplots!

I needed to look up how to fix the error: "stat_count() must not be used with a y aesthetic" even though it's a problem I've encountered before, I forgot until [Stack Overflow](https://stackoverflow.com/questions/39679057/r-ggplot2-stat-count-must-not-be-used-with-a-y-aesthetic-error-in-bar-graph/39679104) reminded me that the solution is to use the function geom_bar(stat="identity")

Also used geom_bar(position="dodge") function to get groups in barplot side by side rather than the stacked default, I found the correct formatting on how to do this from the [ggplot cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf), which is super helpful!
