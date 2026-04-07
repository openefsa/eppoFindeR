test_that("The base path must be a string", {
  expect_error(
    .fetchService(
      basePath = 123))
})

test_that("The base path must start with a slash", {
  expect_error(
    .fetchService(
      basePath = "taxons/taxon"))
})

test_that("The resource identifier must be a string", {
  expect_error(
    .fetchService(
      basePath = "/taxons/taxon",
      code = 123))
})

test_that("The service must be a string", {
  expect_error(
    .fetchService(
      basePath = "/taxons/taxon",
      code = "BEMITA",
      service = 123))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    .fetchService(
      basePath = "/taxons/taxon",
      code = "BEMITA",
      service = "names",
      params = 123))
})

test_that("The API key must be a string", {
  expect_error(
    .fetchService(
      basePath = "/taxons/taxon",
      apiKey = 123))
})

test_that("Expect no errors if the parameters are correct", {
  with_mocked_bindings(
    .query = function(endpoint, apiKey, params) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_no_error(
        .fetchService(
          basePath = "/taxons/taxon",
          apiKey = Sys.getenv("EPPO_API_KEY"),
          code = "BEMITA",
          service = "overview"))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no errors if the parameters are correct", {
  skip_on_cran()
  
  expect_no_error(
    .fetchService(
      basePath = "/taxons/taxon",
      apiKey = Sys.getenv("EPPO_API_KEY"),
      code = "BEMITA",
      service = "overview"))
})
