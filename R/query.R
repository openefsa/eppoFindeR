#' Query the EPPO REST API and return the result.
#' 
#' This function performs a GET request to the EPPO REST API, automatically
#' builds the full request URL, adds the authentication header, handles
#' HTTP errors, parses the response and adds metadata about the query.
#' 
#' Specific HTTP status codes (400, 401, 403, 404, 429 and 500) are handled
#' explicitly to extract the error message returned by the API; other status
#' codes trigger a connection error.
#' 
#' @param endpoint `character` (string). The relative path of the endpoint to
#'   query, starting with a forward slash (`/`).
#' 
#' @param apiKey `character` (string) The API key used for authentication, sent
#'   via the `X-Api-Key` header.
#' 
#' @param params `list` (optional). A named list of query parameters to include
#'   in the request.
#' 
#' @return A structure containing the parsed JSON response from the API. The
#'   `queried_url` and `queried_on` fields are added to report the queried URL
#'   and the date when the query was performed, respectively.
#' 
#' @details
#' After ensuring that both `endpoint` and `apiKey`are valid strings, the
#' function orchestrates the API call through a set of modular helper functions:
#' 
#' 1. **Request construction** — `.buildRequest()` validates inputs, constructs
#' the full URL, and sets up the GET request with required headers.
#'
#' 2. **Request execution** — `.performRequest()` performs the HTTP call and
#' handles connection-level errors.
#'
#' 3. **HTTP error handling** — `.handleHTTPErrors()` checks the status code
#' and, if not `200`, parses and reports structured error messages returned by
#' the EPPO API.
#'
#' 4. **Response parsing** — `.parseResponse()` converts the successful JSON
#' body.
#' 
#' 5. **Response enriching** - `.enrichResponse()` appends query metadata to the
#' parsed response data.
#'
#' Only the following HTTP status codes are explicitly handled and reported:
#' `400`, `401`, `403`, `404`, `429` and `500`. Any other unexpected code or
#' connection issue triggers an informative error.
#' 
#' @importFrom checkmate assert_string assert_list
#' 
#' @keywords internal
#' @noRd
#' 
.query <- function(endpoint, apiKey, params = list()) {
  
  assert_string(endpoint, pattern = "^/")
  assert_string(apiKey)
  assert_list(params)
  
  baseURL_ <- "https://api.eppo.int/gd/v2"
  fullURL_ <- paste0(baseURL_, endpoint)
  
  request_ <- .buildRequest(
    url = fullURL_,
    apiKey = apiKey,
    doNotFailOn = c(200, 400, 401, 403, 404, 429, 500),
    params = params)
  
  response_ <- .performRequest(request = request_)
  
  .handleHTTPErrors(response = response_)
  
  responseData_ <- .parseResponse(response = response_)
  
  enrichedData_ <- .enrichResponse(responseData = responseData_, url = fullURL_)
  
  return(enrichedData_)
}
