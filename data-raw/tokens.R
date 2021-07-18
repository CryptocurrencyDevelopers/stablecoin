## code to prepare `tokens` dataset goes here
library(usethis)
library(jsonlite)
library(tibble)

# if (!file.exists("data-raw/tokens.json")) {
#   # download.file(
#   #   "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat",
#   #   "data-raw/tokens.json"
#   # )
# }

tokens <- jsonlite::read_json('data-raw/tokens.json', simplifyVector = TRUE) %>% as_tibble()

usethis::use_data(tokens, overwrite = TRUE, compress = 'xz')
