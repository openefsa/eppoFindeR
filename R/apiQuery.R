#' Query the EPPO database via REST API
#' 
#' `apiQuery` queries the EPPO database via REST API to retrieve basic information, 
#' all names, taxonomy, categorization, hosts, pests or kingdom data about an EPPO code.
#' 
#' @param queriedEppocode character. A single EPPO code.
#' 
#' EPPO codes are computer codes developed for plants and pests (including pathogens) which are 
#' important in agriculture and plant protection. EPPO codes constitute a harmonized coding 
#' system which aims to facilitate the management of plant and pest names in computerized 
#' databases, as well as data exchange between IT systems. EPPO codes are constructed with 
#' combinations of 5 to 6 letters and, whenever possible, codes are mnemonic abbreviations 
#' of the scientific name of the organism. Each taxon is represented by a unique code. 
#' EPPO codes can be freely downloaded and incorporated into other IT systems via a dedicated 
#' platform, the [EPPO Data Services](https://data.eppo.int/).
#'
#' @param queriedUrl character. The URL to query.
#' 
#' The URL is of the type: 
#' https://data.eppo.int/api/rest/1.0/taxon/queriedEppocode?authtoken=xxxxxxxxxxxxxxxxxxx
#' 
#' On each of your API requests:
#' \itemize{
#' \item {Replace "queriedEppocode" with your EPPO code of interest.}
#' \item {Add your unique token.}
#' }
#' 
#' @return A single flattened dataframe is returned, containing the contents of a request 
#' converted from JSON. Based on the query, the output dataframe will contain basic information, 
#' all names, taxonomy, categorization, hosts, pests or kingdom data about the input EPPO code.
#' The `queriedEppocode`, `queriedOn` and `queriedUrl` columns in the dataframe 
#' report the input EPPO code, the date when the query was performed, and the queried URL, 
#' respectively.
#' 
#' @importFrom tidyr tibble
#' @importFrom magrittr %>%
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr bind_rows bind_cols mutate
#' @importFrom checkmate assert_string
#'
#' @examples
#' \dontrun{
#' # Get basic information about Bemisia tabaci:
#' queriedEppocode <- "BEMITA"
#' queriedUrl <- 
#' "https://data.eppo.int/api/rest/1.0/taxon/BEMITA?authtoken=xxxxxxxxxxxxxxxxxxx"
#' apiQuery(queriedEppocode, queriedUrl)
#' 
#' # Get taxonomy data about Bemisia tabaci:
#' queriedEppocode <- "BEMITA"
#' queriedUrl 
#' <- "https://data.eppo.int/api/rest/1.0/taxon/BEMITA/taxonomy?authtoken=xxxxxxxxxxxxxxxxxxx"
#' apiQuery(queriedEppocode, queriedUrl)
#' 
#' # Get all names about Aphis pomi:
#' queriedEppocode <- "APHIPO"
#' queriedUrl <- 
#' "https://data.eppo.int/api/rest/1.0/taxon/APHIPO/names?authtoken=xxxxxxxxxxxxxxxxxxx"
#' apiQuery(queriedEppocode, queriedUrl)
#' }
apiQuery <- function(queriedEppocode, queriedUrl){
  
  assert_string(queriedEppocode)
  assert_string(queriedUrl)
  
  df = tibble(empty=0)
  
  tryCatch(
    expr = {
      df_json = GET(queriedUrl) %>% 
        content(as = "text", encoding = "UTF-8") %>% 
        fromJSON(flatten = TRUE) %>% 
        bind_rows()
      if (length(df_json) == 0){
        df = bind_rows(df, df_json);stop()
      } else {
        df = bind_cols(df, df_json)
      }
    },
    error = function(e){
      print(e)
    },
    finally = {
      df = df %>% mutate(queriedEppocode = queriedEppocode
                         , queriedOn = Sys.Date()
                         , queriedUrl = queriedUrl
                         , empty = NULL)
      return(df)
    })
}
