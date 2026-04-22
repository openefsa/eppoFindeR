#' Rebuild EPPO Taxons response data.
#'
#' This helper function processes the raw response from the EPPO Taxons services 
#' and restructures it into a format suitable for conversion into tibbles.
#' It extracts metadata and flattens the nested data structure.
#'
#' @param taxonsData `list`. The raw output from the `taxons()` function.
#'
#' @return A restructured list in which the elements has been converted into
#'   tibbles, with additional columns for `queried_on` and `queried_url` to
#'   preserve metadata from the original response.
#'
#' @importFrom checkmate assert_list
#' @importFrom dplyr mutate
#'
#' @details
#' Since only the `list` service is currently supported, this function focuses 
#' exclusively on that element. It extracts the `queried_on` and `queried_url` 
#' fields from the raw response, replaces the `data` element with the actual 
#' content, and then converts it into a tibble using `.valuesToTibbles()`.
#'
#' @keywords internal
#' @noRd
#' 
.rebuildTaxons <- function(taxonsData) {
  
  assert_list(taxonsData)
  
  queriedOn_ <- taxonsData$list$queried_on
  queriedURL_ <- taxonsData$list$queried_url
  taxonsData$list <- taxonsData$list$data
  
  taxonsData <- .valuesToTibbles(values = taxonsData)
  
  taxonsData$list <- taxonsData$list |> mutate(
    queried_on = queriedOn_,
    queried_url = queriedURL_
  )
  
  return(taxonsData)
}
