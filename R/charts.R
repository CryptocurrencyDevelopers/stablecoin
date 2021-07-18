#' Plot the current stablecoin supply on supported blockchains
#'
#' @description
#' Retrieves the supply for `selected_tokens` on each supported blockchain and
#' then plots the result on a bar chart
#'
#' @export
#' @importFrom ggplot2 ggplot geom_bar scale_y_continuous xlab ylab ggtitle
#' @importFrom scales dollar_format dollar
#' @importFrom ggthemes theme_economist_white
#' @return a ggplot2 chart showing the current circulating amount of USDC
#' @examples
#' usdc_plot_current_supply()
#' usdc_plot_current_supply("USDC")
plot_current_supply <- function(selected_tokens = NULL) {
  df <- current_supply_all(selected_tokens)
  # total_supply = sum(df$circulating_supply)
  df %>%
    arrange(desc(supply)) %>%
    ggplot(ggplot2::aes(x = chain, y = supply)) +
    geom_bar(stat = "identity") +
    scale_y_continuous(labels = dollar_format(scale = 1e-9, accuracy = 1)) +
    xlab("\nBlockchain") +
    ylab("USD Billions\n") +
    # ggtitle(paste("Current Supply:",token,"\n"), subtitle = paste("Total Supply:", dollar(total_supply, scale = 1e-9, accuracy = 0.1), "Billion")) +
    theme_economist_white(
      gray_bg = FALSE,
      base_size = 12
    )
}

#' Plot historical stablecoin supply on Ethereum
#'
#' @description
#' Retrieves the supply for `selected_tokens` on each supported blockchain and
#' then plots the result on a bar chart
#'
#' @export
#'
#' @importFrom ggplot2 ggplot geom_line scale_y_continuous labs ggtitle
#' @importFrom ggthemes theme_economist_white
#' @importFrom scales dollar_format dollar
#'
#' @return a ggplot2 chart showing the historical circulating amount of USDC on Ethereum
#'
#' @examples
#'
#' usdc_plot_historical_supply()
plot_historical_supply <- function(networks, tokens, start_time, end_time) {

  df <- tokens %>%
    filter(network %in% networks & token %in% tokens & historical == TRUE) %>%
    mutate(supply = map2_dfr(network, token, historical_supply, start_time, end_time))

  df <- historical_supply(networks, tokens, start_time, end_time)
  df %>%
    ggplot(ggplot2::aes(x = date, y = supply)) +
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
