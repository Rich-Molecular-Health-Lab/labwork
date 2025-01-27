firstModuleUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("input_type"), "Select Input Category:", 
                choices = names(libprep$inputs), 
                selected = NULL),
    uiOutput(ns("protocol_selector")),  # Dynamically populated based on input type
    selectInput(ns("sampleset"), "Select Sample Set:", 
                choices  = samplesets, 
                selected = NULL),  # Populate dynamically
    actionButton(ns("confirm_selection"), "Confirm Selection"),
    numericInput(ns("controls"), "N Controls to Include"),
    reactableOutput(ns("samples"), "Select Samples to Include"),
    textOutput(ns("n_controls")),
    textOutput(ns("n_samples")),
    textOutput(ns("n_rxns")),
    actionButton(ns("confirm_samples"), "Confirm Samples and Controls")
  )
}

firstModuleServer <- function(id, state, sampleset_dir) {
  moduleServer(id, function(input, output, session) {
    # Dynamically populate the protocols based on input type
    observeEvent(input$input_type, {
      req(input$input_type)
      protocols <- libprep$inputs[[input$input_type]]$protocols
      output$protocol_selector <- renderUI({
        selectInput(
          session$ns("protocol"),
          "Select Protocol:",
          choices = setNames(names(protocols), sapply(protocols, function(p) p$name))
        )
      })
    })
    
    
    # Dynamically populate samplesets from the config package
    observe({
      sample_set_files <- config::get("samplesets")  # Get sampleset paths from the config
      updateSelectInput(session, "sampleset", choices = names(sample_set_files))
    })
    
    # Handle the selection of the sampleset
    observeEvent(input$confirm_selection, {
      req(input$input_type, input$protocol, input$sampleset)
      state$input_type <- input$input_type
      state$protocol   <- input$protocol
      state$sampleset  <- input$sampleset
      
      # Pre-fill protocol values for kits, expansions, extras
      protocol        <- libprep$protocols[[input$protocol]]
      state$kit       <- protocol$kit
      state$expansion <- protocol$expansion
      state$extras    <- protocol$extras
      
      req(state$sampleset)
      sample_set_files <- config::get("samplesets")
      file_path <- sample_set_files[[state$sampleset]]
      req(file_path)
      
      # Load and process the sampleset
      data <- read.table(file_path, sep = "\t", header = TRUE) %>%
        mutate(CollectionDate = as.Date(CollectionDate)) %>%
        select(
          steps_remaining,
          ExtractID,
          Subject,
          Subj_Certainty,
          CollectionDate, 
          ExtractConc,  
          ExtractBox
        ) %>%
        arrange(CollectionDate, Subject) %>%
        as_tibble()
      
      # Save the processed data in the state
      state$samples <- data
      
      output$samples <- renderReactable({
        reactable(
          data,
          selection = "multiple",
          searchable = TRUE
        )
      })
      
      # Save the selected rows into the state
      observe({
        selected_rows <- reactable::getReactableState(session$ns("samples_table"), "selected")
        if (!is.null(selected_rows)) {
          state$samples_working <- state$samples[selected_rows, ]
        }
      })
    
    # Save the selections to the state
    observeEvent(input$confirm_samples, {
      req(state$samples, state$samples_working)
      
      
      # Notify user of successful selection
      showModal(modalDialog(
        title = "Selection Confirmed",
        paste(
          "Input:", libprep$inputs[[state$input_type]]$name, "<br>",
          "Protocol:", protocol$name, "<br>",
          "Sample Set:", state$sampleset, "<br>",
          "Samples Selected:", nrow(state$samples_working)
        ),
        footer = modalButton("OK")
      ))
      })
    })
  })
}