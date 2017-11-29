#' Square a vector
#'
#' That's it -- this function just squares a vector!
#'
#' @param x The vector to be squared.
#'
#' @return A vector that is the square of \code{x}.
#'
#' @details
#' 
#' A number multiplied by itself is called "squared" or "to the power of 2."
#' 
#' This function utilizes the pow() function in the same package to calculate squares of numbers.
#'
#' This function also returns an informative error when a non-numeric input is given.
#'
#' @examples
#' square(1:10)
#' square(-5)
#' @export

square <- function(x) {
	if(is.numeric(x)==TRUE){
		pow(x, a=2)
	} else {
		stop("Sorry, this function requires a numeric input!\n",
				 "You have provided an object of class ", class(x))
	}
}
