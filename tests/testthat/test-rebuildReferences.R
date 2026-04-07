test_that("The data parameter must be a list", {
  expect_error(
    .rebuildReferences(
      referencesData = 123))
})
