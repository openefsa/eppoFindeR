test_that("The RPPO codes must be specified in a vector", {
  expect_error(
    rppo(
      rppoCodes = 123))
})

test_that("The services must be specified in a vector", {
  expect_error(
    rppo(
      rppoCodes = c("9A"),
      services = 123))
})

test_that("The API key must be a string", {
  expect_error(
    rppo(
      rppoCodes = c("9A"),
      apiKey = 123))
})

test_that("If parameters are correct, a list is provided", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_true(
        is.list(
          rppo(
            rppoCodes = c("9A"))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If parameters are correct, a list is provided", {
  skip_on_cran()
  
  expect_true(
    is.list(
      rppo(
        rppoCodes = c("9A"))))
})

test_that("The names in the list are equal to the specified services", {
  services_ <- c(
    "overview",
    "categorization")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      data_ <- rppo(
        rppoCodes = c("9A"),
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
  
  data_ <- rppo(
    rppoCodes = c("9A"),
    services = services_)
  
  expect_equal(
    names(data_),
    services_)
})

test_that("If a bad RPPO code is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (code == "BAD_RPPO_CODE") { stop() }
    }, {
      expect_error(
        rppo(
          rppoCodes = c("BAD_RPPO_CODE")))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If a bad RPPO code is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    rppo(
      rppoCodes = c("BAD_RPPO_CODE")))
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    rppo(
      rppoCodes = c("9A"),
      services = c("badService")))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        rppo(
          rppoCodes = c("9A"),
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    rppo(
      rppoCodes = c("9A"),
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        rppo(
          rppoCodes = c("9A"),
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    rppo(
      rppoCodes = c("9A"),
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
