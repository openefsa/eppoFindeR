#' Validate service names against a set of allowed choices.
#'
#' This function checks whether all elements in `services` are included in the
#' allowed `choices`. If any unsupported services are found, the function aborts
#' with an informative error message.
#'
#' @param services `character` (vector). A vector of service names to validate.
#' 
#' @param choices `character` (vector). A vector containing the allowed service
#'   names.
#'
#' @return Invisibly returns `NULL` if all services are valid. Otherwise it
#'   stops with an error.
#' 
#' @importFrom cli cli_abort
#'
#' @examplesIf FALSE
#' .checkServices(c("a", "b"), c("a", "b", "c")) # Valid.
#' .checkServices(c("a", "x"), c("a", "b", "c")) # Error.
#'
#' @keywords internal
#' @noRd
#' 
.checkServices <- function(services, choices) {
  
  assert_vector(services)
  assert_vector(choices)
  
  invalidServices_ <- setdiff(services, choices)
  
  if (length(invalidServices_) > 0) {
    cli_abort(c(
      "Unsupported services requested.",
      "x" = paste(shQuote(invalidServices_), collapse = ", ")
    ))
  }
}
