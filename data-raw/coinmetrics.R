## code to prepare `coinmetrics` dataset goes here
library(usethis)
library(readr)
library(tibble)

# if (!file.exists("data-raw/tokens.json")) {
#   # download.file(
#   #   "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat",
#   #   "data-raw/tokens.json"
#   # )
# }

coinmetrics <- readr::read_csv2(file = 'data-raw/coinmetrics_fields.csv') %>% as_tibble()

usethis::use_data(coinmetrics, overwrite = TRUE)
