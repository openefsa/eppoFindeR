test_that("The URL must be a string", {
  expect_error(
    .buildRequest(
      url = 123,
      apiKey = "EPPO_API_KEY"))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    .buildRequest(
      url = "https://example.org",
      apiKey = "EPPO_API_KEY",
      params = 123))
})

test_that("The API key must be a string", {
  expect_error(
    .buildRequest(
      url = "https://example.org",
      apiKey = 123))
})

test_that("The list of non-failure codes must be a vector", {
  expect_error(
    .buildRequest(
      url = "https://example.org",
      apiKey = "EPPO_API_KEY",
      doNotFailOn = NULL))
})

test_that("The result must be a httr2_request", {
  expect_s3_class(
    .buildRequest(
      url = "https://example.org",
      apiKey = "EPPO_API_KEY"),
    "httr2_request")
})
