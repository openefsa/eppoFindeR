#' Parse a JSON API response.
#' 
#' This helper function parses the JSON body of an API response.
#' 
#' @param response `httr2_response`. An HTTP response object returned by
#'   `httr2::req_perform()`.
#' 
#' @return A data structure containing the parsed JSON response.
#' 
#' @details
#' If the API response body cannot be parsed as valid JSON, the function raises
#' an error, including the original parsing error message.
#' 
#' @importFrom checkmate assert_class
#' @importFrom jsonlite fromJSON
#' @importFrom httr2 resp_body_string
#' @importFrom cli cli_abort
#'
#' @examplesIf FALSE
#' response_ <- req_perform(request("https://example.org/"))
#' 
#' responseData_ <- .parseResponse(response = response_)
#' 
#' @keywords internal
#' @noRd
#' 
.parseResponse <- function(response) {
  
  assert_class(response, "httr2_response")
  
  responseData_ <- tryCatch(
    fromJSON(resp_body_string(response), flatten = TRUE),
    error = function(e) {
      cli_abort(c(
        "Failed to parse API response.",
        "x" = conditionMessage(e)
      ))
    }
  )
  
  return(responseData_)
}
