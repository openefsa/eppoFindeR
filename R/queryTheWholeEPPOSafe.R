#' Query all services, a single service or multiple services in the EPPO database via REST API 
#' (version that never fails)
#'
#' `queryTheWholeEPPOSafe` queries the EPPO database via REST API by specifying the name(s) 
#' of the required service(s), to retrieve basic information, all names, taxonomy, categorization, 
#' hosts, pests and kingdom data about an EPPO code. `queryTheWholeEPPOSafe` is a modified 
#' version of `queryTheWholeEPPO` that never fails.
#'
#' @param ... a function that takes the same arguments as .f. By default, .f = queryTheWholeEPPO.
#' 
#' The safely(.f) function from purrr/tidyverse package in R wraps a function to capture errors 
#' and side effects, i.e. creates a modified version of .f that never fails.
#' 
#' @return A function that takes the same arguments as .f, but returns a different value: a list 
#' with components result and error. If the function succeeds, result contains the returned value 
#' and error is NULL. If an error occurred, error is an error object and result is either NULL 
#' or otherwise. If the function succeeds, result contains a list of flattened dataframes, each 
#' dataframe containing the contents of a request converted from JSON. Based on the query, the 
#' output dataframe will contain basic information, all names, taxonomy, categorization, hosts, 
#' pests or kingdom data about the input EPPO code. The `queriedEppocode`, `queriedOn` 
#' and `queriedUrl` columns in the dataframe report the input EPPO code, the date when the 
#' query was performed, and the queried URL, respectively.
#' 
#' @importFrom purrr safely
#' 
#' @export
#'
#' @examples
#' # Get all information about Bemisia tabaci: basic information, all names, taxonomy, 
#' # categorization, hosts pests, and kingdom data.
#' queryTheWholeEPPOSafe("BEMITA")
queryTheWholeEPPOSafe <- safely(.f = queryTheWholeEPPO)
