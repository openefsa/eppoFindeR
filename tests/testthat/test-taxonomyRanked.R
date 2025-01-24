library(dplyr)

test_that("the output is a dataframe", {
  taxonomy <- tibble(
    eppocode = c("A", "B", "C"),
    queriedEppocode = c("X", "Y", "Z"),
    column_3 = c("X", "Y", "Z"))
  
  kingdom <- tibble(
    eppocode = c("A", "B", "C"),
    queriedEppocode = c("X", "Y", "Z"),
    status = c("kingdom", "Y", "Z"),
    column_4 = c("X", "Y", "Z"))
  
  expect_equal(is.data.frame(taxonomyRanked(taxonomy,kingdom)), TRUE)
})
