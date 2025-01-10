#' Create a dump of the whole EPPO database via REST API
#' 
#' `dataDump` creates a dump of the whole EPPO database via REST API for one or more 
#' EPPO code(s).
#'
#' @param codesToScan a character vector of one or more EPPO code(s).
#' 
#' @param token character. Manually add your unique token, 
#' or set it inside .Renviron or using Sys.setenv(EPPO_token = "your-token").
#'
#' @return A list of flattened dataframes is returned, each dataframe containing the contents 
#' of a request converted from JSON. Each output dataframe will contain basic information, 
#' all names, taxonomy, categorization, hosts, pests and kingdom data about the input 
#' EPPO code(s), respectively. The `queriedEppocode`, `queriedOn` and `queriedUrl` 
#' columns in the dataframe report the input EPPO code(s), the date when the query was performed, 
#' and the queried URL, respectively.
#' 
#' @importFrom magrittr %>%
#' @importFrom purrr map
#' @importFrom purrr set_names
#' @importFrom dplyr bind_rows
#' @importFrom checkmate assert_vector
#' 
#' @export
#'
#' @examples
#' # Create a dump of all data about Bemisia tabaci: basic information, all names, taxonomy, 
#' # categorization, hosts, pests and kingdom data.
#' dataDump("BEMITA")
#' 
#' # Create a dump of all data about Aphis pomi and Leucoptera malifoliella: basic information, 
#' # all names, taxonomy, categorization, hosts, pests and kingdom data.
#' dataDump(c("APHIPO", "LEUCSC"))
dataDump <- function(codesToScan, token = Sys.getenv('EPPO_token'))  {
  
  assert_vector(codesToScan)
  assert_string(token)

  dump <-
    codesToScan %>% 
    map(~ queryTheWholeEPPO(.x, token = token)) %>% 
    set_names(codesToScan)
  
  # Separate data by entity/service -----------------------------------------
  
  general <- dump %>% map("general") %>% bind_rows(.id="pestCode")
  names <- dump %>% map("names") %>% bind_rows(.id="pestCode")
  taxonomy <- dump %>% map("taxonomy") %>% bind_rows(.id="pestCode")
  categorization <- dump %>% map("categorization") %>% bind_rows(.id="pestCode")
  hosts <- dump %>% map("hosts") %>% bind_rows(.id="pestCode")
  pests <- dump %>% map("pests") %>% bind_rows(.id="pestCode")
  kingdom <- dump %>% map("kingdom") %>% bind_rows(.id="pestCode")
  
  # Create the dump file --------------------------------------------------
  
  dump <- list( "general" = general
                  , "names" = names
                  , "taxonomy" = taxonomy
                  , "categorization" = categorization
                  , "hosts" = hosts
                  , "pests" = pests
                  , "kingdom" = kingdom
  ) 
  
  return(dump)
  
}
