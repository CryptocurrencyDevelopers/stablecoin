library(stablecoin)

test_that("Historical supply fetches tibble data frame", {
  skip_on_cran()
  expect_s4_class(historical_supply(
                                    network = 'Ethereum',
                                    token = 'USDC',
                                    start_time = '2020-01-01',
                                    end_time = '2021-07-14')
                            , "data.frame")
})

test_that("All historical supply enabled tokens fetch", {
  skip_on_cran()
  expect_s4_class(historical_supply_all(
    start_time = '2020-01-01',
    end_time = '2021-07-14')
    , "data.frame")
})
