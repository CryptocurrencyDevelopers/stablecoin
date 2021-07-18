
token_address <- function(target_network, target_token) {
  result <- tokens %>%
    filter(network == target_network & token == target_token) %>%
    pull(token_id)

  if(rlang::is_empty(result)) {
    stop('Token is either not found or supported. Check for typos.')
  }
  result
}

cached_token_address <- memoise::memoise(token_address)

token_df <- function(target_token) {
  result <- tokens %>%
    filter(token == target_token) %>%
    select(network, token, token_id)

  if(nrow(result) == 0) {
    stop('Token is either not found or supported. Check for typos.')
  }
  result
}
