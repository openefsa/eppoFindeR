# eppoFindeR <img src="https://raw.githubusercontent.com/openefsa/eppoFindeR/main/man/figures/logo.png" height="140" align="right"/>

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![codecov](https://codecov.io/gh/openefsa/eppoFindeR/branch/main/graph/badge.svg?token=TR7ETTDG2Z)](https://codecov.io/gh/openefsa/eppoFindeR)

## Overview

**eppoFindeR** provides an R interface to the public APIs of the **European and Mediterranean Plant Protection Organization (EPPO)** database.
The package facilitates access to a wide range of pest-related information collected and maintained by EPPO, allowing users to query, retrieve, and process this data directly from R.

The package is intended for researchers, analysts, and practitioners in plant protection who require convenient programmatic access to EPPO data.

## Installation

### From CRAN

```r
install.packages("eppoFindeR")
```

### Development version (from GitHub)

To install the latest development version:

```r
# install.packages("devtools")
devtools::install_github("openefsa/eppoFindeR")
```

## Requirements

An active internet connection is required, as the package communicates with EPPO’s online services to fetch and process data.

## Usage

Once installed, load the package as usual:

```r
library(eppoFindeR)
```

Basic usage examples and full documentation are available in the package [vignette](vignettes/eppoFindeR.Rmd):

```r
vignette("eppoFindeR")
```

## Links

- **Source code:** [GitHub – openefsa/eppoFindeR](https://github.com/openefsa/eppoFindeR)  
- **Bug reports:** [Issues on GitHub](https://github.com/openefsa/eppoFindeR/issues)  
- **EPPO Global Database:** [https://gd.eppo.int](https://gd.eppo.int)
