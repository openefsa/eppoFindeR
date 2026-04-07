test_that("The request parameter must be an httr2_request object", {
  expect_error(
    .performRequest(
      request = 123))
})

test_that("Expect an error if the request is malformed", {
  request_ <- .buildRequest(
    url = "https://invalid_domain",
    apiKey = "api_key")
  
  expect_error(
    .performRequest(
      request = request_))
})

test_that("Expect no error if all the request object is correct", {
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/taxons/taxon/BEMITA/overview",
    apiKey = "EPPO_API_KEY")
  
  response_ <- httr2::response(
    status_code = 200)
  
  with_mocked_bindings(
    req_perform = function(request) {
      return(response_)
    }, {
      expect_no_error(
        .performRequest(
          request = request_))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no error if all the request object is correct", {
  skip_on_cran()
  
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/taxons/taxon/BEMITA/overview",
    apiKey = Sys.getenv("EPPO_API_KEY"))
  
  expect_no_error(
    .performRequest(
      request = request_))
})

test_that("The function must behave as expected for error status codes", {
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/status",
    apiKey = "EPPO_API_KEY")
  
  response_ <- httr2::response(
    status_code = 403)
  
  is_error_fn_ <- request_$policies$error_is_error
  
  expect_true(is_error_fn_(response_))
})

test_that("The result must be an httr2_response object", {
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/taxons/taxon/BEMITA/overview",
    apiKey = "EPPO_API_KEY")
  
  response_ <- httr2::response(
    status_code = 200)
  
  with_mocked_bindings(
    req_perform = function(request) {
      return(response_)
    }, {
      expect_s3_class(
        .performRequest(
          request = request_),
        "httr2_response")
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The result must be an httr2_response object", {
  skip_on_cran()
  
  request_ <- .buildRequest(
    url = "https://api.eppo.int/gd/v2/taxons/taxon/BEMITA/overview",
    apiKey = Sys.getenv("EPPO_API_KEY"))
  
  expect_s3_class(
    .performRequest(
      request = request_),
    "httr2_response")
})
