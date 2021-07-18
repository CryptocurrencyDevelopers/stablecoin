user_agent <- httr::user_agent("https://github.com/galen211/stablecoin")
accept_json <- httr::content_type_json()

#' @importFrom httr modify_url RETRY stop_for_status http_type content_type_json content
#' @importFrom jsonlite fromJSON
webservice_call <- function(base_url, verb = "GET", body = FALSE, path = NULL, query = NULL, ...) {
  service_name <- str_to_title(str_replace_all(deparse(substitute(base_url)),"_"," "))

  url <- modify_url(base_url, path = path, query = query)

  resp <- RETRY(verb,
                url,
                body = body,
                user_agent,
                content_type_json(),
                times = 5,
                terminate_on = c(404)) # break on these codes

  stop_for_status(resp, paste("execute webservice call for", service_name))

  # if (http_type(resp) != "application/json") {
  #   stop("API did not return json", call. = FALSE)
  # }

  parsed <- fromJSON(content(resp, "text", encoding = "UTF-8"), simplifyVector = FALSE)

  structure(
    list(
      content = parsed,
      path = path,
      response = resp
    ),
    class = deparse(substitute(base_url))
  )
}

cached_webservice_call <- memoise::memoise(webservice_call)
