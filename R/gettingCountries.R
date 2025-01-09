#' Get member countries from the acronyms of all Regional Plant Protection Organizations used 
#' in the EPPO database
#'
#' \code{gettingCountries} returns the list of member countries for each Regional Plant Protection 
#' Organization acronym which is used in the EPPO database (source: https://gd.eppo.int/rppo/).
#'
#' @param acronym the acronym of the Regional Plant Protection Organization.
#' 
#' @importFrom checkmate assert_character
#'
#' @return A character vector containing all the member countries.
#' @export
#'
#' @examples
#' # Get the list of member countries for the 'EAEU' acronym:
#' gettingCountries('EAEU')
#' 
#' # Get the list of member countries for the 'EPPO' acronym:
#' gettingCountries('EPPO')
#' 
#' # Get the list of member countries for the 'COSAVE' acronym:
#' gettingCountries('COSAVE')


gettingCountries <- function(acronym){
  
  assert_character(acronym)
  
  countries <- NA
  
  if (acronym=='EPPO'){
    countries = paste(c('Albania', 'Algeria', 'Austria', 'Azerbaijan', 'Belarus', 'Belgium', 'Bosnia and Herzegovina', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Georgia', 'Germany', 'Greece', 'Guernsey', 'Hungary', 'Ireland', 'Israel', 'Italy', 'Jersey', 'Jordan', 'Kazakhstan', 'Kyrgyzstan', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Moldova', 'Montenegro', 'Morocco', 'Netherlands', 'North Macedonia', 'Norway', 'Poland', 'Portugal', 'Romania', 'Russia', 'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden', 'Switzerland', 'Tunisia', 'T\u00FCrkiye', 'Ukraine', 'United Kingdom', 'Uzbekistan'),collapse=",")
  } else if (acronym=='OIRSA'){
    countries = paste(c('Belize', 'Costa Rica', 'Dominican Republic', 'El Salvador', 'Guatemala', 'Honduras', 'Mexico', 'Nicaragua', 'Panama'), collapse=",")
  } else if (acronym=='EAEU'){
    countries = paste(c('Armenia', 'Belarus', 'Kazakhstan', 'Kyrgyzstan', 'Russia'), collapse=",")
  } else if (acronym=='COSAVE'){
    countries = paste(c('Argentina', 'Bolivia', 'Brazil', 'Chile', 'Paraguay', 'Peru', 'Uruguay'), collapse=",")
  } else if (acronym=='EU'){
    countries = paste(c('Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden'), collapse=",")
  } else if (acronym=='APPPC'){
    countries = paste(c('Australia', 'Bangladesh', 'Cambodia', 'China', 'East Timor', 'Fiji', 'French Polynesia', 'India', 'Indonesia', "Korea Dem. People's Republic", 'Korea, Republic', 'Laos', 'Malaysia', 'Myanmar', 'Nepal', 'New Zealand', 'Pakistan', 'Papua New Guinea', 'Philippines', 'Samoa', 'Solomon Islands', 'Sri Lanka', 'Thailand', 'Tonga', 'Vietnam'), collapse=",")
  } else if (acronym=='CAHFSA'){
    countries = paste(c('Antigua and Barbuda', 'Bahamas', 'Barbados', 'Belize', 'Dominica', 'Grenada', 'Guyana', 'Haiti', 'Jamaica', 'Montserrat', 'Saint Lucia', 'St Kitts-Nevis', 'St Vincent and the Grenadines', 'Suriname', 'Trinidad and Tobago'), collapse=",")
  } else if (acronym=='CAN'){
    countries = paste(c('Bolivia', 'Colombia', 'Ecuador', 'Peru', 'Venezuela'), collapse=",")
  } else if (acronym=='IAPSC'){
    countries = paste(c('Algeria', 'Angola', 'Benin', 'Botswana', 'Burkina Faso', 'Burundi', 'Cameroon', 'Cape Verde', 'Central African Republic', 'Chad', 'Comoros', 'Congo', 'Congo, Democratic Republic of the', "Cote d'Ivoire", 'Djibouti', 'Egypt', 'Equatorial Guinea', 'Eritrea', 'Eswatini', 'Ethiopia', 'Gabon', 'Gambia', 'Ghana', 'Guinea', 'Guinea-Bissau', 'Kenya', 'Lesotho', 'Liberia', 'Libya', 'Madagascar', 'Malawi', 'Mali', 'Mauritania', 'Mauritius', 'Morocco', 'Mozambique', 'Namibia', 'Niger', 'Nigeria', 'Rwanda', 'Sao Tome & Principe', 'Senegal', 'Seychelles', 'Sierra Leone', 'Somalia', 'South Africa', 'South Sudan', 'Sudan', 'Tanzania', 'Togo', 'Tunisia', 'Uganda', 'Zaire', 'Zambia', 'Zimbabwe'), collapse=",")
  } else if (acronym=='NAPPO'){
    countries = paste(c('Canada', 'Mexico', 'United States of America'), collapse=",")
  } else if (acronym=='NEPPO'){
    countries = paste(c('Algeria', 'Egypt', 'Jordan', 'Libya', 'Malta', 'Morocco', 'Pakistan', 'South Sudan', 'Sudan', 'Syria', 'Tunisia'), collapse=",")
  } else if (acronym=='PPPO'){
    countries = paste(c('American Samoa', 'Australia', 'Cook Islands', 'Fiji', 'French Polynesia', 'Guam', 'Kiribati', 'Marshall Islands', 'Micronesia', 'Nauru', 'New Caledonia', 'New Zealand', 'Niue', 'Northern Mariana Islands', 'Palau', 'Papua New Guinea', 'Pitcairn', 'Samoa', 'Solomon Islands', 'Tokelau', 'Tonga', 'Tuvalu', 'Vanuatu', 'Wallis and Futuna Islands'), collapse=",")
  }
  
  return(countries)
}
