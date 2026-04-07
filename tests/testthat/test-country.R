test_that("The ISO codes must be specified in a vector", {
  expect_error(
    country(
      isoCodes = 123))
})

test_that("The services must be specified in a vector", {
  expect_error(
    country(
      isoCodes = c("FR"),
      services = 123))
})

test_that("The API key must be a string", {
  expect_error(
    country(
      isoCodes = c("FR"),
      apiKey = 123))
})

test_that("If parameters are correct, a list is provided", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_true(
        is.list(
          country(
            isoCodes = c("FR"))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If parameters are correct, a list is provided", {
  skip_on_cran()
  
  expect_true(
    is.list(
      country(
        isoCodes = c("FR"))))
})

test_that("The names in the list are equal to the specified services", {
  services_ <- c(
    "overview",
    "categorization")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      data_ <- country(
        isoCodes = c("FR"),
        services = services_)
      
      expect_equal(
        names(data_),
        services_)
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The names in the list are equal to the specified services", {
  skip_on_cran()
  
  services_ <- c(
    "overview",
    "categorization")
  
  data_ <- country(
    isoCodes = c("FR"),
    services = services_)
  
  expect_equal(
    names(data_),
    services_)
})

test_that("If a bad ISO code is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (code == "BAD_ISO_CODE") { stop() }
    }, {
      expect_error(
        country(
          isoCodes = c("BAD_ISO_CODE")))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If a bad ISO code is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    country(
      isoCodes = c("BAD_ISO_CODE")))
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    country(
      isoCodes = c("FR"),
      services = c("badService")))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        country(
          isoCodes = c("FR"),
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    country(
      isoCodes = c("FR"),
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        country(
          isoCodes = c("FR"),
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    country(
      isoCodes = c("FR"),
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
