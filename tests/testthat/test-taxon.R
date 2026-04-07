test_that("The EPPO codes must be specified in a vector", {
  expect_error(
    taxon(
      eppoCodes = 123))
})

test_that("The services must be specified in a vector", {
  expect_error(
    taxon(
      eppoCodes = c("BEMITA"),
      services = 123))
})

test_that("The API key must be a string", {
  expect_error(
    taxon(
      eppoCodes = c("BEMITA"),
      apiKey = 123))
})

test_that("If parameters are correct, a list is provided", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_true(
        is.list(
          taxon(
            eppoCodes = c("BEMITA"))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If parameters are correct, a list is provided", {
  skip_on_cran()
  
  expect_true(
    is.list(
      taxon(
        eppoCodes = c("BEMITA"))))
})

test_that("The names of the dataframes are equal to the specified services", {
  services_ <- c(
    "names",
    "taxonomy",
    "categorization",
    "hosts",
    "pests")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      data_ <- taxon(
        eppoCodes = c("BEMITA"),
        services = services_)
      
      expect_equal(
        names(
          data_),
        services_)
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The names of the dataframes are equal to the specified services", {
  skip_on_cran()
  
  services_ <- c(
    "names",
    "taxonomy",
    "categorization",
    "hosts",
    "pests")
  
  data_ <- taxon(
    eppoCodes = c("BEMITA"),
    services = services_)
  
  expect_equal(
    names(
      data_),
    services_)
})

test_that("If a bad EPPO code is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (code == "BAD_EPPO_CODE") { stop() }
    }, {
      expect_error(
        taxon(
          eppoCodes = c("BAD_EPPO_CODE")))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If a bad EPPO code is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    taxon(
      eppoCodes = c("BAD_EPPO_CODE")))
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    taxon(
      eppoCodes = c("BEMITA"),
      services = c("badService")))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        taxon(
          eppoCodes = c("BEMITA"),
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    taxon(
      eppoCodes = c("BEMITA"),
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        taxon(
          eppoCodes = c("BEMITA"),
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    taxon(
      eppoCodes = c("BEMITA"),
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
