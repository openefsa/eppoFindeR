#' Create a complete and uniform taxonomy dataframe.
#'
#' This function normalizes the taxonomy returned by the EPPO service,
#' producing a uniform structure that includes all possible taxonomic
#' categories, even when some of them are not present in the original result.
#'
#' The function uses an internal set of known taxonomic ranks and performs
#' a left join with the `taxonomy` dataframe, filling missing ranks with `NA`.
#' After the join, the column `level` from the original taxonomy is removed,
#' since the rank order is fully defined by the internal reference list. The
#' column `queried_eppo_code` NA values are filled with the right code.
#'
#' @param taxonomyData `tibble`. A dataframe containing taxonomy data provided
#'   by the EPPO service for a given EPPO code.
#'
#' @return A dataframe where each row represents one of the expected taxonomic
#'   ranks. Fields corresponding to ranks not present in the original taxonomy
#'   are filled with `NA`. The `level` column is excluded from the output. The
#'   column `queried_eppo_code` NA values are filled with the right code.
#'
#' @importFrom dplyr left_join select any_of
#' @importFrom checkmate assert_data_frame assert_names assert_true
#' @importFrom tibble tibble
#'
#' @examplesIf FALSE
#' # Retrieve taxonomy data from the EPPO service.
#' taxonData_ <- taxon(eppoCodes = c("BEMITA"), services = c("taxonomy"))
#'
#' # Create a uniform taxonomy with all ranks.
#' taxonomyData_ <- uniformTaxonomy(taxonomyData = taxonData_$taxonomy)
#' 
#' @export
#' 
uniformTaxonomy <- function(taxonomyData) {
  
  assert_data_frame(taxonomyData)
  assert_names(names(taxonomyData), must.include = c(
    "queried_eppo_code", "type"))
  assert_true(any(!is.na(taxonomyData$queried_eppo_code)))
  
  taxonomyTypes_ <- tibble(
    type = c(
      "Kingdom",
      "Phylum",
      "Subphylum",
      "Class",
      "Subclass",
      "Order",
      "Suborder",
      "Family",
      "Subfamily",
      "Genus",
      "Species"
    )
  )
  
  taxonomyData <- taxonomyTypes_ |>
    left_join(taxonomyData, by = "type") |>
    select(-any_of("level"))
  
  queried_eppo_code_ <- taxonomyData$queried_eppo_code[
    !is.na(taxonomyData$queried_eppo_code)][1]
  
  taxonomyData <- taxonomyData |> mutate(
    queried_eppo_code = {
      ifelse(
        is.na(taxonomyData$queried_eppo_code),
        queried_eppo_code_,
        taxonomyData$queried_eppo_code)
    }
  )
  
  return(taxonomyData)
}
