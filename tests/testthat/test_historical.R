library(stablecoin)

test_that("Ethereum historical circulation fetches tibble data frame", {
  skip_on_cran()
  expect_type(fetch_historical_ethereum(), "list")
})

test_that("Unsupported metric throws error", {
  skip_on_cran()
  expect_error(fetch_historical_ethereum(metric = "DNE"))
})
