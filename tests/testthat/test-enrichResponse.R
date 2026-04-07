test_that("The response data must be a list or a dataframe", {
  expect_error(
    .enrichResponse(
      responseData = 123,
      url = ""))
})

test_that("The URL must be a string", {
  expect_error(
    .enrichResponse(
      responseData = list(),
      url = 123))
})

test_that("Expect no errors if the parameters are correct", {
  enrichedData_ <- .enrichResponse(
    responseData = list(),
    url = "https://example.org")
  expect_true("queried_on" %in% names(enrichedData_))
  expect_equal(enrichedData_$queried_url, "https://example.org")
})
