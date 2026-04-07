#' Reshape countries–states reference data.
#'
#' This internal utility restructures the `countriesStates` output returned by
#' the EPPO References API. The function removes metadata from the raw API
#' response, converts each country element into a tibble, adds the corresponding
#' ISO country code, and finally binds all results into a single dataframe.
#'
#' @param countriesStatesData `list`. A list resulting from a `countriesStates`
#'   API query.
#'
#' @return A single tibble combining all countries' states. The returned tibble
#'   includes a new column `country_iso` indicating the ISO code for each group
#'   of rows.
#' 
#' @importFrom checkmate assert_list
#' @importFrom dplyr mutate relocate bind_rows
#' @importFrom purrr imap
#' 
#' @examplesIf FALSE
#' # rebuildReferences.R.
#' # ...
#' if (.y == "countriesStates") {
#'   .reshapeCountriesStates(countriesStatesData = .x)
#' }
#' # ...
#'
#' @keywords internal
#' @noRd
#'
.reshapeCountriesStates <- function(countriesStatesData) {
  
  assert_list(countriesStatesData)
  
  queriedOn_ <- countriesStatesData$queried_on
  queriedURL_ <- countriesStatesData$queried_url
  
  countriesStatesData$queried_url <- NULL
  countriesStatesData$queried_on <- NULL
  
  countriesStatesData <- .valuesToTibbles(values = countriesStatesData)
  
  countriesStatesData <- imap(countriesStatesData, ~ .x |>
   mutate(country_iso = .y) |>
   relocate(country_iso, .before = 1))
  
  countriesStatesData <- bind_rows(countriesStatesData)
  
  countriesStatesData$queried_on <- queriedOn_
  countriesStatesData$queried_url <- queriedURL_
  
  return(countriesStatesData)
}
