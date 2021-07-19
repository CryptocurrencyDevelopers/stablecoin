#' Returns requested metrics for specified assets using Coin Metrics V4 API
#'
#' @param token A stablecoin token
#' @param start_time Start of the time interval
#' @param end_time End of the time interval
#'
#' @return a dataframe with the results of the query
#'
#' @export
#'
#' @examples
#' \donttest{
#' coinmetrics_asset_metrics(token = 'USDC', metric = 'SplyAct1d', start_time = '2020-01-01', end_time = '2021-07-14')
#' }
coinmetrics_asset_metrics <- function(token, metric, start_time, end_time) {
  query <- list(
    assets = token,
    metrics = metric,
    start_time = start_time,
    end_time = end_time,
    page_size = 1000
  )

  r <- cached_webservice_call(coinmetrics_service,
                       verb = 'GET',
                       path = 'v4/timeseries/asset-metrics',
                       query = query)

  tryCatch({
    t <- r$content$data %>%
      purrr::map_dfr(unlist) %>%
      dplyr::rename(
        token = `asset`,
        datetime = `time`,
        value = `metric`
      ) %>%
      dplyr::mutate(
        token = stringr::str_to_upper(token),
        datetime = lubridate::as_date(datetime),
        measurement = metric,
        value = as.numeric(value)
      )
  },
  error = function(cond) {
    warning(paste("Failed to manipulate asset metrics for", token))
    return()
  }
  )
  return(t)
}

#' Supported Coin Metrics metrics for USDC
coinmetrics_supported_metrics <- c('AdrActCnt', 'AdrBal1in100KCnt', 'AdrBal1in100MCnt', 'AdrBal1in10BCnt', 'AdrBal1in10KCnt', 'AdrBal1in10MCnt', 'AdrBal1in1BCnt', 'AdrBal1in1KCnt', 'AdrBal1in1MCnt', 'AdrBalCnt', 'AdrBalNtv0.001Cnt', 'AdrBalNtv0.01Cnt', 'AdrBalNtv0.1Cnt', 'AdrBalNtv100Cnt', 'AdrBalNtv100KCnt', 'AdrBalNtv10Cnt', 'AdrBalNtv10KCnt', 'AdrBalNtv1Cnt', 'AdrBalNtv1KCnt', 'AdrBalNtv1MCnt', 'AdrBalUSD100Cnt', 'AdrBalUSD100KCnt', 'AdrBalUSD10Cnt', 'AdrBalUSD10KCnt', 'AdrBalUSD10MCnt', 'AdrBalUSD1Cnt', 'AdrBalUSD1KCnt', 'AdrBalUSD1MCnt', 'AssetEODCompletionTime', 'BlkCnt', 'BlkSizeMeanByte', 'BlkWghtMean', 'BlkWghtTot', 'CapAct1yrUSD', 'CapMVRVCur', 'CapMVRVFF', 'CapMrktCurUSD', 'CapMrktFFUSD', 'CapRealUSD', 'DiffLast', 'DiffMean', 'FeeByteMeanNtv', 'FeeMeanNtv', 'FeeMeanUSD', 'FeeMedNtv', 'FeeMedUSD', 'FeeTotNtv', 'FeeTotUSD', 'FlowInExNtv', 'FlowInExUSD', 'FlowOutExNtv', 'FlowOutExUSD', 'FlowTfrFromExCnt', 'GasLmtBlk', 'GasLmtBlkMean', 'GasLmtTx', 'GasLmtTxMean', 'GasUsedTx', 'GasUsedTxMean', 'HashRate', 'HashRate30d', 'IssContNtv', 'IssContPctAnn', 'IssContPctDay', 'IssContUSD', 'IssTotNtv', 'IssTotUSD', 'NDF', 'NVTAdj', 'NVTAdj90', 'NVTAdjFF', 'NVTAdjFF90', 'PriceBTC', 'PriceUSD', 'ROI1yr', 'ROI30d', 'RevAllTimeUSD', 'RevHashNtv', 'RevHashRateNtv', 'RevHashRateUSD', 'RevHashUSD', 'RevNtv', 'RevUSD', 'SER', 'SplyAct10yr', 'SplyAct180d', 'SplyAct1d', 'SplyAct1yr', 'SplyAct2yr', 'SplyAct30d', 'SplyAct3yr', 'SplyAct4yr', 'SplyAct5yr', 'SplyAct7d', 'SplyAct90d', 'SplyActEver', 'SplyActPct1yr', 'SplyAdrBal1in100K', 'SplyAdrBal1in100M', 'SplyAdrBal1in10B', 'SplyAdrBal1in10K', 'SplyAdrBal1in10M', 'SplyAdrBal1in1B', 'SplyAdrBal1in1K', 'SplyAdrBal1in1M', 'SplyAdrBalNtv0.001', 'SplyAdrBalNtv0.01', 'SplyAdrBalNtv0.1', 'SplyAdrBalNtv1', 'SplyAdrBalNtv10', 'SplyAdrBalNtv100', 'SplyAdrBalNtv100K', 'SplyAdrBalNtv10K', 'SplyAdrBalNtv1K', 'SplyAdrBalNtv1M', 'SplyAdrBalUSD1', 'SplyAdrBalUSD10', 'SplyAdrBalUSD100', 'SplyAdrBalUSD100K', 'SplyAdrBalUSD10K', 'SplyAdrBalUSD10M', 'SplyAdrBalUSD1K', 'SplyAdrBalUSD1M', 'SplyAdrTop100', 'SplyAdrTop10Pct', 'SplyAdrTop1Pct', 'SplyCur', 'SplyExpFut10yr', 'SplyFF', 'SplyMiner0HopAllNtv', 'SplyMiner0HopAllUSD', 'SplyMiner1HopAllNtv', 'SplyMiner1HopAllUSD', 'TxCnt', 'TxCntSec', 'TxTfrCnt', 'TxTfrValAdjNtv', 'TxTfrValAdjUSD', 'TxTfrValMeanNtv', 'TxTfrValMeanUSD', 'TxTfrValMedNtv', 'TxTfrValMedUSD', 'VelCur1yr', 'VtyDayRet180d', 'VtyDayRet30d')

