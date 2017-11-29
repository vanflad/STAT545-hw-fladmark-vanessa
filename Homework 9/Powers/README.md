Homework 9 Links
----------------

Since this is the README of the github folder containing the powers package scripts and info, here are the links where you can find all the necessary files and websites I found for troubleshooting!

-   Folder with [R scripts](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/tree/master/Homework%209/Powers/R) for functions
-   The powers package [vignette](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%209/Powers/vignettes/my_vignette.md)
-   [Description](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%209/Powers/DESCRIPTION), [Namespace](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%209/Powers/NAMESPACE) and [License](https://github.com/vanflad/STAT547-hw-fladmark-vanessa/blob/master/Homework%209/Powers/LICENSE) in case you want to see those
-   Homework [instructions](http://stat545.com/hw09_package.html) from STAT545/547 website
-   Link to Vincenzo's github with some [powers package](https://github.com/vincenzocoia/powers/blob/master/R/pow.R) details that helped get me started
-   Couldn't get the [package to download from Github](https://stackoverflow.com/questions/31424883/how-do-i-install-rhadoop-package-rhdfs-from-github-using-devtools) and I realized the link given inside `devtools::install_github()` has to be given in a very specific format using `subdir = "Homework 9/Powers"` as I discovered from Stack Overflow!
-   How to get an [.md file for the vignette](https://github.com/klutometis/roxygen/issues/314), I learned to use `rmarkdown::render("my_vignette.Rmd", "github_document")` in the Console of RStudio

Powers
------

In order to download my package, use the following code to install (then don't forget to load `library(Powers)` afterwards)!

``` r
devtools::install_github("vanflad/STAT547-hw-fladmark-vanessa", subdir = "Homework 9/Powers")
```

    ## Downloading GitHub repo vanflad/STAT547-hw-fladmark-vanessa@master
    ## from URL https://api.github.com/repos/vanflad/STAT547-hw-fladmark-vanessa/zipball/master

    ## Installing Powers

    ## '/Library/Frameworks/R.framework/Resources/bin/R' --no-site-file  \
    ##   --no-environ --no-save --no-restore --quiet CMD INSTALL  \
    ##   '/private/var/folders/jg/fx3473r119s8l9gc9jtzm_n00000gn/T/RtmpLzGEpS/devtools6fca425c7d1/vanflad-STAT547-hw-fladmark-vanessa-e274583/Homework  \
    ##   9/Powers'  \
    ##   --library='/Library/Frameworks/R.framework/Versions/3.4/Resources/library'  \
    ##   --install-tests

    ## 

The goal of powers is to calculate the exponential power of a number! There are a variety of functions to choose from, such as `square()`, `cube()`, `reciprocal()` and `pow()` for calculating to the power of two, the power of three, the inverse of a power and the power of any given number `a`, respectively.
