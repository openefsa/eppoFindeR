test_that("The endpoint must be a string", {
  expect_error(
    .query(
      endpoint = 123,
      apiKey = "EPPO_API_KEY",
      params = list()))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    .query(
      endpoint = "/taxons/taxon/BEMITA/overview",
      apiKey = "EPPO_API_KEY",
      params = 123))
})

test_that("The API key must be a string", {
  expect_error(
    .query(
      endpoint = "/taxons/taxon/BEMITA/overview",
      apiKey = 123))
})

test_that("The endpoint must start with a slash", {
  expect_error(
    .query(
      endpoint = "taxons/taxon/BEMITA/overview",
      apiKey = Sys.getenv("EPPO_API_KEY")))
})

test_that("Expect no errors if the parameters are correct", {
  response_ <- httr2::response(
    status_code = 200,
    url = "https://api.eppo.int/gd/v2/taxons/taxon/BEMITA/names",
    method = "GET",
    headers = list("Content-Type" = "application/json"),
    body = charToRaw("{\"a\": 1}"))
  
  with_mocked_bindings(
    .performRequest = function(request) {
      return(response_)
    }, {
      expect_no_error(
        .query(
          endpoint = "/taxons/taxon/BEMITA/names",
          apiKey = "EPPO_API_KEY"))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no errors if the parameters are correct", {
  skip_on_cran()
  
  expect_no_error(
    .query(
      endpoint = "/taxons/taxon/BEMITA/names",
      apiKey = Sys.getenv("EPPO_API_KEY")))
})

test_that("Expect an error if a bad endpoint is specified", {
  with_mocked_bindings(
    .performRequest = function(request) {
      if (request$url == "https://api.eppo.int/gd/v2/badService") { stop() }
    }, {
      expect_error(
        .query(
          endpoint = "/badService",
          apiKey = "EPPO_API_KEY"))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect an error if a bad endpoint is specified", {
  skip_on_cran()
  
  expect_error(
    .query(
      endpoint = "/taxons/taxon/BEMITA/badService",
      apiKey = Sys.getenv("EPPO_API_KEY")))
})

test_that("Expect an error if a bad API key is specified", {
  with_mocked_bindings(
    .performRequest = function(request) {
      if (request$headers$"X-Api-Key" == '') { stop() }
    }, {
      expect_error(
        .query(
          endpoint = "/taxons/taxon/BEMITA/overview",
          apiKey = Sys.getenv("BAD_API_KEY")))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect an error if a bad API key is specified", {
  skip_on_cran()
  
  expect_error(
    .query(
      endpoint = "/taxons/taxon/BEMITA/overview",
      apiKey = Sys.getenv("BAD_API_KEY")))
})
