hw01\_gapminder
================

Homework assignment \#1
=======================

September 19th, 2017
--------------------

In this assignment I will:
1. Practice making a simple scatterplot
2. Load gapminder and tidyverse
3. Investigate a few ways to view gapminder dataframe
4. Make a couple graphs from the gapminder dataframe

### Scatterplot

``` r
x <- rnorm(100)
y <- rnorm(100)
plot(x,y)
```

![](hw01_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-1-1.png)

### Loading the packages

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(gapminder)
```

### Viewing the data

``` r
summary(gapminder)
```

    ##         country        continent        year         lifeExp     
    ##  Afghanistan:  12   Africa  :624   Min.   :1952   Min.   :23.60  
    ##  Albania    :  12   Americas:300   1st Qu.:1966   1st Qu.:48.20  
    ##  Algeria    :  12   Asia    :396   Median :1980   Median :60.71  
    ##  Angola     :  12   Europe  :360   Mean   :1980   Mean   :59.47  
    ##  Argentina  :  12   Oceania : 24   3rd Qu.:1993   3rd Qu.:70.85  
    ##  Australia  :  12                  Max.   :2007   Max.   :82.60  
    ##  (Other)    :1632                                                
    ##       pop              gdpPercap       
    ##  Min.   :6.001e+04   Min.   :   241.2  
    ##  1st Qu.:2.794e+06   1st Qu.:  1202.1  
    ##  Median :7.024e+06   Median :  3531.8  
    ##  Mean   :2.960e+07   Mean   :  7215.3  
    ##  3rd Qu.:1.959e+07   3rd Qu.:  9325.5  
    ##  Max.   :1.319e+09   Max.   :113523.1  
    ## 

``` r
dim(gapminder)
```

    ## [1] 1704    6

``` r
summary(gapminder$continent)
```

    ##   Africa Americas     Asia   Europe  Oceania 
    ##      624      300      396      360       24

### Plotting the data

``` r
plot(lifeExp ~ log(gdpPercap), gapminder)
```

![](hw01_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-4-1.png)

``` r
hist(gapminder$lifeExp)
```

![](hw01_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-5-1.png)

``` r
barplot(table(gapminder$continent))
```

![](hw01_gapminder_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-6-1.png)
