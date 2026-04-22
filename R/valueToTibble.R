#' Convert an element to tibble.
#'
#' This helper function takes an elements and converts it into a tibble. If an
#' element is `NULL`, it is replaced with `NA`.
#'
#' @param value. The element to convert to a tibble.
#'
#' @return A tibble containing the data of the original element.
#' 
#' @importFrom tibble as_tibble
#' 
#' @keywords internal
#' @noRd
#'
.valueToTibble <- function(value) {
  
  value[sapply(value, is.null)] <- NA
  value <- as_tibble(value)
  
  return(value)
}
