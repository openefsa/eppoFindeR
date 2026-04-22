#' Convert nested lists to tibbles and add parent column.
#'
#' This function takes a named list of lists containing dataframes or objects
#' convertible to tibbles, converts each inner element to a tibble, and adds a
#' column containing the name of the parent list.
#'
#' @param nestedValues `list`. A named list of named lists. Each inner list
#'   should contain dataframes or objects convertible to tibbles.
#' 
#' @param parentColumnName `character` (string). A string specifying the name of
#'   the new column that will contain the name of the parent list.
#' 
#' @return A named list of lists of tibbles, with each tibble including an
#'   additional column that indicates the name of its parent list.
#' 
#' @importFrom checkmate assert_list assert_string
#' @importFrom dplyr mutate relocate
#' @importFrom purrr imap map
#' 
#' @keywords internal
#' @noRd
#'
.valuesToTibblesBatch <- function(nestedValues, parentColumnName) {
  
  assert_list(nestedValues)
  assert_string(parentColumnName)
  
  values_ <- imap(nestedValues, ~ {
    x_ <- .valuesToTibbles(values = .x)
    y_ <- .y
    
    map(x_, ~ .x |>
     mutate(!!parentColumnName := y_) |>
     relocate(!!parentColumnName, .before = 1))
  })
  
  return(values_)
}
