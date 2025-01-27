samples_tab <- function() {
  nav_panel(
    "Select Samples",
    value = "samples",
    sampleSelectionUI("sample_selection"),
    actionButton("samples_done", "Click to Proceed")
  )
}

sampleSelectionUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("sampleset_select"), "Select Sample Set:", choices = NULL),
    reactableOutput(ns("samples")),
    actionButton(ns("confirm_samples"), "Confirm Selection")
  )
}

sampleSelectionServer <- function(id, sampleset_dir, state) {
  moduleServer(id, function(input, output, session) {
    samples <- reactiveVal(NULL)
    
    observe({
      updateSelectInput(session, "sampleset_select",
                        choices = list.files(sampleset_dir, pattern = "\\.tsv$", full.names = FALSE))
    })
    
    observeEvent(input$sampleset_select, {
      req(input$sampleset_select)
      file_path <- file.path(sampleset_dir, input$sampleset_select)
      samples(readr::read_tsv(file_path))
    })
    
    output$samples <- renderReactable({
      req(samples())
      reactable(samples(), selection = "multiple")
    })
    
    observeEvent(input$confirm_samples, {
      state$samples <- samples()[reactable::getReactableState("samples", "selected"), ]
      showModal(modalDialog("Samples confirmed!"))
    })
  })
}