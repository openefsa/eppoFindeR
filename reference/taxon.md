# Query the EPPO API Taxon endpoints.

This function queries the Taxon endpoints of the EPPO Global Database
via REST API for one or more EPPO code(s) and one or more service(s).
For each EPPO code in `eppoCodes`, the function sequentially queries all
specified `services` and returns the extracted data through a list of
dataframes.

## Usage

``` r
taxon(
  eppoCodes,
  services = c("overview", "infos", "names", "taxonomy", "categorization", "kingdom",
    "hosts", "pests", "vectors", "vectorof", "bca", "bcaof", "photos",
    "reporting_articles", "documents", "standards", "distribution"),
  apiKey = Sys.getenv("EPPO_API_KEY")
)
```

## Arguments

- eppoCodes:

  `character` (vector). One or more EPPO codes to query.

  EPPO codes are standardized identifiers for plants and pests
  (including pathogens). These alphanumeric codes, typically of 5 to 6
  letters long, serve as unique, mnemonic abbreviations of scientific
  names. The EPPO coding system facilitates the management and exchange
  of organism names across databases and IT systems. EPPO codes and
  their corresponding data can be accessed via the [EPPO Data
  Services](https://data.eppo.int/) platform.

- services:

  `character` (vector). One or more Taxon services to query. Common
  service names include: `overview`, `infos`, `names`, `taxonomy`,
  `categorization`, `kingdom`, `hosts`, `pests`, `vectors`, `vectorof`,
  `bca`, `bcaof`, `photos`, `reporting_articles`, `documents`,
  `standards` and `distribution`. A validation step ensures that all
  provided services match the supported service names.

  By default: all services.

- apiKey:

  `character` (string). The API key used for authentication. It can be
  specified manually or through the .Renviron file.

  By default: Sys.getenv("EPPO_API_KEY").

## Value

A named list of results, in which each level corresponds to the data
retrieved for each specified service. Each service element contains a
flattened dataframe with the queried content for all the specified EPPO
codes.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get all information about Bemisia tabaci.
taxonData_ <- taxon(eppoCodes = c("BEMITA"))

# Get names data about Bemisia tabaci.
taxonData_ <- taxon(eppoCodes = c("BEMITA"), services = c("names"))

# Get taxonomy and categorization data about Bemisia tabaci and Gossypium
# hirsutum.
taxonData_ <- taxon(
  eppoCodes = c("BEMITA", "GOSHI"),
  services = c("taxonomy", "categorization"))
} # }
```
