test_that("The service must be a string", {
  expect_error(
    .buildReportingServicePath(
      service = 123,
      params = list()))
})

test_that("The parameters must be specified in a list", {
  expect_error(
    .buildReportingServicePath(
      service = "article",
      params = 123))
})

test_that("The result must be a string", {
  expect_true(
    is.character(
      .buildReportingServicePath(
        service = "article",
        params = list(
          article_id = 10))))
})

test_that("The result must be correct for services with no parameters", {
  expect_equal(
    .buildReportingServicePath(
      service = "list",
      params = list()),
    "list")
})

test_that("The result must be correct for services with parameters", {
  expect_equal(
    .buildReportingServicePath(
      service = "article",
      params = list(
        article_id = 10)),
    "article/10")
})

test_that("Expect an error if required parameters are missing", {
  expect_error(
    .buildReportingServicePath(
      service = "reporting",
      params = list(
        wrong_param = 10)))
  
  expect_error(
    .buildReportingServicePath(
      service = "article",
      params = list(
        wrong_param = 10)))
})
