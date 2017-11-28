#' Powers
#'
#' @name Powers
#' @docType package
#'
#' @param x The vector to be transformed (squared/cubed/etc.)
#' 
#' @param a The power to be calculated to, for the transformation
#'
#' @return A vector \code{x} that is raised to the power of \code{a}.
#'
#' @details
#' 
#' This is a simple package that calculates powers, which is a number multiplied by itself a certain amount of times.
#'
#' The functions include:
#' \itemize{
#'      \item powers (for \code{pow})
#'      \item square (for \code{square})
#'      \item cube (for \code{cube})
#'      \item reciprocal/inverse (for \code{reciprocal})
#' }
#' 
#' Each function also returns an informative error when a non-numeric input is given.
#'
#' @examples
#' pow(-3, 4)
#' square(1:10)
#' cube(-5)
#' reciprocal(-2, 3)
#' @export
NULL
