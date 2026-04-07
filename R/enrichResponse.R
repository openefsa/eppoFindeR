#' Enrich API response data.
#'
#' This helper function takes a list containing API response data and enriches
#' it with metadata, including the URL queried and the timestamp of the query.
#'
#' @param responseData `list` or `data.frame`. A structure representing the API
#'   response.
#'
#' @param url `character` (string). The URL that was queried.
#'
#' @return A list containing the original API response data, along with
#'   two additional fields: `queried_on`, the timestamp when the data was
#'   queried, and `queried_url`, the URL used for the API request.
#' 
#' @importFrom checkmate assert assert_string check_list check_data_frame
#'
#' @examplesIf FALSE
#' data_ <- list(name = "example", value = 123)
#' 
#' enrichedData_ <- .enrichResponse(
#'   responseData = data_,
#'   url = "https://example.org")
#' 
#' @keywords internal
#' @noRd
#'
.enrichResponse <- function(responseData, url) {
  
  assert(check_list(responseData), check_data_frame(responseData))
  assert_string(url)
  
  responseData$queried_on <- Sys.time()
  responseData$queried_url <- url
  
  return(responseData)
}
