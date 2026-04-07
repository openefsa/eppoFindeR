test_that("The data parameter must be a list", {
  expect_error(
    .valuesToTibblesBatch(
      nestedValues = 123,
      parentColumnName = "name"))
})

test_that("The column name must be a string", {
  expect_error(
    .valuesToTibblesBatch(
      nestedValues = list(),
      parentColumnName =123))
})

test_that("The result must be a list", {
  nestedList_ <- list(
    Group1 = list(a = data.frame(x = 1:2), b = data.frame(y = 3:4)),
    Group2 = list(a = data.frame(x = 5:6), b = data.frame(y = 7:8))
  )
  
  expect_true(
    is.list(
      .valuesToTibblesBatch(
        nestedValues = nestedList_,
        parentColumnName = "group")))
})

test_that("The resulting tibbles must contain the parent list name", {
  nestedList_ <- list(
    Group1 = list(a = data.frame(x = 1:2), b = data.frame(y = 3:4)),
    Group2 = list(a = data.frame(x = 5:6), b = data.frame(y = 7:8))
  )
  
  result_ <- .valuesToTibblesBatch(
    nestedValues = nestedList_,
    parentColumnName = "group")
  
  expect_true("Group1" %in% result_$Group1$a$group)
  expect_true("Group1" %in% result_$Group1$a$group)
  expect_true("Group2" %in% result_$Group2$b$group)
  expect_true("Group2" %in% result_$Group2$b$group)
})
