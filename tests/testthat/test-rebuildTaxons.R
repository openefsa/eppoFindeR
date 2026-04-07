test_that("The data parameter must be a list", {
  expect_error(
    .rebuildTaxons(
      taxonsData = 123))
})

test_that("The result must be a list", {
  expect_true(
    is.list(
      .rebuildTaxons(
        taxonsData = list(
          "list" = list(
            data = list(x = 1:3, y = 4:6),
            queried_url = "https://example.org",
            queried_on = Sys.time())))))
})
