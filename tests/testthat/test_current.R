library(stablecoin)

test_that("Algorand circulation fetches double value", {
  skip_on_cran()
  expect_type(current_supply("Algorand", "USDC"), "double")
})

test_that("Ethereum circulation fetches double value", {
  skip_on_cran()
  expect_type(current_supply("Ethereum", "USDC"), "double")
})

test_that("Solana circulation fetches double value", {
  skip_on_cran()
  expect_type(current_supply("Solana", "USDC"), "double")
})

test_that("Stellar circulation fetches double value", {
  skip_on_cran()
  expect_type(current_supply("Stellar", "USDC"), "double")
})

test_that("TRON circulation fetches double value", {
  skip_on_cran()
  expect_type(current_supply("TRON", "USDC"), "double")
})

test_that("Current supply fetches from all supported blockchains", {
  skip_on_cran()
  expect_s4_class(current_supply_all(), "data.frame")
})

test_that("Unsupported blockchain stops with error", {
  skip_on_cran()
  expect_error(current_supply("FAKE", "USDC"))
})
