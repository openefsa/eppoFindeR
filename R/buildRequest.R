#' Build an HTTP GET request for the EPPO API.
#' 
#' This helper function constructs and configures an HTTP GET request object
#' using the `httr2` package. It sets the required headers, authentication key, 
#' and custom error-handling behavior based on allowed HTTP status codes.
#' 
#' @param url `character` (string). The full API endpoint URL to query.
#' 
#' @param apiKey `character` (string) The API key used for authentication, sent
#'   via the `X-Api-Key` header.
#' 
#' @param doNotFailOn `numeric` (vector, optional). The HTTP status codes that
#'   should not trigger an error.
#' 
#'   By default: only status code 200.
#' 
#' @param params `list` (optional). A named list of query parameters to include
#'   in the request.
#' 
#' @return An `httr2_request` object representing the configured API request.
#' 
#' @details
#' The function sets the HTTP method to `GET` and includes the following
#' headers:
#' \itemize{
#'  \item `X-Api-Key` - the API Key used for authentication.
#'  \item `Accept` - set to `application/json` to request JSON responses.
#' }
#' 
#' A custom error handler is set via `req_error()`, ensuring that only responses
#' with status codes *not* included in `doNotFailOn` are treated as errors.
#' 
#' @importFrom checkmate assert_string assert_vector assert_list
#' @importFrom httr2 request req_method req_headers req_error resp_status
#' req_url_query
#'
#' @examplesIf FALSE
#' url_ <- "https://api.eppo.int/gd/v2/taxon/BEMITA"
#' apiKey_ <- "YOUR_API_KEY"
#' doNotFailOn_ <- c(200, 400, 401, 403, 404, 429, 500)
#' 
#' request_ <- .buildRequest(
#'   url = url_,
#'   apiKey = apiKey_,
#'   doNotFailOn = doNotFailOn_)
#' 
#' @keywords internal
#' @noRd
#' 
.buildRequest <- function(url, apiKey, doNotFailOn = c(200), params = list()) {
  
  assert_string(url)
  assert_string(apiKey)
  assert_vector(doNotFailOn)
  assert_list(params)
  
  request_ <- request(url) |>
    req_method("GET") |>
    req_headers(
      "X-Api-Key" = apiKey,
      "Accept" = "application/json"
    ) |>
    req_url_query(!!!params) |>
    req_error(is_error = function(response_) {
      return(!(resp_status(response_) %in% doNotFailOn))
    })
  
  return(request_)
}
