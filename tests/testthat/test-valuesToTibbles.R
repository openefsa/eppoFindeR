test_that("The data parameter must be a list", {
  expect_error(
    .valuesToTibbles(
      values = 123))
})

test_that("The result must be a list", {
  expect_true(
    is.list(
      .valuesToTibbles(
        values = list(
          a = list(x = 1:3, y = 4:6),
          b = list(x = 7:9, y = 10:12)))))
})

test_that("All the elements must be converted to a tibble", {
  data_ <- .valuesToTibbles(
    values = list(
      a = list(x = 1:3, y = 4:6),
      b = list(x = 7:9, y = 10:12)))
  
  expect_true(
    is.data.frame(
      data_$a))
  
  expect_true(
    is.data.frame(
      data_$b))
})
