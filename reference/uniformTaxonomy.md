# Create a complete and uniform taxonomy dataframe.

This function normalizes the taxonomy returned by the EPPO service,
producing a uniform structure that includes all possible taxonomic
categories, even when some of them are not present in the original
result.

## Usage

``` r
uniformTaxonomy(taxonomyData)
```

## Arguments

- taxonomyData:

  `tibble`. A dataframe containing taxonomy data provided by the EPPO
  service for a given EPPO code.

## Value

A dataframe where each row represents one of the expected taxonomic
ranks. Fields corresponding to ranks not present in the original
taxonomy are filled with `NA`. The `level` column is excluded from the
output. The column `queried_eppo_code` NA values are filled with the
right code.

## Details

The function uses an internal set of known taxonomic ranks and performs
a left join with the `taxonomy` dataframe, filling missing ranks with
`NA`. After the join, the column `level` from the original taxonomy is
removed, since the rank order is fully defined by the internal reference
list. The column `queried_eppo_code` NA values are filled with the right
code.

## Examples

``` r
if (FALSE) { # \dontrun{
# Retrieve taxonomy data from the EPPO service.
taxonData_ <- taxon(eppoCodes = c("BEMITA"), services = c("taxonomy"))

# Create a uniform taxonomy with all ranks.
taxonomyData_ <- uniformTaxonomy(taxonomyData = taxonData_$taxonomy)
} # }
```
