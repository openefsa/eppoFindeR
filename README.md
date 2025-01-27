# eppoFindeR <img src="man/figures/logo.png" height="200" align="right"/>

[![Lifecycle: stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable) [![codecov](https://codecov.io/gh/openefsa/eppoFindeR/graph/badge.svg?token=6FLJOPL6II)](https://codecov.io/gh/openefsa/eppoFindeR)

# Introduction

Welcome to the *eppoFindeR* package! This package is a wrapper around the public APIs of the European and Mediterranean Plant Protection Organization (EPPO) database. It provides a straightforward way to access a wide range of pest-specific information that has been produced or collected by EPPO.

*eppoFindeR* is designed for use by researchers and practitioners working in plant protection who need easy access to the EPPO database using R.

# Getting Started

To use the *eppoFindeR* package, you need a stable internet connection, as it interacts with the EPPO database online services to fetch and manipulate data. A reliable internet connection is essential for the functionality of the package.

You can install the *eppoFindeR* package from CRAN using the following command:

```         
install.packages("eppoFindeR")
```

Alternatively, if you want to install the package from GitHub (for the latest development version), use:

```
# install.packages("devtools")

devtools::install_github("openefsa/eppoFindeR")
```

For a detailed guide and usage examples, please refer to the [full vignette](https://github.com/openefsa/eppoFindeR/blob/HEAD/vignettes/eppoFindeR.Rmd).
