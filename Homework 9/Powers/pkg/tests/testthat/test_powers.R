context("Powers")

test_that("pow calculates powers", {
	x <- -2
	a <- 5
	z <- -32
	expect_identical(pow(x, a), z)
})

test_that("square calculates squares", {
	x <- -10
	z <- 100
	expect_identical(square(x), z)
})

test_that("cube calculates cubes", {
	x <- -3
	z <- -27
	expect_identical(cube(x), z)
})

test_that("reciprocal calculates the inverse power", {
	x <- 5
	a <- 2
	z <- 0.04
	expect_identical(reciprocal(x, a), z)
})
