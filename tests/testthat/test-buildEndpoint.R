test_that("The base path must be a string", {
  expect_error(
    .buildEndpoint(
      basePath = 123))
})

test_that("The base path must start with a slash", {
  expect_error(
    .buildEndpoint(
      basePath = "taxons/taxon"))
})

test_that("The resource identifier must be a string", {
  expect_error(
    .buildEndpoint(
      basePath = "/taxons/taxon",
      code = 123))
})

test_that("The service must be a string", {
  expect_error(
    .buildEndpoint(
      basePath = "/taxons/taxon",
      code = "BEMITA",
      service = 123))
})

test_that("If only the base path is given, the result must be the base path", {
  expect_equal(
    .buildEndpoint(
      basePath = "/taxons/taxon"),
    "/taxons/taxon")
})

test_that("If a resource identifier is given, the result must include it", {
  expect_equal(
    .buildEndpoint(
      basePath = "/taxons/taxon",
      code = "BEMITA"),
    "/taxons/taxon/BEMITA")
})

test_that("If a service is given, the result must include it", {
  expect_equal(
    .buildEndpoint(
      basePath = "/country",
      code = "FR",
      service = "overview"),
    "/country/FR/overview")
})

test_that("If no resource identifier is specified, it must be avoided", {
  expect_equal(
    .buildEndpoint(
      basePath = "/reportings",
      service = "list"),
    "/reportings/list")
})
