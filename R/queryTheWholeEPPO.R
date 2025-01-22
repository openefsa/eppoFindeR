#' Query all services, a single service or multiple services in the EPPO database via REST API
#'
#' `queryTheWholeEPPO` queries the EPPO database via REST API by specifying the name(s) 
#' of the required service(s), to retrieve basic information, all names, taxonomy, categorization, 
#' hosts, pests and kingdom data about an EPPO code.
#'
#' @param queriedEppocode character. A single EPPO code.
#' 
#' EPPO codes are computer codes developed for plants and pests (including pathogens) which are 
#' important in agriculture and plant protection. EPPO codes constitute a harmonized coding system 
#' which aims to facilitate the management of plant and pest names in computerized databases, 
#' as well as data exchange between IT systems. EPPO codes are constructed with combinations 
#' of 5 to 6 letters and, whenever possible, codes are mnemonic abbreviations of the scientific 
#' name of the organism. Each taxon is represented by a unique code. EPPO codes can be freely 
#' downloaded and incorporated into other IT systems via a dedicated platform, 
#' the [EPPO Data Services](https://data.eppo.int/).
#' 
#' @param baseUrl character. URL root for all REST API.
#' 
#' By default: https://data.eppo.int/api/rest/1.0
#' 
#' @param token character. Manually add your unique token,
#' or set it inside .Renviron or using Sys.setenv(EPPO_token = "your-token").
#' 
#' By default: Sys.getenv('EPPO_token')
#'
#' \itemize{
#'   \item {"": basic information}
#'   \item {"names": all names}
#'   \item {"taxonomy": taxonomy data}
#'   \item {"categorization": categorization data}
#'   \item {"hosts": hosts data}
#'   \item {"pests": pests data}
#'   \item {"kingdom": kingdom taxonomic rank}
#' }
#' 
#' By default: "all", which means the whole EPPO database for taxonomy 
#' (https://data.eppo.int/api/rest/1.0/taxon) is screened.
#' 
#' @return A list of flattened dataframes is returned, each dataframe containing the contents 
#' of a request converted from JSON. Based on the query, the output dataframe will contain basic 
#' information, all names, taxonomy, categorization, hosts, pests or kingdom data about the input 
#' EPPO code. The `queriedEppocode`, `queriedOn` and `queriedUrl` columns 
#' in the dataframe report the input EPPO code, the date when the query was performed, 
#' and the queried URL, respectively.
#' 
#' @importFrom checkmate assert_string
#' @export
#'
#' @examples
#' # Get all information about Bemisia tabaci: basic information, all names, taxonomy, 
#' # categorization, hosts, pests and kingdom data.
#' queryTheWholeEPPO("BEMITA")
queryTheWholeEPPO <- function(  queriedEppocode
                              , baseUrl = "https://data.eppo.int/api/rest/1.0/taxon/"
                              , token = Sys.getenv('EPPO_token')){
  
  
  assert_string(queriedEppocode)
  assert_string(baseUrl)
  assert_string(token)
  
  services <- 
    c(""
      , "names"
      , "taxonomy"
      , "categorization"
      , "hosts"
      , "pests"
      , "kingdom"
    )
  
  EPPOList <- list()
  item <- 1
  for(service in services){
    EPPOList[[item]] <- queryTheEPPOForService(queriedEppocode = queriedEppocode
                                               , baseUrl = baseUrl
                                               , service = service
                                               , token = token)
    names(EPPOList)[[item]] <- service
    if (service == ""){
      names(EPPOList)[[item]] = "general"
    }
    item <- item + 1
  }
  
  return(EPPOList)
}
