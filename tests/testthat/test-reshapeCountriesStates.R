test_that("The data parameter must be a string", {
  expect_error(
    .reshapeCountriesStates(
      countriesStatesData = 123))
})
