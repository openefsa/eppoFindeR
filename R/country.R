#' Query the EPPO API Country endpoints.
#' 
#' This function queries the Country endpoints of the EPPO Global Database via
#' REST API for one or more ISO code(s) and one or more service(s). For each
#' ISO code in `isoCodes`, the function sequentially queries all specified
#' `services` and returns the extracted data through a list of dataframes.
#' 
#' @param isoCodes `character` (vector). One or more ISO codes to query.
#' 
#'   ISO country codes are standardized identifiers for countries and
#'   territories. These codes, typically consisting of two-letter, provide
#'   unique and consistent abbreviations of country names. The ISO coding system
#'   enables easy management, exchange, and integration of country information
#'   across databases and IT systems. ISO country codes and their related data
#'   can be accessed via the
#'   [ISO Online Browsing Platform](https://www.iso.org/obp/ui/#search).
#'
#' @param services `character` (vector). One or more Country services to query.
#'   Common service names include: `overview`, `categorization` and `presence`.
#'   A validation step ensures that all provided services match the supported
#'   service names.
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
#'   flattened dataframe with the queried content for all the specified ISO
#'   codes.
#' 
#' @importFrom checkmate assert_vector assert_string
#' @importFrom purrr map set_names
#'
#' @examplesIf FALSE
#' # Get all information about France.
#' countryData_ <- country(isoCodes = c("FR"))
#' 
#' # Get categorization data about France.
#' countryData_ <- country(isoCodes = c("FR"), services = c("categorization"))
#' 
#' # Get basic data about France and Italy.
#' countryData_ <- country(isoCodes = c("FR", "IT"), services = c("overview"))
#' 
#' @export
#' 
country <- function(
  isoCodes,
  services = c(
    "overview",
    "categorization",
    "presence"),
  apiKey = Sys.getenv("EPPO_API_KEY")) {
  
  assert_vector(isoCodes)
  assert_vector(services)
  assert_string(apiKey)
  
  .checkServices(services, eval(formals()$services))
  
  countryData_ <- map(isoCodes, ~ {
    isoCode_ <- .x
    
    map(services, ~ .fetchService(
      basePath = "/country",
      apiKey = apiKey,
      code = isoCode_,
      service = .x)) |>
      set_names(services)}) |>
    
    set_names(isoCodes)
  
  countryData_ <- .mergeBatch(
    datasets = countryData_,
    parentColumnName = "queried_iso_code")
  
  return(countryData_)
}
