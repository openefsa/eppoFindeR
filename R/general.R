#' Query the EPPO API General endpoint.
#' 
#' This function queries the General endpoints of the EPPO Global Database via
#' REST API. The function sequentially queries all specified `services` and
#' returns the extracted data through a list of dataframes.
#'
#' @param services `character` (vector). One or more General services to query.
#'   Common service names include: `status`. A validation step ensures that all
#'   provided services match the supported service names.
#' 
#'   By default: all services.
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
#' @importFrom checkmate assert_vector assert_string
#' @importFrom purrr map set_names
#'
#' @examples
#' \dontrun{
#' # Get information about system health status.
#' generalData_ <- general()
#' }
#' 
#' @export
#' 
general <- function(
  services = c("status"),
  apiKey = Sys.getenv("EPPO_API_KEY")) {
  
  assert_vector(services)
  assert_string(apiKey)
  
  .checkServices(services, eval(formals()$services))
  
  generalData_ <- map(services, ~ .fetchService(
    basePath = "/",
    apiKey = apiKey,
    service = .x)) |>
    set_names(services)
  
  generalData_ <- .valuesToTibbles(values = generalData_)
  
  return(generalData_)
}
