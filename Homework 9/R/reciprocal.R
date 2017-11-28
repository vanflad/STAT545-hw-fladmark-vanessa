#' Reciprocals
#'
#' This function calculates the inverse power of a vector
#'
#' @param x The vector to be transformed (squared/cubed/etc.)
#' 
#' @param a The power to be calculated to, for the transformation
#'
#' @return A vector \code{x} that is the inverse of the power of \code{a}.
#'
#' @details
#' 
#' This function calculates the inverse or "reciprocal" of powers, that is 1/X^a
#' 
#' For example, the inverse of 10 to the power of 2 is 1/100 = 0.01
#'
#' This function also returns an informative error when a non-numeric input is given.
#'
#' @examples
#' reciprocal(-2, 3)
#' reciprocal(1:10, 2)
#' @export

reciprocal <- function(x, a) {
	if(is.numeric(x)==TRUE & is.numeric(a)==TRUE){
		x^-a
	} else {
		stop("Sorry, this function requires two numeric inputs!\n",
				 "You have provided objects of class ", class(x), " and ", class(a))
	}
}
