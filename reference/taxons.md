# Query the EPPO API Taxons endpoints.

This function queries the Taxons endpoints of the EPPO Global Database
via REST API. The function sequentially queries all specified `services`
and returns the extracted data through a list of dataframes.

## Usage

``` r
taxons(
  services = c("list"),
  params = list(list = list(limit = 100, offset = 0, orderAsc = TRUE, orderBy =
    "creation")),
  apiKey = Sys.getenv("EPPO_API_KEY")
)
```

## Arguments

- services:

  `character` (vector). One or more Taxons services to query. Common
  service names include: `list`. A validation step ensures that all
  provided services match the supported service names.

  By default: all services.

- params:

  `list` (optional). A named list of query parameters to include in the
  request. The list of available parameters can be accessed via the
  [EPPO API Documentation](https://data.eppo.int/ui/#/docs/GDAPI)
  platform.

  By default: default parameters.

- apiKey:

  `character` (string). The API key used for authentication. It can be
  specified manually or through the .Renviron file.

  By default: Sys.getenv("EPPO_API_KEY").

## Value

A named list of results, in which each level corresponds to the data
retrieved for each specified service. Each service element contains a
flattened dataframe with the queried content.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get the list of taxons.
taxonsData_ <- taxons()

# Get the list of taxons with custom parameters.
taxonsData_ <- taxons(params = list(
  "list" = list(
    createdFromDate = "2000-01-01",
    limit = 5,
    offset = 1,
    orderAsc = FALSE,
    orderBy = "eppocode")))
} # }
```
