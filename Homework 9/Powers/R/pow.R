#' Powers
#'
#' This function calculates the power of a vector
#'
#' @param x The vector to be transformed (squared/cubed/etc.)
#' 
#' @param a The power to be calculated to, for the transformation
#'
#' @return A vector \code{x} that is raised to the power of \code{a}.
#'
#' @details
#' 
#' This is a simple function that calculates powers, which is a number multiplied by itself a certain amount of times.
#'
#' For example, 2 to the power of 4 is 2 multiplied by 2 and repeated 4 times, the result of which is 16.
#' 
#' This function also returns an informative error when a non-numeric input is given.
#'
#' @examples
#' pow(-2, 4)
#' pow(1:10, 4)
#' @export

pow <- function(x, a) {
	if(is.numeric(x)==TRUE & is.numeric(a)==TRUE){
		x^a
	} else {
		stop("Sorry, this function requires two numeric inputs!\n",
				 "You have provided objects of class ", class(x), " and ", class(a))
	}
}
