#' Retrieve current supply balances on supported blockchains
#'
#' @description
#' `current_supply` retrieves the current circulating supply of a stablecoin on
#' a single blockchain
#'
#' `current_supply_all` retrieves the current circulating supply of a stablecoin
#' or multiple stablecoins on all underlying blockchains
#'
#' @export
#'
#' @param network the blockchain network
#' @param token the stablecoin token
#' @param selected_tokens a single or multiple tokens
#'
#' @rdname current_supply
#'
#' @examples
#' \donttest{
#' current_supply(network = "Ethereum", token = "USDC")
#' current_supply_all()
#' current_supply_all("UDSC")
#' current_supply_all(selected_tokens = c("USDC", "USDT"))
#' }
current_supply <- function(network, token) {
  switch (network,
          "Algorand" = current_supply_algorand(token),
          "Ethereum" = current_supply_ethereum(token),
          "Solana" = current_supply_solana(token),
          "Stellar" = current_supply_stellar(token),
          "TRON" = current_supply_tron(token),
          stop("Invalid or unsupported blockchain network specified")
  )
}

#' @export
#'
#' @rdname current_supply
current_supply_all <- function(selected_tokens = NULL) {
  if(is.null(selected_tokens)) {
    selected_tokens <- tokens %>% dplyr::select(token) %>% unique() %>% purrr::as_vector()
  }

  result <- tokens %>%
    filter(token %in% selected_tokens) %>%
    mutate(current_supply = purrr::map2_dbl(network, token, current_supply)) %>%
    arrange(token, network)
  return(result)
}

current_supply_algorand <- function(token) {
  algorand_token <- cached_token_address("Algorand", token)
  r <- cached_webservice_call(base_url = algorand_service,
                              verb = 'GET',
                              path = paste0('v1/asset/', algorand_token))
  t <- r$content
  supply <- as.numeric(t$circulatingsupply) / 10**t$decimal
  return(supply)
}

current_supply_ethereum <- function(token) {
  ethereum_token <- cached_token_address("Ethereum", token)
  r <- cached_webservice_call(base_url = ethereum_service,
                              verb = 'GET',
                              path = paste0('ethereum/erc-20/', ethereum_token,'/stats'))
  t <- r$content$data
  supply <- as.numeric(t$circulation) / 10**t$decimals
  return(supply)
}

current_supply_stellar <- function(token) {
  stellar_token <- cached_token_address("Stellar", token)
  r <- cached_webservice_call(base_url = stellar_service,
                              verb = 'GET',
                              path = 'assets',
                              query = list(
                                asset_code = 'USDC',
                                asset_issuer = stellar_token
                              ))
  t <- r$content$`_embedded`$records[[1]]$amount
  supply <- as.numeric(t)
  return(supply)
}

current_supply_solana <- function(token) {
  solana_token <- cached_token_address("Solana", token)

  params <- list(
    jsonrpc = jsonlite::unbox('2.0'),
    id = jsonlite::unbox(1),
    method = jsonlite::unbox('getTokenSupply'),
    params =  solana_token
  )
  body <- jsonlite::toJSON(params)

  r <- cached_webservice_call(base_url = solana_service,
                              verb = 'POST',
                              body = body)

  t <- r$content$result$value
  supply <- as.numeric(t$amount) / 10**t$decimals
  return(supply)
}

current_supply_tron <- function(token) {
  tron_token <- cached_token_address("TRON", token)

  r <- cached_webservice_call(base_url = tron_service,
                              verb = 'GET',
                              path = 'api/token_trc20',
                              query = list(
                                contract = tron_token,
                                showAll = 1)
                              )
  t <- r$content$trc20_tokens
  supply <- as.numeric(t[[1]]$total_supply_with_decimals) / 10**6
  return(supply)
}

