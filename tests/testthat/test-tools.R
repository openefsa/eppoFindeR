test_that("The services must be specified in a vector", {
  expect_error(
    tools(
      services = 123))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    tools(
      params = 123))
})

test_that("The API key must be a string", {
  expect_error(
    tools(
      apiKey = 123))
})

test_that("The number of parameters must be equal to the number of services", {
  expect_error(
    tools(
      services = c("name2codes"),
      params = list()))
})

test_that("The result must be a list", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_true(
        is.list(
          tools(
            params = list(
              name2codes = list(
                name = "Bemisia tabaci")))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The result must be a list", {
  skip_on_cran()
  
  expect_true(
    is.list(
      tools(
        params = list(
          name2codes = list(
            name = "Bemisia tabaci")))))
})

test_that("The names in the list are equal to the specified services", {
  services_ <- c(
    "name2codes")
  
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_equal(
        names(
          tools(
            params = list(
              name2codes = list(
                name = "Bemisia tabaci")))),
        services_)
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("The names in the list are equal to the specified services", {
  skip_on_cran()
  
  services_ <- c(
    "name2codes")
  
  expect_equal(
    names(
      tools(
        params = list(
          name2codes = list(
            name = "Bemisia tabaci")))),
    services_)
})

test_that("Expect no errors if correct parameters are specified", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      return(list(queried_on = "", queried_url = ""))
    }, {
      expect_no_error(
        tools(
          params = list(
            name2codes = list(
              onlyPreferred = FALSE,
              name = "Bemisia tabaci"))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("Expect no errors if correct parameters are specified", {
  skip_on_cran()
  
  expect_no_error(
    tools(
      params = list(
        name2codes = list(
          onlyPreferred = FALSE,
          name = "Bemisia tabaci"))))
})

test_that("If a required parameter is missing than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service, params) {
      if (!("name" %in% params$name2codes)) { stop() }
    }, {
      expect_error(
        tools(
          params = list(
            name2codes = list(
              onlyPreferred = FALSE))))
    }
  )
})

# This test requires the EPPO_API_KEY environment variable to be set.
# This test performs real requests to the EPPO API.
test_that("If a required parameter is missing than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    tools(
      params = list(
        name2codes = list(
          onlyPreferred = FALSE))))
})

test_that("If a bad service is provided than an error is thrown", {
  expect_error(
    tools(
      services = c("badService"),
      params = list()))
})

test_that("If a bad API key is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == "BAD_API_KEY") { stop() }
    }, {
      expect_error(
        tools(
          params = list(
            name2codes = list(
              onlyPreferred = FALSE,
              name = "Bemisia tabaci")),
          apiKey = "BAD_API_KEY"))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad API key is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    tools(
      params = list(
        name2codes = list(
          onlyPreferred = FALSE,
          name = "Bemisia tabaci")),
      apiKey = "BAD_API_KEY"))
})

test_that("If a bad environment variable is provided than an error is thrown", {
  with_mocked_bindings(
    .fetchService = function(basePath, apiKey, code, service) {
      if (apiKey == '') { stop() }
    }, {
      expect_error(
        tools(
          params = list(
            name2codes = list(
              onlyPreferred = FALSE,
              name = "Bemisia tabaci")),
          apiKey = Sys.getenv("BAD_ENV_VAR")))
    }
  )
})

# This test performs real requests to the EPPO API.
test_that("If a bad environment variable is provided than an error is thrown", {
  skip_on_cran()
  
  expect_error(
    tools(
      params = list(
        name2codes = list(
          onlyPreferred = FALSE,
          name = "Bemisia tabaci")),
      apiKey = Sys.getenv("BAD_ENV_VAR")))
})
