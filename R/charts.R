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
#' \donttest{
#' usdc_plot_current_supply()
#' }
plot_current_supply <- function() {
  current_supply_all() %>%
    ggplot(aes(x = network, y = current_supply, fill = token)) +
    geom_bar(stat = "identity") +
    coord_flip() +
    scale_y_continuous(labels = dollar_format(scale = 1e-9, accuracy = 1)) +
    xlab("Blockchain") +
    ylab("USD Billions") +
    ggtitle("Current Stablecoin Supply on Major Blockchains") +
    theme_clean() +
    theme(legend.position = "none") +
    facet_wrap(~token, ncol = 2)
}

#' Plot historical stablecoin supply on Ethereum
#'
#' @description
#' Retrieves the supply for `selected_tokens` on each supported blockchain and
#' then plots the result on a bar chart
#'
#' @param start_time Start of the time interval
#' @param end_time End of the time interval
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
#' \donttest{
#' usdc_plot_historical_supply(start_time = '2020-01-01', end_time = '2021-07-18')
#' }
plot_historical_supply <- function(start_time, end_time) {
  historical_supply_all() %>%
    ggplot(aes(x = date, y = supply, color = network)) +
      geom_line(stat = "identity") +
      scale_y_continuous(labels = dollar_format(scale = 1e-6, accuracy = 1)) +
      xlab("Date") +
      ylab("USD Millions") +
      ggtitle("Historical Stablecoin Supply on Selected Blockchains", subtitle = "Jan 2021 - Current") +
      theme_clean() +
      facet_wrap(~token, scales = "free", ncol = 2)
}
