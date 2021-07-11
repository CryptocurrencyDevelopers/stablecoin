## code to prepare `bitquery` dataset goes here

usethis::use_data(bitquery, overwrite = TRUE)

userHistoryQuery <- read_file(file = "../graphql/aave_user_transactions.graphql")

if (!file.exists("data-raw/airports.dat")) {
  download.file(
    "https://raw.githubusercontent.com/jpatokal/openflights/master/data/airports.dat",
    "data-raw/airports.dat"
  )
}
