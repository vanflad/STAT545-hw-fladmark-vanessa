#' Cube a vector
#'
#' This function simply cubes a vector!
#'
#' @param x The vector to be cubed.
#'
#' @return A vector that is the cube of \code{x}.
#'
#' @details
#' 
#' A number multiplied thrice by itself is called "cubed" or "to the power of 3."
#' 
#' This function utilizes the pow() function in the same package to calculate cubes of numbers.
#'
#' This function also returns an informative error when a non-numeric input is given.
#'
#' @examples
#' cube(1:10)
#' cube(-3)
#' @export

cube <- function(x) {
	if(is.numeric(x)==TRUE){
		pow(x, a=3)
	} else {
		stop("Sorry, this function requires a numeric input!\n",
				 "You have provided an object of class ", class(x))
	}
}
