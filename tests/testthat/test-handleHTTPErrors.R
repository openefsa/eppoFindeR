test_that("The response parameter must be an httr2_response object", {
  expect_error(.handleHTTPErrors(response = 123))
})

test_that("The function must fail for invalid error codes", {
  response_ <- httr2::response(
    status_code = 403,
    url = "https://api.eppo.int/gd/v2/status",
    method = "GET",
    headers = list("Content-Type" = "text/html"),
    body = charToRaw("<html>error</html>"))
  
  expect_error(
    .handleHTTPErrors(
      response = response_))
})

test_that("The function must succeed for valid error codes", {
  response_ <- httr2::response(
    status_code = 200,
    url = "https://api.eppo.int/gd/v2/status",
    method = "GET",
    headers = list("Content-Type" = "application/json"),
    body = charToRaw("{\"a\": 1}"))
  
  expect_no_error(
    .handleHTTPErrors(
      response = response_))
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The function must succeed for valid error codes", {
  skip_on_cran()
  
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/status",
    apiKey = Sys.getenv("EPPO_API_KEY"))
  
  response_ <- .performRequest(
    request = request_)
  
  expect_no_error(
    .handleHTTPErrors(
      response = response_))
})
