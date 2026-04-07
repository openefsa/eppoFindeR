test_that("The services must be specified in a vector", {
  expect_error(
    taxons(
      services = 123))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    taxons(
      params = 123))
})

test_that("The API key must be a string", {
  expect_error(
    taxons(
      apiKey = 123))
})

test_that("The number of parameters must be equal to the number of services", {
  expect_error(
    taxons(
      services = c("list"),
      params = list()))
})

test_that("The result must be a list", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      return(list(queried_on = "", queried_url = "", data = tibble(1)))
    }, {
      expect_true(
        is.list(
          taxons()))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The result must be a list", {
  skip_on_cran()
  
  expect_true(
    is.list(
      taxons()))
})

test_that("The names in the list are equal to the specified services", {
  services_ <- c(
    "list")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      return(list(queried_on = "", queried_url = "", data = tibble(1)))
    }, {
      expect_equal(
        names(
          taxons()),
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
      taxons()),
    services_)
})

test_that("Expect no errors if correct parameters are specified", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      return(list(queried_on = "", queried_url = "", data = tibble(1)))
    }, {
      expect_no_error(
        taxons(
          params = list(
            "list" = list(
              createdFromDate = "2000-01-01",
              limit = 5,
              offset = 10,
              orderAsc = FALSE,
              orderBy = "eppocode"))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no errors if correct parameters are specified", {
  skip_on_cran()
  
  expect_no_error(
    taxons(
      params = list(
        "list" = list(
          createdFromDate = "2000-01-01",
          limit = 5,
          offset = 10,
          orderAsc = FALSE,
          orderBy = "eppocode"))))
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    taxons(
      services = c("badService")))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        taxons(
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    taxons(
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        taxons(
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    taxons(
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
