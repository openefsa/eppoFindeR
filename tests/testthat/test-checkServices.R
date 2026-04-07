test_that("Services must be specified in a vector", {
  expect_error(
    .checkServices(
      services = 123,
      choices = c("a", "b", "c")))
})

test_that("Choices must be specified in a vector", {
  expect_error(
    .checkServices(
      services = c("a", "b", "c"),
      choices = 123))
})

test_that("Services must be contained in choices", {
  expect_error(
    .checkServices(
      services = c("a", "b"),
      choices = c("d", "e", "f")))
})

test_that("Excepct no error if services are contained in choices", {
  expect_no_error(
    .checkServices(
      services = c("a", "b"),
      choices = c("a", "b", "c")))
})
