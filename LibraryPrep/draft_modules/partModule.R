partModuleUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("partUI"))
}

partModuleServer <- function(id, steps) {
  moduleServer(id, function(input, output, session) {
    output$partUI <- renderUI({
      tags$div(
        lapply(seq_along(steps), function(i) {
          stepCardUI(NS(id, paste0("step_", i)))
        })
      )
    })
    
    # Call stepCardServer for each step
    lapply(seq_along(steps), function(i) {
      stepCardServer(paste0("step_", i), steps[[i]], i)
    })
  })
}