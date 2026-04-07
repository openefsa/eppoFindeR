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
#' @examplesIf FALSE
#' # Transform a list to tibble.
#' data_ <- .valuesToTibbles(values = list(
#'  a = list(x = 1:3, y = 4:6),
#'  b = list(x = 7:9, y = 10:12)
#' ))
#' 
#' @keywords internal
#' @noRd
#'
.valuesToTibbles <- function(values) {
  
  assert_list(values)
  
  values <- map(values, ~ .valueToTibble(value = .x))
  
  return(values)
}
