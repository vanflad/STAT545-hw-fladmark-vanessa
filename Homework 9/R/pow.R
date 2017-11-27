#' Calculate the power of a vector
#'
#' That's it -- this function just calculates to the power of "a" for a vector.
#'
#' @param x The vector to be squared/cubed/to the power of whatever.
#'
#' @return A vector that is the power of \code{x}.
#'
#' @details
#' This function isn't complicated.
#'
#' And it almost certainly doesn't need two paragraphs in the "Details"
#' section!
#'
#' Here are some reasons why putting a list in this section is excessive:
#' \itemize{
#'      \item This \code{square} function is quite simple.
#'      \item There's nothing else to say about \code{square}.
#' }
#'
#' @examples
#' pow(1:10, 2)
#' pow(-5, 3)
#' @export

pow <- function(x, a) x^a
