## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, echo=FALSE--------------------------------------------------------
library(eppoFindeR)

## ----instCRAN-----------------------------------------------------------------
# install.packages("eppoFindeR")

## ----instDevOps---------------------------------------------------------------
# install.packages("devtools")
# devtools::install_github("yourusername/eppoFindeR")

## ----queryServ----------------------------------------------------------------
library(eppoFindeR)

result <- queryTheEPPOForService("BEMITA", service = "categorization")
print(result)

## ----queryWhole---------------------------------------------------------------
result_list <- queryTheWholeEPPO("BEMITA")

# Print the names of the services in the result
print(names(result_list))

# Print the data from a specific service
print(result_list$categorization)

## ----rankExample--------------------------------------------------------------
taxonomy <- queryTheEPPOForService("BEMITA", service = "taxonomy")
kingdom <- queryTheEPPOForService("BEMITA", service = "kingdom")

# Wrangle data to combine taxonomy and rank
wrangled_data <- taxonomyRanked(taxonomy, kingdom)
print(wrangled_data)

## ----backUpExample------------------------------------------------------------
# Perform a backup search across all services for a pool of EPPO codes
backup_result <- backUpEPPO(c("BEMITA", "LEUCSC"))
print(backup_result)

