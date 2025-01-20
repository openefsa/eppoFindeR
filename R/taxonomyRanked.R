#' Merge taxonomy and kingdom data into a single dataframe
#' 
#' `taxonomyRanked` merges taxonomy and kingdom information about the queried EPPO code 
#' into a single dataframe.
#'
#' @param taxonomy a dataframe containing taxonomy data about the queried EPPO code.
#' @param kingdom a dataframe containing kingdom data about the queried EPPO code.
#'
#' @return A dataframe containing taxonomy and kingdom information about the queried EPPO code.
#' 
#' @importFrom dplyr left_join
#' @importFrom magrittr %>%
#' @importFrom dplyr select
#' @importFrom dplyr everything
#' @importFrom dplyr rename
#' @importFrom dplyr mutate
#' @importFrom checkmate assert_data_frame
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' # Get taxonomy and kingdom data about Bemisia tabaci:
#' taxonomy <- queryTheEPPOForService("BEMITA", service = "taxonomy")
#' kingdom <- queryTheEPPOForService("BEMITA", service = "kingdom")
#' 
#' # Merge taxonomy and kingdom information about Bemisia tabaci into a single dataframe:
#' taxonomyRanked(taxonomy, kingdom)
#' }
taxonomyRanked <- function(taxonomy, kingdom){
  
  assert_data_frame(taxonomy)
  assert_data_frame(kingdom)
  
  ranks <- left_join(taxonomy, 
                               kingdom %>% 
                                 select("eppocode", "queriedEppocode", "status")
                               , by = c("eppocode", "queriedEppocode")) %>% 
    select("status", everything()) %>% 
    rename(rank = "status") %>% 
    mutate(rank = ifelse(!is.na(rank), "kingdom", NA))
  
  return(ranks)
  
}
