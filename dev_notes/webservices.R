
sc_http_get <- function(
  base_url = '',
  endpoint = '',
  service_name = '') {
  r <- httr::GET("https://api.blockchair.com/ethereum/erc-20/0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48/stats")
  if(httr::http_error(r)){ 	warning("BlockChair webservice is unable to retrieve USDC balance on Ethereum")}
  return(content(r, as = "text", encoding = "UTF-8"))
}

sc_ghql <- function(query = NULL, param) {

}


fetch_supply_ethereum <- function() {
  . <- NULL
  r <- httr::GET("https://api.blockchair.com/ethereum/erc-20/0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48/stats")
  if(httr::http_error(r)){ 	warning("BlockChair webservice is unable to retrieve USDC balance on Ethereum") }
  t <- httr::content(r, as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON() %>%
    .$data
  supply <- as.numeric(t$circulation) / 10**t$decimals
  return(supply)
}
