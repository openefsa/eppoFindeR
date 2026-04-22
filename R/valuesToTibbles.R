#' Convert list elements to tibbles.
#'
#' This helper function takes a list of elements and converts each element into
#' a tibble.
#'
#' @param values `list`. The list whose elements must be converted to tibbles.
#'
#' @return A list where each original element has been converted to a tibble.
#'
#' @importFrom checkmate assert_list
#' @importFrom purrr map
#' 
#' @keywords internal
#' @noRd
#'
.valuesToTibbles <- function(values) {
  
  assert_list(values)
  
  values <- map(values, ~ .valueToTibble(value = .x))
  
  return(values)
}
