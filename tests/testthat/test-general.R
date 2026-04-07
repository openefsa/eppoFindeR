test_that("The services must be specified in a vector", {
  expect_error(
    general(
      services = 123))
})

test_that("The API key must be a string", {
  expect_error(
    general(
      apiKey = 123))
})

test_that("The result must be a list", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_true(
        is.list(
          general()))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The result must be a list", {
  skip_on_cran()
  
  expect_true(
    is.list(
      general()))
})

test_that("The names in the list are equal to the specified services", {
  services_ <- c(
    "status")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_equal(
        names(
          general()),
        services_)
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The names in the list are equal to the specified services", {
  skip_on_cran()
  
  services_ <- c(
    "status")
  
  expect_equal(
    names(
      general()),
    services_)
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    general(
      services = c("badService")))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        general(
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    general(
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        general(
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    general(
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
