here::i_am("setup/setup.R")

source(here::here(global$packages))
source(here::here(global$conflicts))
source(here::here(global$functions))
source(here::here(global$inputs))


budget        <- config::get(config = "budget")
libprep       <- config::get(config = "libprep")
rapid16s      <- config::get(config = "rapid16s")
lsk           <- config::get(config = "lsk")


knitr::knit_engines$set(terminal = function(options) {
  code <- paste(options$code, collapse = "\n")
  
  params <- map(params, ~ if (is.atomic(.)) {list(.)} else {(.)}) %>%
    list_flatten()
  
  patterns <- list(
    budget   = budget  ,
    libprep  = libprep ,
    rapid16s = rapid16s,
    lsk      = lsk     
  )
  
  
  # Replace placeholders group by group
  for (group in names(patterns)) {
    placeholder_list <- patterns[[group]]
    for (name in names(placeholder_list)) {
      placeholder <- paste(group, name, sep = "\\$") # Match exact placeholder
      value <- placeholder_list[[name]]
      
      # Replace placeholders exactly and avoid breaking suffixes
      code <- gsub(placeholder, value, code, perl = TRUE)
    }
  }
  
  options$warning <- FALSE
  knitr::engine_output(options, code, out = code)
})

opts_chunk$set(message = FALSE,
               warning = FALSE,
               echo    = TRUE,
               include = TRUE,
               eval    = TRUE,
               comment = "")

