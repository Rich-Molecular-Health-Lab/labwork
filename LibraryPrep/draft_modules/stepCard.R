
stepCardUI <- function(id, step_data) {
  ns <- NS(id)
  
  tagList(
    card(
      card_header(h4(step_data$name)),
      if (!is.null(step_data$process)) tags$p(tags$em(step_data$process)),
      if (!is.null(step_data$stop_opt)) tags$p(tags$strong("Stop Option:"), step_data$stop_opt),
      if (!is.null(step_data$kits)) {
        tags$div(
          tags$strong("Kits:"),
          tags$ul(lapply(step_data$kits, tags$li))
        )
      },
      if (!is.null(step_data$expansion)) {
        tags$div(
          tags$strong("Expansions:"),
          tags$ul(lapply(step_data$expansion, tags$li))
        )
      }
    )
  )
}

stepCardServer <- function(id, step_data) {
  moduleServer(
    id, 
    function(input, output, session) {
    
  })
}