test_that("the output is a dataframe", {
  
  skip_if_not(nzchar(Sys.getenv('EPPO_token')), "API token not provided")
  
  kingdom <- queryTheEPPOForService("BEMITA", service = "kingdom")
  taxonomy <- queryTheEPPOForService("BEMITA", service = "taxonomy")
  
  expect_equal(is.data.frame(taxonomyRanked(taxonomy,kingdom)), TRUE)
})

test_that("if NULL is passed then it throws an error", {
  expect_error(taxonomyRanked())
})

test_that("if NAs are passed then it throws an error", {
  expect_error(taxonomyRanked(NA, NA))
})
