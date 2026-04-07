#' Build an EPPO API endpoint path.
#'
#' This helper function constructs an endpoint path for retrieving data from the
#' EPPO API. The result must be appended to the EPPO API base URL. It allows for
#' the optional inclusion of a specific code and/or service name, depending on
#' the desired API resource. The function is based on the fact that EPPO API
#' endpoints follow the pattern:
#' `{base path}/{resource identifier}/{service}`.
#'
#' @param basePath `character` (string). The base path, starting with "/" 
#'   (e.g., `"/taxons/taxon"`). Must match the pattern `"^/"`.
#' 
#' @param code `character` (string, optional). The resource identifier (e.g. an
#'   EPPO code or an ISO code). If provided, it will be appended to the base
#'   path.
#' 
#' @param service `character` (string, optional). The desired API service. If
#'   provided, it will be appended to the path after the resource identifier
#'   (if any, otherwise after the base path).
#'
#' @return A string representing the complete endpoint path to be used in an API
#'   request.
#' 
#' @importFrom checkmate assert_string
#' @importFrom glue glue
#'
#' @examplesIf FALSE
#' # Basic endpoint.
#' endpoint_ <- .buildEndpoint(basePath = "/taxons/list")
#'
#' # Endpoint with resource identifier.
#' endpoint_ <- .buildEndpoint(basePath = "/taxons/taxon", code = "BEMITA")
#'
#' # Endpoint with code and service.
#' endpoint_ <- .buildEndpoint(
#'   basePath = "/taxons/taxon",
#'   code = "BEMITA",
#'   service = "names")
#'
#' @keywords internal
#' @noRd
#' 
.buildEndpoint <- function(basePath, code = NULL, service = NULL) {

  assert_string(basePath, pattern = "^/")
  if (!is.null(code)) assert_string(code)
  if (!is.null(service)) assert_string(service)
  
  endpointParts_ <- c(basePath, code, service)
  
  endpointPath_ <- paste(endpointParts_, collapse = '/')
  endpointPath_ <- gsub("//", '/', endpointPath_)
  
  return(endpointPath_)
}
