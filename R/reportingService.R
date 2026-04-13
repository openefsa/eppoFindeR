#' Query the EPPO API Taxons endpoints.
#' 
#' This function queries the Taxons endpoints of the EPPO Global Database via
#' REST API. The function sequentially queries all specified `services` and
#' returns the extracted data through a list of dataframes.
#'
#' @param services `character` (vector). One or more Taxons services to query.
#'   Common service names include: `list`, `reporting` and `article`. A
#'   validation step ensures that all provided services match the supported
#'   service names.
#' 
#'   By default: all services.
#' 
#' @param params `list`. A named list of query parameters to include in the
#'   request. The list of available parameters can be accessed via the
#'   [EPPO API Documentation](https://data.eppo.int/ui/#/docs/GDAPI)
#'   platform.
#' 
#'   By default: no parameters, you need to specify the required ones.
#'
#' @param apiKey `character` (string). The API key used for authentication. It
#'   can be specified manually or through the .Renviron file.
#' 
#'   By default: Sys.getenv("EPPO_API_KEY").
#'
#' @return A named list of results, in which each level corresponds to the data
#'   retrieved for each specified service. Each service element contains a
#'   flattened dataframe with the queried content.
#' 
#' @importFrom checkmate assert_vector assert_list assert_string assert
#' @importFrom purrr map2 set_names
#'
#' @examplesIf FALSE
#' # Get the list of reporting service issues.
#' reportingServiceData_ <- reportingService(
#'   services = c("list"),
#'   params = list(
#'     "list" = list()))
#'
#' # Get a specific reporting service issue by ID.
#' reportingServiceData_ <- reportingService(
#'   services = c("reporting"),
#'   params = list(
#'     reporting = list(
#'       reporting_id = 10)))
#'
#' # Get a specific article by ID.
#' reportingServiceData_ <- reportingService(
#'   services = c("article"),
#'   params = list(
#'     article = list(
#'       article_id = 234)))
#'
#' # Get a specific reporting service issue and a specific article by ID.
#' reportingServiceData_ <- reportingService(
#'   services = c("reporting", "article"),
#'   params = list(
#'     reporting = list(
#'       reporting_id = 10
#'     ),
#'     article = list(
#'       article_id = 234
#'     )
#'   )
#' )
#' 
#' @export
#' 
reportingService <- function(
  services = c(
    "list",
    "reporting",
    "article"),
  params = list(
    "list" = list(),
    "reporting" = list(),
    "article" = list()),
  apiKey = Sys.getenv("EPPO_API_KEY")) {
  
  assert_vector(services)
  assert_list(params)
  assert_string(apiKey)
  assert(length(services) == length(params))
  
  .checkServices(services, eval(formals()$services))
  
  reportingServiceData_ <- map2(services, params[services], ~ .fetchService(
    basePath = "/reportings",
    apiKey = apiKey,
    service = .buildReportingServicePath(
      service = .x,
      params = .y))) |>
    set_names(services)
  
  reportingServiceData_ <- .valuesToTibbles(values = reportingServiceData_)
  
  return(reportingServiceData_)
}
