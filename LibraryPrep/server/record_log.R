observe_steps <- function(input, output, setup, step_data) {
  observe({
    req(setup$steps, setup$workflow)  # Ensure `setup$steps` and `setup$workflow` are available
    
    # Loop through each step in `setup$steps` and create observers for it
    imap(setup$steps, ~ {
      step_name    <- .y  # Step name
      step_content <- .x  # Step details
      main_step    <- step_content[[1]]  # Main step description
      
      # Initialize `step_data` if not already set
      if (is.null(step_data[[step_name]])) {
        step_data[[step_name]] <- reactiveValues(
          detail    = main_step,
          note      = NULL,
          timestamp = "Not completed"
        )
      }
      
      # Observer for checking a step
      observeEvent(input[[paste0("check_", step_name)]], {
        req(input[[paste0("check_", step_name)]])  # Ensure checkbox input is available
        toggleCssClass(
          id        = paste0("step_", step_name), 
          class     = "bg-secondary", 
          condition = input[[paste0("check_", step_name)]]
        )
        
        timestamp <- timestamp("Completed at ", "")
        output[[paste0("stamp_", step_name)]] <- renderText({ timestamp })
        
        step_data[[step_name]]$timestamp <- timestamp
      }, ignoreInit = TRUE)
      
      # Observer for submitting a note
      observeEvent(input[[paste0("submit_", step_name)]], {
        note_text <- input[[paste0("text_", step_name)]] %||% "No note provided"
        timestamp <- timestamp("Note recorded at ", "")
        
        output[[paste0("note_", step_name)]] <- renderText({
          paste0(timestamp, ": ", note_text)
        })
        
        step_data[[step_name]]$note <- paste0(timestamp, ": ", note_text)
      }, ignoreInit = FALSE)
      
      # Ensure step data is correctly populated during report generation
      observeEvent(input$generate_report, {
        req(step_data[[step_name]])
        
        if (is.null(input[[paste0("check_", step_name)]])) {
          step_data[[step_name]]$detail      <- main_step
          step_data[[step_name]]$note        <- NULL
          step_data[[step_name]]$timestamp   <- "Not completed"
        }
      })
    })
  })
}

record_notes <- function() {
  observeEvent(input$submit_start_note, {
    req(input$start_note)
    setup$setup_note <- timestamp("Setup note recorded at ", paste0(input$start_note))
  })
  
}

record_tables <- function() {
  observeEvent(input$samples_done, {
    req(setup$rxns)
    report_params$rxns <- list_rbind(reactiveValuestoList(setup$rxns), names_to = "step")
  })
  
}