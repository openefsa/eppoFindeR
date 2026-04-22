#' Combine nested lists by child name
#'
#' This function takes a named list of tibbles and combines the inner elements
#' across all parent lists based on their child names. Each resulting tibble
#' corresponds to a unique child name and contains all rows from the nested
#' lists.
#'
#' @param datasets `list`. A named list of lists, where each inner list contains
#'   tibbles or data frames.
#'
#' @return A named list of tibbles. Each tibble contains all combined rows from
#'   the parent lists.
#' 
#' @details
#' The function also ensures that the `queried_url` and `queried_on`
#' columns are always placed after the others.
#' 
#' @importFrom purrr map imap
#' @importFrom checkmate assert_list
#' @importFrom dplyr bind_rows relocate
#' 
#' @keywords internal
#' @noRd
#'
.groupByServices <- function(datasets) {
  
  assert_list(datasets)
  
  serviceNames_ <- unique(unlist(map(datasets, names)))
  
  datasets <- map(serviceNames_, function(serviceName_) {
    bind_rows(map(datasets, ~ .x[[serviceName_]]))
  })
  
  names(datasets) <- serviceNames_
  
  datasets <- imap(datasets, ~ .x |>
   relocate(queried_on, .after = last_col()) |>
   relocate(queried_url, .after = last_col()))
  
  return(datasets)
}
