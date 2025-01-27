
observe_steps <- function(input, output, setup) {
  observe({
    req(setup$steps)
    
    # Loop through steps and assign UI-related observers
    imap(setup$steps, ~ {
      name        <- .y
      card_id     <- paste0("step_", name)
      check_id    <- paste0("check_", name)
      header_id   <- paste0("stamp_", name)
      note_input  <- paste0("text_", name)
      note_button <- paste0("submit_", name)
      note_output <- paste0("note_", name)
      
      # Handle checkbox interactions
      observeEvent(input[[check_id]], {
        toggleCssClass(id = card_id, class = "bg-secondary", condition = input[[check_id]])
        output[[header_id]] <- renderText({ paste("Completed at", Sys.time()) })
      }, ignoreInit = TRUE)
      
      # Handle note interactions
      observeEvent(input[[note_button]], {
        req(input[[note_input]])
        notestamp <- paste("Note recorded at", Sys.time(), ":")
        output[[note_output]] <- renderText({ paste(notestamp, input[[note_input]]) })
      }, ignoreInit = FALSE)
    })
  })
}

record_steps <- function(input, output, setup) {
  observeEvent(input$basics_done, {
    req(setup$steps)
    
    # Create `steps_record` from `steps`
    setup$steps_record <- isolate({
      imodify(setup$steps, ~ {
        list(
          detail    = .x[[1]],
          substeps  = .x[-1],
          timestamp = NULL,
          note      = NULL
        )
      })
    })
  })
  
  # Monitor `steps_record` for interactions
  observe({
    req(setup$steps_record)
    
    # Iterate through `steps_record`
    imap(setup$steps_record, ~ {
      name <- .y
      
      # Generate dynamic input IDs
      check_id       <- paste0("check_" , name)
      note_input_id  <- paste0("text_"  , name)
      note_button_id <- paste0("submit_", name)
      
      # Monitor checkbox input
      observeEvent(input[[check_id]], {
        isolate({
          setup$steps_record[[name]]$timestamp <- paste("Completed at", Sys.time())
        })
      })
      
      # Monitor note submission
      observeEvent(input[[note_button_id]], {
        req(input[[note_input_id]])
        isolate({
          note_text <- paste("Note recorded at", Sys.time(), ":", input[[note_input_id]])
          if (is.null(setup$steps_record[[name]]$note)) {
            setup$steps_record[[name]]$note <- note_text
          } else {
            setup$steps_record[[name]]$note <- paste(setup$steps_record[[name]]$note, note_text, sep = "; ")
          }
        })
      })
      
      # Handle final updates when `part3_done` is triggered
      observeEvent(input$part3_done, {
        isolate({
          if (is.null(input[[check_id]])) {
            setup$steps_record[[name]]$timestamp <- "Step not done."
          }
          if (is.null(input[[note_button_id]])) {
            setup$steps_record[[name]]$note <- "No notes."
          }
        })
      })
    })
  })
}

record_notes <- function(input, output, setup) {
  observeEvent(input$submit_start_note, {
    req(input$start_note)
    notestamp        <- timestamp("Setup note recorded at ", ": ")
    if (is.null(setup$setup_note)) {
      setup$setup_note <- paste0(notestamp, isolate(input$start_note))
    } else {
      setup$setup_note <- paste0(isolate(setup$setup_note), "; ", notestamp, isolate(input$start_note))
    }
  })
  
  observeEvent(input$end_note, {
    req(input$end_note)
    notestamp        <- timestamp("Concluding note recorded at ", ": ")
    if (is.null(setup$conclusion_note)) {
      setup$conclusion_note <- paste0(notestamp, isolate(input$end_note))
    } else {
      setup$conclusion_note <- paste0(isolate(setup$conclusion_note), "; ", notestamp, isolate(input$end_note))
    }
  })
}

record_tables <- function(input, setup, samples, report_params) {
  observeEvent(input$samples_done, {
    req(setup$rxns)
    report_params$rxns <- list_rbind(setup$rxns, names_to = "step")
  })
  
  observeEvent(input$part3_done, {
    report_params$calculations <- isolate(samples$calculations)
  })
  
}


compile_report <- function(input, output, report_params, setup) {
  observeEvent(input$part3_done, {
    report_params$steps <- reactiveValuesToList(setup$steps_record)
  })
  
  observeEvent(input$generate_report, {
    setup$setup_note <- if (is.null(isolate(setup$setup_note))) {
      "No setup notes."
    }
    setup$conclusion_note <- if (is.null(isolate(setup$conclusion_note))) {
      "No conclusion notes."
    }
    req(setup$setup_note, setup$conclusion_note)
    report_params$notes <- list(setup      = isolate(setup$setup_note),
                                conclusion = isolate(setup$conclusion_note))
    report_params$setup <- reactiveValuesToList(setup) %>%
      keep_at(
      c("workflow",
        "sampleset",
        "LibPrepDate",
        "LibraryCode",
        "LibPrepBy",
        "LibPrepAssist",     
        "FlowCellType",      
        "FragBuffer",        
        "FlowCellSerial",    
        "SeqDevice",         
        "fragment_type",     
        "strands",
        "PoolSamples")
      )
    
    req(report_params$steps, report_params$setup)
    output$step_report <- renderUI({
      tagList(
        if (!is.null(report_params$setup$setup_note)) tags$blockquote(isolate(report_params$setup$setup_note)),
        tags$ol(
          lapply(isolate(report_params$steps), function(step) {
            tagList(
              tags$li(step$detail),
              tags$p(step$timestamp),
              if (!is.null(step$note)) tags$blockquote(step$note),
              tags$hr()
            )
          })
        ),
        if (!is.null(report_params$setup$conclusion_note)) tags$blockquote(report_params$setup$conclusion_note),
      )
    })
    req(setup$file_prefix, setup$workflow, setup$sampleset)
    basename <- paste(setup$file_prefix, 
                      setup$workflow, 
                      setup$sampleset,
                      sep = "_")
    output$download_report <- downloadHandler(
      filename = function() {
        paste0(basename, ".html")
      },
      content = function(file) {
        tempReport <- file.path(tempdir(), "report.Rmd")
        template   <- "../templates/notebook_report.Rmd"
        file.copy(template, tempReport, overwrite = TRUE)
       
        rmarkdown::render(
          input       = tempReport, 
          output_file = file,
          params      = isolate(reactiveValuesToList(report_params)),
          envir       = new.env(parent = globalenv())
        ) 
      }
    )
    req(report_params$setup, report_params$calculations)
    compilation_output <- as_tibble(isolate(report_params$setup)) %>%
      right_join(report_params$calculations)
    
    output$dowload_tsv <- downloadHandler(
      filename = function() {
        paste0(basename, ".tsv")
      },
      content = function(file) {
        write.table(compilation_output, row.names = F, sep = "\t")
      }
      
    )
    
  })
}