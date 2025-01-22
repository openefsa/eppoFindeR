test_that("the number of items/dataframes in the list if 7", {
  expect_equal(length(dataDump(c("BEMITA", "LEUCSC"))), 7)
})

test_that("the names of the items/dataframes in the list are the services", {
  
  services <- c("general"
                , "names"
                , "taxonomy"
                , "categorization"
                , "hosts"
                , "pests"
                , "kingdom"
  )
  
  expect_equal(names(dataDump(c("BEMITA", "LEUCSC"))), services)
  
})
