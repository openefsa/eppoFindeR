#' Perform an HTTP request to the with error handling.
#' 
#' This helper function executes a prepared HTTP request and safely handles any
#' connection-level errors. If an error occurs during the request (e.g., network
#' failure, timeout, DNS issue), it aborts execution with a clear message.
#' 
#' @param request `httr2_request`. A request object created with the `httr2`
#'   package and configured with methods, headers and parameters.
#' 
#' @return The HTTP response object returned by `httr2::req_perform()` if the
#'   request is successful.
#' 
#' @importFrom checkmate assert_class
#' @importFrom httr2 req_perform
#' @importFrom cli cli_abort
#' 
#' @keywords internal
#' @noRd
#' 
.performRequest <- function(request) {
  
  assert_class(request, "httr2_request")
  
  response_ <- tryCatch(
    req_perform(request),
    error = function(e) {
      cli_abort(c(
        "HTTP request failed.",
        "x" = conditionMessage(e)
      ))
    }
  )
  
  return(response_)
}
