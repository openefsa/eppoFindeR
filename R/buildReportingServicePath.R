#' Build the EPPO reporting-related service path.
#'
#' This helper function constructs the endpoint path for EPPO API reporting
#' or article services based on the service type and relevant identifiers
#' provided in the `params` list. It also handles missing or invalid parameters
#' by raising informative errors.
#' 
#' @param service `character` (string). The type of service. Supported values
#'   are `reporting` and `article`.
#' 
#' @param params `list`. A named list containing identifiers needed for the
#'   endpoint path. Must include `reporting_id` if service is "reporting" or
#'   `article_id` if service is "article".
#' 
#' @return The constructed service path to use with API calls.
#' 
#' @details
#' The function checks for the presence of the required identifiers in `params`.
#' If a required parameter is missing or invalid, an error is thrown, with a
#' message indicating the cause of the failure.
#' 
#' @importFrom checkmate assert_string assert_list
#' @importFrom glue glue
#'
#' @keywords internal
#' @noRd
#' 
.buildReportingServicePath <- function(service, params) {
  
  assert_string(service)
  assert_list(params)
  
  requiredId_ <- list(
    reporting = "reporting_id",
    article = "article_id"
  )
    
  requiredIdName_ <- requiredId_[[service]]
  
  if (!is.null(requiredIdName_)) {
    if (is.null(params[[requiredIdName_]])) {
      stop(glue("Missing parameter: `{requiredIdName_}`"))
    }
    
    service <- glue("{service}/{params[[requiredIdName_]]}")
  }
  
  return(service)
}
