# Query the EPPO API RPPO endpoints.

This function queries the RPPO endpoints of the EPPO Global Database via
REST API for one or more RPPO code(s) and one or more service(s). For
each RPPO code in `rppoCodes`, the function sequentially queries all
specified `services` and returns the extracted data through a list of
dataframes.

## Usage

``` r
rppo(
  rppoCodes,
  services = c("overview", "categorization"),
  apiKey = Sys.getenv("EPPO_API_KEY")
)
```

## Arguments

- rppoCodes:

  `character` (vector). One or more RPPO codes to query. Available RPPO
  codes can be retrieved via the `references/rppos` service.

- services:

  `character` (vector). One or more RPPO services to query. Common
  service names include: `overview` and `categorization`. A validation
  step ensures that all provided services match the supported service
  names.

  By default: all services.

- apiKey:

  `character` (string). The API key used for authentication. It can be
  specified manually or through the .Renviron file.

  By default: Sys.getenv("EPPO_API_KEY").

## Value

A named list of results, in which each level corresponds to the data
retrieved for each specified service. Each service element contains a
flattened dataframe with the queried content for all the specified RPPO
codes.

## Examples

``` r
if (FALSE) { # \dontrun{
# Get all information about the European and Mediterranean Plant Protection
# Organisation.
rppoData_ <- rppo(rppoCodes = c("9A"))

# Get categorization data about the European and Mediterranean Plant
# Protection Organisation.
rppoData_ <- rppo(rppoCodes = c("9A"), services = c("categorization"))

# Get basic data about European and Mediterranean Plant Protection
# Organisation and the European Union.
rppoData_ <- rppo(rppoCodes = c("9A", "9L"), services = c("overview"))
} # }
```
