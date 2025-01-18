observe_basics <- function() {
  observeEvent(input$exp_date, {
    req(input$exp_date)
    setup$LibPrepDate <- input$exp_date
  })
  
  observeEvent(input$author, {
    req(input$author)
    setup$LibPrepBy <- str_extract(input$author, "(?<=\\()\\w+(?=\\))")
    
    req(setup$LibPrepDate, setup$LibPrepBy)
    setup$file_prefix <- paste0(setup$LibPrepBy, "_", setup$LibPrepDate)
  })
  
  observeEvent(input$assist, {
    req(input$assist)
    setup$LibPrepAssist <- input$assist
  })
  
  observeEvent(input$library_code, {
    req(input$library_code)
    setup$LibraryCode <- input$library_code 
  })
  
  observeEvent(input$flowcell_type, {
    req(input$flowcell_type)
    setup$FlowCellType <- input$flowcell_type 
    req(setup$FlowCellType)
    if (setup$FlowCellType == "Flongle") { 
      setup$pores_needed <- 50 } else if (setup$FlowCellType == "MinION") {
        setup$pores_needed <- 800 
      } else if (setup$FlowCellType == "PromethION") {
        setup$pores_needed <- 5000 
      }
  })
  
  observeEvent(input$flowcell_num, {
    req(input$flowcell_num)
    setup$FlowCellSerial <- input$flowcell_num 
  })
  
  observeEvent(input$minion, {
    req(input$minion)
    setup$SeqDevice <- input$minion 
  })
  
  observeEvent(input$dynamic_done, {
    req(setup$Length)
    if (setup$Length >= 3000) {
      setup$FragBuffer <- "Long Fragment Buffer (LFB)"
    } else {
      setup$FragBuffer <- "Short Fragment Buffer (SFB)"
    }
  })
  
}

setup_workflow_sampleset <- function() {
  observeEvent(input$select_workflow, {
    req(input$select_workflow)
    setup$workflow <- input$select_workflow
    
    req(setup$workflow)
    setup$rxns  <- keep_at(rxns , paste0(setup$workflow)) %>% list_flatten(name_spec = "{inner}")
    setup$steps <- keep_at(steps, paste0(setup$workflow)) %>% list_flatten(name_spec = "{inner}")
    
    if (setup$workflow == "rapid16s") {
      setup$barcodes            <- barcodes.24
      setup$PoolSamples         <- "Yes"
      setup$fragment_type       <- 2
      setup$strands             <- 2
      setup$Length              <- 1500
      setup$InputMassStart      <- 10
      setup$TemplateVolLoading  <- 15
    } else if (setup$workflow == "lsk") {
      setup$PoolSamples         <- "No"
      setup$TemplateVolLoading  <- 12
      setup$TotalPoolVol        <- 100
      setup$beadvol             <- 40
    }
  })
  
  
  observeEvent(input$select_set, {
    req(input$select_set)
    setup$sampleset <- input$select_set
    req(setup$sampleset)
    if (setup$sampleset == "loris") {
      data <- read.table(loris$compilation, sep = "\t", header = TRUE)
    } else if (setup$sampleset == "marmoset") {
      data <- read.table(marmoset$compilation, sep = "\t", header = TRUE)
    } else if (setup$sampleset == "bats") {
      data <- read.table(bats$compilation, sep = "\t", header = TRUE)
    } else if (setup$sampleset == "isolates") {
      data <- read.table(isolates$compilation, sep = "\t", header = TRUE)
    } else if (setup$sampleset == "envir") {
      data <- read.table(envir$compilation, sep = "\t", header = TRUE)
    }
    
    req(data)
    tbl <- data %>% 
      mutate(CollectionDate = as.Date(CollectionDate)) %>%
      select(
        steps_remaining   ,
        ExtractID         ,
        Subject          ,
        Subj_Certainty   ,
        CollectionDate    , 
        ExtractConc      ,  
        ExtractBox       ) %>%
      arrange(CollectionDate, Subject) %>% as_tibble()
    
    req(tbl, samples$compilation)
    samples$compilation <- samples$compilation %>%
      full_join(tbl, keep = FALSE)
  })
  
}

setup_lsk_values <- function() {
  observeEvent(input$strands, {
    req(input$strands)
    setup$strands <- as.numeric(input$strands)
  })
  observeEvent(input$fragments, {
    req(input$fragments)
    setup$fragment_type <- as.numeric(input$fragments)
  })
  
  observeEvent(input$fragment_length, {
    req(input$fragment_length)
    setup$Length  <- as.numeric(input$fragment_length)
  })
  
  observeEvent(input$mass_confirmed, {
    req(input$mass_confirmed)
    setup$InputMassStart  <- as.numeric(input$mass_confirmed)
  })
}


sample_selection <- function() {
  observeEvent(input$add_controls, {
    req(input$add_controls)
    setup$n_controls <- as.numeric(input$add_controls)
  })
  observeEvent(getReactableState("samples", "selected"), {
    selected <- getReactableState("samples", "selected")
    setup$n_extracts <- length(selected)
    
    req(samples$compilation)
    selected_extracts     <- samples$compilation[selected, ]
    
    req(selected_extracts)
    samples$selected  <- selected_extracts %>%
      select(ExtractID   ,
             ExtractConc ,
             ExtractBox  ) %>%
      distinct()
  })
  observeEvent(input$reset_samples, {
    updateReactable("samples", selected = NA)
    
    req(samples$selected)
    samples$selected <- samples$selected %>%
      filter(ExtractID == "")
    
    setup$n_extracts <- 0
    setup$n_controls <- 0
    setup$n_rxns     <- 0
    
    samples$calculations <- samples$calculations %>%
      filter(ExtractID == "")
    
  })
  observeEvent(input$confirm_samples, {
    req(setup$n_controls)
    samples$controls <- samples$controls %>%
      slice(rep(1L, length.out = setup$n_controls))
    
    req(samples$selected, samples$controls)
    working_samples <- samples$selected %>%
      rows_append(samples$controls)
    
    req(working_samples, samples$calculations, setup$LibraryCode)
    samples$calculations <- samples$calculations %>%
      rows_append(working_samples)  %>%
      mutate(LibraryTube = row_number(),
             LibraryCode = setup$LibraryCode) %>%
      mutate(SequenceID  = str_glue("{ExtractID}", "-", "{LibraryCode}", "-", "{LibraryTube}")) %>%
      distinct()
  })
  
  observeEvent(input$samples_done, {
    req(samples$calculations)
    concentrations <- as.list(samples$calculations$ExtractConc) %>%
      set_names(samples$calculations$LibraryTube)
  })
  
}

barcodes_selection <- function() {
  observeEvent(getReactableState("barcodes", "selected"), {
    
    selected <- getReactableState("barcodes", "selected")
    
    req(setup$barcodes)
    selected_columns     <- setup$barcodes[selected, ]
    
    req(selected_columns)
    setup$barcode_wells <- selected_columns %>%
      pivot_longer(
        cols      = !column,
        names_to  = "row",
        values_to = "Barcode"
      ) %>%
      mutate(BarcodePos = paste0(row, column))
  })
  
  observeEvent(getReactableState("barcode_wells", "selected"), {
    selected           <- getReactableState("barcode_wells", "selected")
    
    req(setup$barcode_wells)
    selected_wells     <- setup$barcode_wells[selected, ] %>% distinct()
    
    req(selected_wells)
    setup$barcodes_confirmed <- selected_wells
  })
  
  observeEvent(input$barcode_wells_confirm, {
    req(setup$barcodes_confirmed)
    setup$barcodes_confirmed <- setup$barcodes_confirmed %>%
      select(Barcode,
             BarcodePos) %>%
      mutate(LibraryTube = row_number())
  })
  
}


render_qc_inputs <- function() {
  observeEvent(input$setup_done, {
    req(concentrations)
    output$qc1_inputs <- renderUI({
      tagList(
        layout_column_wrap(
          imap(concentrations, ~ {
            LibraryTube <- .y
            ExtractConc <- .x
            numericInput(
              inputId = paste0("QC1_", LibraryTube),
              label   = paste0("Tube ", LibraryTube),
              min     = 0,
              max     = 1000)
          })
        )
      )
    })
    
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      output$qc2_inputs <- renderUI({
        layout_column_wrap(
          numericInput(
            inputId = "Conc_QC2",
            label   = "Enter QC Result Here",
            min     = 0,
            max     = 1000)
        )
      })
    } else if (setup$workflow == "lsk") {
      output$qc2_inputs <- renderUI({
        tagList(
          layout_column_wrap(
            imap(concentrations, ~ {
              LibraryTube <- .y
              Conc_QC1    <- .x
              numericInput(
                inputId = paste0("QC2_", LibraryTube),
                label   = paste0("Tube ", LibraryTube),
                min     = 0,
                max     = 1000)
            })
          )
        )
      })
      
    }
  })
  
}






