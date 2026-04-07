test_that("The result must be a tibble", {
  expect_true(
    is.data.frame(
      .valueToTibble(
        value = list(x = 1:3, y = 4:6))))
})
