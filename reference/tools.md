# Query the EPPO API Tools endpoints.

This function queries the Tools endpoints of the EPPO Global Database
via REST API. The function sequentially queries all specified `services`
and returns the extracted data through a list of dataframes.

## Usage

``` r
tools(
  services = c("name2codes"),
  params = list(name2codes = list()),
  apiKey = Sys.getenv("EPPO_API_KEY")
)
```

## Arguments

- services:

  `character` (vector). One or more Tools services to query. Common
  service names include: `name2codes`. A validation step ensures that
  all provided services match the supported service names.

  By default: all services.

- params:

  `list`. A named list of query parameters to include in the request.
  The list of available parameters can be accessed via the [EPPO API
  Documentation](https://data2025.eppo.int/ui/#/docs/GDAPI) platform.

  By default: no parameters, you need to specify the required ones.

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
if (FALSE) {
# Get the EPPO codes associated to the name Bemisia tabaci.
toolsData_ <- tools(params = list(
  name2codes = list(
    onlyPreferred = FALSE,
    name = "Bemisia tabaci"
  )
))
}
```
