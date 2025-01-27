# sampleset.R

samplesetInput <- function(id, filter = NULL) {
  samplesets <- ls("compilation")
  if (!is.null(filter)) {
    samples       <- lapply(samplesets, get, "compilation")
    samplesets <- samplesets[vapply(samples, filter, logical(1))]
  }
  selectizeInput(NS(id, "sampleset"), "Select a set of samples", choices = samplesets)
}

samplesetServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    reactive(get(input$sampleset, "compilation"))
  })
}

samplesetApp <- function(filter = NULL) {
  ui <- fluidPage(
    samplesetInput("sampleset", filter = filter),
    reactableOutput("samples")
  )
  server <- function(input, output, session) {
    samples <- samplesetServer("sampleset")
    output$samples <- renderReactable(reactable())
  }
  shinyApp(ui, server)
}