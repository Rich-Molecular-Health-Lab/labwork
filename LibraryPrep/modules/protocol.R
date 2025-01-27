protocolUI <- function(id, protocol_data) {
  ns <- NS(id)
  tagList(
    lapply(protocol_data$parts, function(module_name) {
      moduleUI(ns(module_name$name), modules[[module_name]])
    })
  )
}

protocolServer <- function(id, protocol_data) {
  moduleServer(id, function(input, output, session) {
    lapply(protocol_data$parts, function(module_name) {
      moduleServer(module_name$name, modules[[module_name]])
    })
  })
}