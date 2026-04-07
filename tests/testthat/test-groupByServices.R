test_that("The data parameter must be a list", {
  expect_error(
    .groupByServices(
      datasets = 123))
})

test_that("The result must be a list", {
  nestedList_ <- list(
    Group1 = list(
      a = data.frame(x = 1:2, queried_url = NA, queried_on = NA),
      b = data.frame(y = 3:4, queried_url = NA, queried_on = NA)),
    Group2 = list(
      a = data.frame(x = 5:6, queried_url = NA, queried_on = NA),
      b = data.frame(y = 7:8, queried_url = NA, queried_on = NA))
  )
  
  result_ <- .valuesToTibblesBatch(
    nestedValues = nestedList_,
    parentColumnName = "group")
  
  expect_true(
    is.list(
      .groupByServices(
        datasets = result_)))
})

test_that("The resulting list must contain service names", {
  nestedList_ <- list(
    Group1 = list(
      a = data.frame(x = 1:2, queried_url = NA, queried_on = NA),
      b = data.frame(y = 3:4, queried_url = NA, queried_on = NA)),
    Group2 = list(
      a = data.frame(x = 5:6, queried_url = NA, queried_on = NA),
      b = data.frame(y = 7:8, queried_url = NA, queried_on = NA))
  )
  
  result_ <- .valuesToTibblesBatch(
    nestedValues = nestedList_,
    parentColumnName = "group")
  
  result_ <- .groupByServices(
    datasets = result_)
  
  expect_equal(
    names(
      result_),
    c("a", "b"))
})

test_that("The resulting tibbles must contain the parent list name", {
  nestedList_ <- list(
    Group1 = list(
      a = data.frame(x = 1:2, queried_url = NA, queried_on = NA),
      b = data.frame(y = 3:4, queried_url = NA, queried_on = NA)),
    Group2 = list(
      a = data.frame(x = 5:6, queried_url = NA, queried_on = NA),
      b = data.frame(y = 7:8, queried_url = NA, queried_on = NA))
  )
  
  result_ <- .valuesToTibblesBatch(
    nestedValues = nestedList_,
    parentColumnName = "group")
  
  result_ <- .groupByServices(
    datasets = result_)
  
  expect_true("Group1" %in% result_$a$group)
  expect_true("Group2" %in% result_$a$group)
  expect_true("Group1" %in% result_$b$group)
  expect_true("Group2" %in% result_$b$group)
})
