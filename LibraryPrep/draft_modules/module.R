moduleUI <- function(id, module_data) {
  ns <- NS(id)
  tagList(
    lapply(seq_along(module_data), function(i) {
      stepCardUI(ns(paste0("step_", i)), module_data[[i]])
    })
  )
}

moduleServer <- function(id, module_data) {
  moduleServer(id, function(input, output, session) {
    lapply(seq_along(module_data), function(i) {
      stepCardServer(paste0("step_", i), module_data[[i]])
    })
  })
}