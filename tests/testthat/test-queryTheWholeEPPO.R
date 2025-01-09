test_that("for a test code provides 7 different dataframes in the list", {
  expect_equal(length(queryTheWholeEPPO("BEMITA")), 7)
})

test_that("the names of the output list items are those of the services", {
  
  services <- c("general"
    , "names"
    , "taxonomy"
    , "categorization"
    , "hosts"
    , "pests"
    , "kingdom"
  )
  
  expect_equal(names(queryTheWholeEPPO("BEMITA")), services)
})
