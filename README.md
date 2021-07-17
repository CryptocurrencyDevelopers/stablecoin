
<!-- README.md is generated from README.Rmd. Please edit that file -->

# stablecoin <img src='man/figures/logo.png' align="right" height="138" />

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/stablecoin)](https://CRAN.R-project.org/package=stablecoin)
[![Codecov test
coverage](https://codecov.io/gh/galen211/stablecoin/branch/master/graph/badge.svg)](https://codecov.io/gh/galen211/stablecoin?branch=master)
[![R-CMD-check](https://github.com/galen211/stablecoin/workflows/R-CMD-check/badge.svg)](https://github.com/galen211/stablecoin/actions)
<!-- badges: end -->

The goal of stablecoin is to give data analysts a way to quickly
assemble and analyze data on different stablecoins that exist on public
blockchains.

## Installation

You can install the released version of stablecoin from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("stablecoin")
```

Load the package with:

    #> Loading required package: tidyverse
    #> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.0 ──
    #> ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
    #> ✓ tibble  3.1.2     ✓ dplyr   1.0.3
    #> ✓ tidyr   1.1.2     ✓ stringr 1.4.0
    #> ✓ readr   1.4.0     ✓ forcats 0.5.1
    #> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    #> x dplyr::filter() masks stats::filter()
    #> x dplyr::lag()    masks stats::lag()

## Basic Usage

Fetch the current circulating supply in a tibble data frame

    #> # A tibble: 5 x 4
    #>   datetime            chain   token_id                         circulating_supp…
    #>   <dttm>              <chr>   <chr>                                        <dbl>
    #> 1 2021-07-11 17:46:24 Ethere… 0xa0b86991c6218b36c1d19d4a2e9eb…      25283313644.
    #> 2 2021-07-11 17:46:24 Algora… 31566704                                173460569.
    #> 3 2021-07-11 17:46:24 Stellar GA5ZSEJYB37JRC5AVCIA5MOP4RHTM33…         12236161.
    #> 4 2021-07-11 17:46:24 Solana  EPjFWdd5AufqSSqeM2qN1xzybapC8G4…        785000020.
    #> 5 2021-07-11 17:46:24 TRON    TEkxiTehnzSmSe2XqrBj4w32RUN966r…        108956343.

## Data sources used by `stablecoin`

-   Current USDC in circulation on each of the officially supported
    blockchains is provided through the webservices listed below:
    -   **Algorand**: [AlgoExplorer](https://algoexplorer.io/) explorer
        API service
    -   **Ethereum**: [Blockchair](https://blockchair.com/) explorer API
        service
    -   **Solana**:
        [Solana](https://docs.solana.com/developing/clients/jsonrpc-api)
        JSON RPC API
    -   **Stellar**: [Stellar Foundation](https://www.stellar.org/)
        explorer API service
    -   **TRON**: [TRON Scan](https://tronscan.org/#/) explorer API
        service
-   Historical USDC metrics are fetched from the [Coin
    Metrics](https://docs.coinmetrics.io/api/v4) API

## Roadmap

Centre is developing a graphql
[subgraph](https://thegraph.com/explorer/subgraph/centrehq/usdc), which
may eventually expand the scope of data analysis interfaces that can be
provided by this package. Some ideas for future functionality are
described on the roadmap below.

**Roadmap Items:** - Track each chain’s historical balance of USDC - Add
additional convenience charts and chart customizations - Query the
Centre USDC subgraph using the Graph protocol - Track USDC token
balances deposited in different lending and DEX protocols

## Code of Conduct

Please note that the stablecoin project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
