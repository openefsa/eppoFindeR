test_that("The taxonomy must be provided in a dataframe", {
  expect_error(
    uniformTaxonomy(
      taxonomyData = 123))
})

test_that("The taxonomy dataframe must contain mandatory columns", {
  expect_error(
    uniformTaxonomy(
      taxonomyData = tibble()))
})

test_that("The queried_eppo_code column must have at least a non-NA value", {
  expect_error(
    uniformTaxonomy(
      taxonomyData = tibble(queried_eppo_code = c(NA, NA, NA))))
})

test_that("The output must be a dataframe", {
  taxonomyData_ <- tibble(
    queried_eppo_code = c("A", "B", "C"),
    eppocode = c("D", "E", "F"),
    prefname = c("G", "H", "I"),
    level = c(1, 2, 3),
    type = c("J", "K", "L"),
    queried_url = c("M", "N", "O"),
    queried_on = c("P", "Q", "R")
  )
  
  expect_true(
    is.data.frame(
      uniformTaxonomy(
        taxonomyData = taxonomyData_)))
})
