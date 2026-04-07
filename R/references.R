#' Query the EPPO API References endpoints.
#' 
#' This function queries the References endpoints of the EPPO Global Database
#' via REST API. The function sequentially queries all specified `services` and
#' returns the extracted data through a list of dataframes.
#'
#' @param services `character` (vector). One or more References services to
#'   query. Common service names include: `rppos`, `qList`,
#'   `distributionStatus`, `pestHostClassification`, `vectorClassification`,
#'   `countries` and `countriesStates`. A validation step ensures that all
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
#' @examplesIf FALSE
#' # Get all information.
#' referencesData_ <- references()
#' 
#' # Get information about distribution status codes.
#' referencesData_ <- references(services = c("distributionStatus"))
#' 
#' # Get information about EPPO list codes and labels and countries.
#' referencesData_ <- references(services = c("qList", "countries"))
#' 
#' @export
#' 
references <- function(
  services = c(
    "rppos",
    "qList",
    "distributionStatus",
    "pestHostClassification",
    "vectorClassification",
    "countries",
    "countriesStates"),
  apiKey = Sys.getenv("EPPO_API_KEY")) {
  
  assert_vector(services)
  assert_string(apiKey)
  
  .checkServices(services, eval(formals()$services))
  
  referencesData_ <- map(services, ~ .fetchService(
    basePath = "/references",
    apiKey = apiKey,
    service = .x)) |>
    set_names(services)
  
  referencesData_ <- .rebuildReferences(referencesData = referencesData_)
  
  return(referencesData_)
}
