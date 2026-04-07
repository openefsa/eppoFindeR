#' Merge nested lists of dataframes into tibbles.
#'
#' This function takes a named list of named lists containing data frames or
#' lists of values, converts each inner element into a tibble, adds a column
#' with the name of the parent list, and combines the inner elements across all
#' parent lists into unified tibbles for each child name.
#'
#' @param datasets `list`. A named list of named lists. Each inner list should
#'   contain dataframes or objects convertible to tibbles.
#' 
#' @param parentColumnName `character` (string). A string specifying the name of
#'   the new column that will contain the name of the parent list.
#'
#' @return A named list of tibbles. Each tibble corresponds to a unique child
#'   name across the nested lists, with an additional column containing the
#'   parent list names.
#' 
#' @importFrom checkmate assert_list assert_string
#'
#' @examplesIf FALSE
#' nestedList_ <- list(
#'   Group1 = list(a = data.frame(x = 1:2), b = data.frame(y = 3:4)),
#'   Group2 = list(a = data.frame(x = 5:6), b = data.frame(y = 7:8))
#' )
#' 
#' mergedData_ <- .mergeBatch(
#'   datasets = nestedList_,
#'   parentColumnName = "group")
#' 
#' @keywords internal
#' @noRd
#'
.mergeBatch <- function(datasets, parentColumnName) {
  
  assert_list(datasets)
  assert_string(parentColumnName)
  
  datasets <- .valuesToTibblesBatch(
    nestedValues = datasets,
    parentColumnName = parentColumnName)
  
  groupedDatasets <- .groupByServices(datasets = datasets)
  
  return(groupedDatasets)
}
