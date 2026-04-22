#' Fetch data from a specific EPPO API service.
#'
#' This function retrieves data from a specific service of the EPPO API. It
#' builds the appropriate endpoint according to the EPPO API structure, then
#' queries the API.
#'
#' @param basePath `character` (string). The base path, starting with "/" 
#'   (e.g., `"/taxons/taxon"`). Must match the pattern `"^/"`.
#' 
#' @param apiKey `character` (string) The API key used for authentication.
#' 
#' @param code `character` (string, optional). The resource identifier (e.g. an
#'   EPPO code or an ISO code). If provided, it will be appended to the base
#'   path.
#' 
#' @param service `character` (string, optional). The desired API service. If
#'   provided and not empty, it will be appended to the path after the resource
#'   identifier (if any, otherwise after the base path).
#' 
#' @param params `list` (optional). A named list of query parameters to include
#'   in the request.
#'
#' @return A structure containing the data returned by the specified EPPO API
#'   service.
#' 
#' @importFrom checkmate assert_string assert_list
#'
#' @keywords internal
#' @noRd
#' 
.fetchService <- function(
  basePath,
  apiKey,
  code = NULL,
  service = NULL,
  params = list()) {
  
  assert_string(basePath, pattern = "^/")
  assert_string(apiKey)
  if (!is.null(code)) assert_string(code)
  if (!is.null(service)) assert_string(service)
  assert_list(params)
  
  serviceEndpoint_ <- .buildEndpoint(
    basePath = basePath,
    code = code,
    service = service)
  
  serviceData_ <- .query(
    endpoint = serviceEndpoint_,
    apiKey = apiKey,
    params = params)
  
  return(serviceData_)
}
