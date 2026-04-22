#' Rebuild EPPO References response data.
#'
#' This internal helper function restructures the raw output returned by the
#' EPPO References API for each queried service. Depending on the service name,
#' the function applies the appropriate post-processing function to convert the
#' API response into clean tibbles.
#'
#' @param referencesData `list`. A named list containing the raw results
#'   returned by the API for each requested service. Each list element
#'   corresponds to a service and contains the unprocessed result of
#'   `.fetchService()`.
#'
#' @return A list where each element is a cleaned and flattened tibble
#'  representing the retrieved data for the corresponding service.
#' 
#' @importFrom checkmate assert_list
#' @importFrom purrr imap
#'
#' @details
#' The purpose of this function is to harmonize the structure of the various
#' Reference endpoints, ensuring that the final output from `references()` is
#' consistently formatted and ready for use.
#'
#' @keywords internal
#' @noRd
#' 
.rebuildReferences <- function(referencesData) {
  
  assert_list(referencesData)
  
  referencesData <- imap(referencesData,
    ~ if (.y == "countriesStates") {
      .reshapeCountriesStates(countriesStatesData = .x)
    } else {
      .valueToTibble(value = .x)
    })
  
  return(referencesData)
}
