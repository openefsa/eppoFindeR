#' Query the EPPO API RPPO endpoints.
#' 
#' This function queries the RPPO endpoints of the EPPO Global Database via
#' REST API for one or more RPPO code(s) and one or more service(s). For each
#' RPPO code in `rppoCodes`, the function sequentially queries all specified
#' `services` and returns the extracted data through a list of dataframes.
#' 
#' @param rppoCodes `character` (vector). One or more RPPO codes to query.
#'   Available RPPO codes can be retrieved via the `references/rppos` service.
#'
#' @param services `character` (vector). One or more RPPO services to query.
#'   Common service names include: `overview` and `categorization`. A
#'   validation step ensures that all provided services match the supported
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
#'   flattened dataframe with the queried content for all the specified RPPO
#'   codes.
#' 
#' @importFrom checkmate assert_vector assert_string
#' @importFrom purrr map set_names
#'
#' @examples
#' \dontrun{
#' # Get all information about the European and Mediterranean Plant Protection
#' # Organisation.
#' rppoData_ <- rppo(rppoCodes = c("9A"))
#' 
#' # Get categorization data about the European and Mediterranean Plant
#' # Protection Organisation.
#' rppoData_ <- rppo(rppoCodes = c("9A"), services = c("categorization"))
#' 
#' # Get basic data about European and Mediterranean Plant Protection
#' # Organisation and the European Union.
#' rppoData_ <- rppo(rppoCodes = c("9A", "9L"), services = c("overview"))
#' }
#' 
#' @export
#' 
rppo <- function(
  rppoCodes,
  services = c(
    "overview",
    "categorization"),
  apiKey = Sys.getenv("EPPO_API_KEY")) {
  
  assert_vector(rppoCodes)
  assert_vector(services)
  assert_string(apiKey)
  
  .checkServices(services, eval(formals()$services))
  
  rppoData_ <- map(rppoCodes, ~ {
    rppoCode_ <- .x
    
    map(services, ~ .fetchService(
      basePath = "/rppo",
      apiKey = apiKey,
      code = rppoCode_,
      service = .x)) |>
      set_names(services)}) |>
    
    set_names(rppoCodes)
  
  rppoData_ <- .mergeBatch(
    datasets = rppoData_,
    parentColumnName = "queried_rppo_code")
  
  return(rppoData_)
}
