#' Query the EPPO database via REST API by specifying the name of the required service
#' 
#' \code{queryTheEPPOForService} queries the EPPO database via REST API by specifying the name of 
#' the required service, to retrieve basic information, all names, taxonomy, categorization, 
#' hosts, pests or kingdom data about an EPPO code.
#'
#' @param queriedEppocode a single EPPO code.
#' 
#' EPPO codes are computer codes developed for plants and pests (including pathogens) which are 
#' important in agriculture and plant protection. EPPO codes constitute a harmonized coding system 
#' which aims to facilitate the management of plant and pest names in computerized databases, 
#' as well as data exchange between IT systems. EPPO codes are constructed with combinations 
#' of 5 to 6 letters and, whenever possible, codes are mnemonic abbreviations of the scientific 
#' name of the organism. Each taxon is represented by a unique code. EPPO codes can be freely 
#' downloaded and incorporated into other IT systems via a dedicated platform, 
#' the \href{https://data.eppo.int/}{EPPO Data Services}.
#' 
#' @param baseUrl URL root for all REST API.
#' 
#' By default: https://data.eppo.int/api/rest/1.0
#' 
#' @param service a single service, to be selected among the following:
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
#' By default: "categorization"
#' 
#' @param manually add your unique token, 
#' or set it inside .Renviron or using Sys.setenv(EPPO_token = "your-token").
#' 
#' By default: Sys.getenv('EPPO_token')
#'
#' @return A list of flattened dataframes is returned, each dataframe containing the contents of a 
#' request converted from JSON. Based on the query, the output dataframe will contain basic 
#' information, all names, taxonomy, categorization, hosts, pests or kingdom data about the input 
#' EPPO code. The \code{queriedEppocode}, \code{queriedOn} and \code{queriedUrl} columns in the 
#' dataframe report the input EPPO code, the date when the query was performed, 
#' and the queried URL, respectively.
#' 
#' @importFrom glue glue
#' @importFrom checkmate assert_character
#' 
#' @export
#'
#' @examples
#' # Get basic information about Bemisia tabaci:
#' queryTheEPPOForService("BEMITA", service = "")
#' 
#' # Get all names about Bemisia tabaci:
#' queryTheEPPOForService("BEMITA", service = "names")
#' 
#' # Get categorization data about Bemisia tabaci:
#' queryTheEPPOForService("BEMITA", service = "categorization")
queryTheEPPOForService <- function(  queriedEppocode
                                   , baseUrl = "https://data.eppo.int/api/rest/1.0/taxon/"
                                   , service = "categorization"
                                   , token = Sys.getenv('EPPO_token')){
  
  assert_character(queriedEppocode)
  assert_character(baseUrl)
  assert_character(service)
  assert_character(token)
  
  token <- glue("?authtoken={token}")
  
  url <- glue("{baseUrl}{queriedEppocode}/{service}{token}")
  
  if(service == ""){
    url <- glue("{baseUrl}{queriedEppocode}{service}{token}")
  }
  
  serviceQueried <- apiQuery(queriedEppocode, url)
  
  return(serviceQueried)
  
}