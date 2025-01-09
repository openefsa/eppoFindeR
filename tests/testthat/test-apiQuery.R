test_that("output is a dataframe if NAs are passed", {
  expect_equal(is.data.frame(apiQuery("NA", "NA")), TRUE)
})
