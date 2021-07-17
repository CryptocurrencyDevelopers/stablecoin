#' Plot the current USDC circulation on all official Centre blockchains
#'
#' @description
#' Queries the Algorand, Ethereum, Solana, and Stellar blockchains to retrieve the token balances of USDC
#' on each blockchain and then plots the result on a bar chart
#'
#' @export
#' @importFrom ggplot2 ggplot geom_bar scale_y_continuous xlab ylab ggtitle
#' @importFrom dplyr arrange desc
#' @importFrom scales dollar_format dollar
#' @importFrom ggthemes theme_economist_white
#' @return a ggplot2 chart showing the current circulating amount of USDC
#' @examples
#' chart_current_supply_usdc()
chart_current_supply_usdc <- function() {
  circulating_supply <- chain <- NULL
  df <- fetch_supply_usdc()
  total_supply = sum(df$circulating_supply)
  df %>%
    arrange(desc(circulating_supply)) %>%
    ggplot(ggplot2::aes(x = chain, y = circulating_supply)) +
    geom_bar(stat = "identity") +
    scale_y_continuous(labels = dollar_format(scale = 1e-9, accuracy = 1)) +
    xlab("\nBlockchain") +
    ylab("USD Billions\n") +
    ggtitle("Current USDC Supply\n", subtitle = paste("Total Supply:", dollar(total_supply, scale = 1e-9, accuracy = 0.1), "Billion")) +
    theme_economist_white(
      gray_bg = FALSE,
      base_size = 12
    )
}

#' Plot the historical USDC circulation on Ethereum
#'
#' @description
#' Queries the CoinMetrics API to retrieve the circulating supply of USDC
#' on Ethereum and then plots the result on a line chart
#'
#' @export
#' @importFrom ggplot2 ggplot geom_line scale_y_continuous labs ggtitle
#' @importFrom ggthemes theme_economist_white
#' @importFrom scales dollar_format dollar
#' @return a ggplot2 chart showing the historical circulating amount of USDC on Ethereum
#' @examples
#' chart_historical_supply_usdc()
chart_historical_supply_usdc <- function() {
  circulating_supply <- date <- value <- NULL
  fetch_historical_ethereum(metric = "CapMrktCurUSD") %>%
    ggplot(ggplot2::aes(x = date, y = value)) +
    geom_line(stat = "identity") +
    scale_y_continuous(labels = dollar_format(scale = 1e-9, accuracy = 1)) +
    xlab("\nDate") +
    ylab("USD Billions\n") +
    ggtitle("Historical USDC Supply\n", subtitle = "Ethereum") +
    theme_economist_white(
      gray_bg = FALSE,
      base_size = 12
    )
}
