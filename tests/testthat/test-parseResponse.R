test_that("The response parameter must be an httr2_response object", {
  expect_error(
    .parseResponse(
      response = 123))
})

test_that("Expect an error if the response delivers invalid data", {
  response_ <- httr2::response(
    status_code = 200,
    url = "https://api.eppo.int/gd/v2/status",
    method = "GET",
    headers = list("Content-Type" = "application/json"),
    body = charToRaw("{'a': 1,"))
  
  expect_error(
    .parseResponse(
      response = response_))
})

test_that("Expect no error if all the parameters are correct", {
  response_ <- httr2::response(
    status_code = 200,
    url = "https://api.eppo.int/gd/v2/status",
    method = "GET",
    headers = list("Content-Type" = "application/json"),
    body = charToRaw("{\"a\": 1}"))
  
  expect_no_error(
    .parseResponse(
      response = response_))
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no error if all the parameters are correct", {
  skip_on_cran()
  
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/taxons/taxon/BEMITA/overview",
    apiKey = Sys.getenv("EPPO_API_KEY"))
  
  response_ <- .performRequest(request = request_)
  
  expect_no_error(
    .parseResponse(
      response = response_))
})
