test_that("throws errors if numbers are used", {
  expect_error(queryTheEPPOForService(1))
})

test_that("if a code is passed a dataframe is provided", {
  expect_equal(is.data.frame(queryTheEPPOForService("BEMITA")), TRUE)
})

test_that("if a bad base url if provided than a standard 3 cols df is returned", {
  expect_equal(ncol(queryTheEPPOForService("BEMITA", baseUrl = "https://wrong.url.passed")), 3)
})

test_that("if a wrong service is requested than a standard 4 cols df is returned", {
  expect_equal(ncol(queryTheEPPOForService("BEMITA", service = "wrongservice")), 4)
})
