#' Handle non-successful HTTP responses from the EPPO API.
#' 
#' This helper function checks whether an HTTP response from the EPPO API
#' indicates success (status code 200). If the response contains any other
#' status code, it attempts to parse the JSON body for an error message and
#' raises a formatted error.
#' 
#' @param response `httr2_response`. An object returned by `req_perform()`.
#' 
#' @return Invisibly returns `NULL` if the response is successful (status code
#'   200). Otherwise, execution stops with a descriptive error message.
#' 
#' @details
#' The function is designed to simplify EPPO API error handling by centralizing
#' logic for non-200 status codes. It gracefully handles malformed or non-JSON
#' responses by returning `NULL` if parsing fails.
#' 
#' @importFrom checkmate assert_class
#' @importFrom httr2 resp_status resp_body_json
#' @importFrom cli cli_abort
#' 
#' @keywords internal
#' @noRd
#' 
.handleHTTPErrors <- function(response) {
  
  assert_class(response, "httr2_response")
  
  if (resp_status(response) != 200) {
    responseJSONBody_ <- tryCatch(
      resp_body_json(response),
      error = function(e) {
        return(NULL)
      }
    )
    
    cli_abort(c(
      "API request failed.",
      "x" = responseJSONBody_$error
    ))
  }
}
