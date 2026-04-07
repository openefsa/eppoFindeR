test_that("The services must be specified in a vector", {
  expect_error(
    reportingService(
      services = 123))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    reportingService(
      params = 123))
})

test_that("The API key must be a string", {
  expect_error(
    reportingService(
      apiKey = 123))
})

test_that("The number of parameters must be equal to the number of services", {
  expect_error(
    reportingService(
      services = c("list", "article"),
      params = list()))
})

test_that("The result must be a list", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_true(
        is.list(
          reportingService(
            services = c("list"),
            params = list("list" = list()))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The result must be a list", {
  skip_on_cran()
  
  expect_true(
    is.list(
      reportingService(
        services = c("list"),
        params = list("list" = list()))))
})

test_that("The names in the list are equal to the specified services", {
  services_ <- c(
    "list")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_equal(
        names(
          reportingService(
            services = services_,
            params = list("list" = list()))),
        services_)
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The names in the list are equal to the specified services", {
  skip_on_cran()
  
  services_ <- c(
    "list")
  
  expect_equal(
    names(
      reportingService(
        services = services_,
        params = list("list" = list()))),
    services_)
})

test_that("Expect no errors if correct parameters are specified", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_no_error(
        reportingService(
          services = c("reporting"),
          params = list(
            "reporting" = list(
              reporting_id = 10))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no errors if correct parameters are specified", {
  skip_on_cran()
  
  expect_no_error(
    reportingService(
      services = c("reporting"),
      params = list(
        "reporting" = list(
          reporting_id = 10))))
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    reportingService(
      services = c("badService"),
      params = list("badService" = list())))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        reportingService(
          services = c("list"),
          params = list("list" = list()),
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    reportingService(
      services = c("list"),
      params = list("list" = list()),
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        reportingService(
          services = c("list"),
          params = list("list" = list()),
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    reportingService(
      services = c("list"),
      params = list("list" = list()),
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
