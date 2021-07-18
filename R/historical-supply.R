#' Retrieve historical stablecoin circulation
#'
#' @description
#' Queries the Coin Metrics `asset-metrics` endpoint to retrieve historical stablecoin circulation
#'
#' @param network The blockchain network
#' @param token The stablecoin token
#' @param start_time Start of the time interval
#' @param end_time End of the time interval

#' @rdname historical_supply
#'
#' @export
#'
#' @return a dataframe with the historical supply
#'
#' @examples
#' historical_supply(network = 'Ethereum', token = 'USDC', start_time = '2020-01-01', end_time = '2021-07-14')
#' historical_supply_all(start_time = '2020-01-01', end_time = '2021-07-14')
historical_supply <- function(network, token, start_time, end_time) {
  switch(network,
         'Algorand' = historical_supply_algorand(token, start_time, end_time),
         'Ethereum' = historical_supply_ethereum(token, start_time, end_time),
         'Solana' = historical_supply_solana(token, start_time, end_time),
         'Stellar' = historical_supply_stellar(token, start_time, end_time),
         'TRON' = historical_supply_tron(token, start_time, end_time),
         stop('Invalid or unsupported blockchain network specified')
         )
}

#' @export
#'
#' @rdname historical_supply
historical_supply_all <- function(start_time, end_time) {
  supply <- tokens %>%
    filter(historical == TRUE) %>%
    mutate(supply = purrr::map2(network, token, historical_supply, start_time, end_time)) %>%
    select(supply) %>%
    unnest(cols = c(supply)) %>%
    arrange(network, token, date)
  return(supply)
}

historical_supply_algorand <- function(token, start_time, end_time) {
  stop(paste('Historical supply for', token, 'not implemented for Algorand!'))
  start_time <- end_time <- NULL
}

historical_supply_ethereum <- function(token, start_time, end_time) {
  stablecoin_token <- token
  coinmetrics_token <- switch(token,
         'USDC' = 'USDC',
         'USDT' = 'USDT_ETH',
         'DAI' = 'DAI',
         'BUSD' = 'BUSD',
         'PAX' = 'PAX',
         'HUSD' = 'HUSD',
         'GUSD' = 'GUSD',
         'USDK' = 'USDK',
         'TUSD' = 'TUSD',
         stop(paste('Historical supply for', token, 'not supported on Ethereum'))
         )

  df <- coinmetrics_asset_metrics(coinmetrics_token, 'SplyCur', start_time, end_time) %>%
    dplyr::rename(date = datetime, supply = value) %>%
    dplyr::mutate(token = stablecoin_token) %>%
    dplyr::select(network, token, date, supply)
  return(df)
}

historical_supply_solana <- function(token, start_time, end_time) {
  stop(paste('Historical supply for', token, 'not implemented for Solana!'))
  start_time <- end_time <- NULL
}

historical_supply_stellar <- function(token, start_time, end_time) {
  stop(paste('Historical supply for', token, 'not implemented for Stellar!'))
  start_time <- end_time <- NULL
}

historical_supply_tron <- function(token, start_time, end_time) {
  stablecoin_token <- token
  coinmetrics_token <- switch(token,
                              'USDT' = 'USDT_TRX',
                              stop(paste('Historical supply for', token, 'not supported on TRON'))
  )
  df <- coinmetrics_asset_metrics(coinmetrics_token, 'SplyCur', start_time, end_time) %>%
    dplyr::rename(date = datetime, supply = value) %>%
    dplyr::mutate(token = stablecoin_token) %>%
    dplyr::select(network, token, date, supply)
  return(df)
}

