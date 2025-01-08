observe_steps     <- function(input, output, setup, step_data) {
  observe({
    req(setup$steps)
    imap(setup$steps, ~ {
      step_name    <- .y
      step_content <- .x
      main_step    <- step_content[[1]]
      
      observeEvent(input[[paste0("check_", step_name)]], {
        toggleCssClass(
          id        = paste0("step_", step_name), 
          class     = "bg-secondary", 
          condition = input[[paste0("check_", step_name)]])
        
        output[[paste0("stamp_", step_name)]] <- renderText({timestamp("", "")})
        step_data[[step_name]]$detail         <- main_step
        step_data[[step_name]]$note           <- if (!is.null(input[[paste0("text_", step_name)]])) {
          timestamp("Note recorded at ", paste0(": ", input[[paste0("text_", step_name)]]))
        } else { NULL }
        
        step_data[[step_name]]$timestamp      <- timestamp("Completed at ", "")
        
      }, ignoreInit = TRUE, once = TRUE)
      
      observeEvent(input[[paste0("submit_", step_name)]], {
        
        output[[paste0("note_", step_name)]] <- renderText({
          timestamp("Step ", paste0(": ", input[[paste0("text_", step_name)]]))
        })
        
        step_data[[step_name]]$note <- timestamp("Note recorded at ", paste0(": ", input[[paste0("text_", step_name)]]))
        
      }, ignoreInit = FALSE)
      
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

workflow_reactives <- function(input, output, setup, samples) {
  
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
  
  
  observeEvent(input$select_set, {
    req(input$select_set)
    setup$sampleset <- input$select_set
    req(setup$sampleset)
    if (setup$sampleset == "loris") {
      samples$compilation <- samples$compilation %>% full_join(load_data(loris$compilation), keep = FALSE)
    } else if (setup$sampleset == "marmoset") {
      samples$compilation <- samples$compilation %>% full_join(load_data(marmoset$compilation), keep = FALSE)
    } else if (setup$sampleset == "bats") {
      samples$compilation <- samples$compilation %>% full_join(load_data(bats$compilation), keep = FALSE)
    } else if (setup$sampleset == "isolates") {
      samples$compilation <- samples$compilation %>% full_join(load_data(isolates$compilation), keep = FALSE)
    } else if (setup$sampleset == "envir") {
      samples$compilation <- samples$compilation %>% full_join(load_data(envir$compilation), keep = FALSE)
    }
    
    req(samples$compilation)
    output$samples       <- renderReactable({
      reactable(samples$compilation, 
                groupBy             = c("SampleID"),
                columns             = cols_compilation,
                columnGroups        = compilation_groups,
                theme               = format_select,
                selection           = "multiple", 
                onClick             = "select",
                showPageSizeOptions = TRUE, 
                highlight           = TRUE, 
                compact             = TRUE)
    })
  })
  
  
  observeEvent(input$library_code, {
    req(input$library_code)
    setup$LibraryCode <- input$library_code 
  })
  
  observeEvent(input$select_workflow, {
    req(input$select_workflow)
    setup$workflow <- input$select_workflow
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
    
    req(setup$pores_needed, setup$FlowCellType)
    output$flowcell_check <- renderUI({
      value_box(title = paste0("Minimum Pores Needed for ", setup$FlowCellType, " Flow Cell:"),
                value = setup$pores_needed,
                "Optional: Use this value to complete a flow cell check and assess the number of pores available before preparing the library."
      )
    })
    
  })
  
  observeEvent(input$flowcell_num, {
    req(input$flowcell_num)
    setup$FlowCellSerial <- input$flowcell_num 
  })
  
  observeEvent(input$minion, {
    req(input$minion)
    setup$SeqDevice <- input$minion 
  })
  
  observeEvent(input$basics_done, {
    
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      setup$rxns                <- rxns_rap16s
      setup$steps               <- steps_rap16s
      setup$barcodes            <- barcodes.24
      setup$PoolSamples         <- "Yes"
      setup$fragment_type       <- 2
      setup$strands             <- 2
      setup$Length              <- 1500
      setup$InputMassStart      <- 10
      setup$TemplateVolLoading  <- 11
      
      
    } else if (setup$workflow == "lsk") {
      setup$rxns                <- rxns_lsk
      setup$steps               <- steps_lsk
      setup$PoolSamples         <- "No"
      setup$TemplateVolLoading  <- 12
      setup$beadvol             <- 40
    }
    
  })
  
}

samples_reactives <- function(input, output, setup, samples, report_params) {
  
  observeEvent(getReactableState("samples", "selected"), {
    
    selected <- getReactableState("samples", "selected")
    
    req(samples$compilation)
    selected_extracts     <- samples$compilation[selected, ]
    
    req(selected_extracts)
    samples$selected  <- selected_extracts %>%
      select(ExtractID   ,
             ExtractDate ,
             ExtractedBy ,
             ExtractKit  ,
             ExtractBox  ,
             ExtractNotes,
             ExtractConc ) %>%
      distinct()
    
    req(samples$selected)
    setup$n_extracts  <- nrow(samples$selected)
    
    req(input$add_controls)
    setup$n_controls <- as.numeric(input$add_controls)
    
    req(setup$n_extracts, setup$n_controls)
    setup$n_rxns      <- sum(setup$n_controls, setup$n_extracts)
    
    req(setup$n_rxns)
    output$samples_count <- renderText({
      paste0("Total Selected: ", 
             setup$n_extracts, 
             " (+ ", 
             setup$n_controls, 
             " Controls, Total ",
             setup$n_rxns,
             " rxns)")
    })
  })
  
  observeEvent(input$reset_samples, {
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
    
    req(samples$selected, samples$controls, setup$workflow)
    working_samples <- samples$selected %>%
      rows_append(samples$controls) %>%
      mutate(LibraryTube = row_number(),
             workflow    = setup$workflow) %>%
      mutate(SequenceID  = str_glue("{ExtractID}", "-", "{workflow}", "-", "{LibraryTube}")) %>%
      select(LibraryTube,
             SequenceID,
             ExtractID,
             ExtractConc) 
    
    req(working_samples, samples$calculations)
    samples$calculations <- samples$calculations %>%
      rows_append(working_samples) 
    
    output$review_samples <- renderReactable({
      reactable(
        samples$calculations,
        columns             = cols_review,
        highlight           = TRUE
      )
    })
  })
  
  observeEvent(input$samples_done, {
    
    if (setup$workflow == "rapid16s") {
      
      req(setup$n_rxns, setup$rxns$pcr16s, setup$rxns$fcprime, setup$rxns$fcload)
      setup$rxns$pcr16s  <- rxn_vols(setup$rxns$pcr16s , setup$n_rxns)
      setup$rxns$fcprime <- rxn_vols(setup$rxns$fcprime, setup$n_rxns)
      setup$rxns$fcload  <- rxn_vols(setup$rxns$fcload , setup$n_rxns)
      output$barcode_header <- renderText({
        paste0("Select enough 8-well columns to reach ", setup$n_rxns, " barcodes:")
      })
      output$barcode_header_2 <- renderText({
        paste0("Confirm individual barcodes to use (", setup$n_rxns, " barcodes needed)")
      })
      
      
      
      req(setup$rxns$pcr16s)
      setup$TemplateVolPrep <- setup$rxns$pcr16s  %>% 
        filter(Reagent == "DNA Template") %>% 
        pull(Volume_rxn)
      
      pcr_16s.tbl  <- setup$rxns$pcr16s    %>% mutate(step = "Barcoding/16S PCR")
      fcload.tbl   <- setup$rxns$fcprime   %>% mutate(step = "Flow Cell Loading")
      fcprime.tbl  <- setup$rxns$fcload    %>% mutate(step = "Flow Cell Priming")
      
      req(pcr_16s.tbl, fcload.tbl, fcprime.tbl, setup$n_rxns)
      combined_tbl <- bind_rows(pcr_16s.tbl, fcload.tbl, fcprime.tbl) %>%  mutate(N = setup$n_rxns)
      
      req(combined_tbl)
      report_params$rxns <- combined_tbl
      
        req(setup$barcodes)
        output$barcodes           <- renderReactable({
          reactable(
            setup$barcodes,
            columns             = cols_barcodes,
            columnGroups        = groups_barcodes,
            theme               = format_select,
            selection           = "multiple", 
            onClick             = "select"
          )
      })
      
      
      
    } else if (setup$workflow == "lsk") {
      req(samples$calculations)
      setup$barcodes_confirmed <- samples$calculations %>%
        select(LibraryTube) %>%
        mutate(Barcode    = "None",
               BarcodePos = "None")
      
      req(setup$n_rxns, setup$rxns$endprep, setup$rxns$adapter, setup$rxns$fcprime, setup$rxns$fcload)
      setup$rxns$endprep <- rxn_vols(setup$rxns$endprep, setup$n_rxns)
      setup$rxns$adapter <- rxn_vols(setup$rxns$adapter, setup$n_rxns)
      setup$rxns$fcprime <- rxn_vols(setup$rxns$fcprime, setup$n_rxns)
      setup$rxns$fcload  <- rxn_vols(setup$rxns$fcload , setup$n_rxns)
      
      req(setup$rxns$endprep)
      setup$TemplateVolPrep <- setup$rxns$endprep  %>% 
        filter(Reagent == "DNA Template") %>% 
        pull(Volume_rxn)
      
      endprep.tbl <- setup$rxns$endprep  %>% mutate(step = "DNA Repair and Endprep")
      adapter.tbl <- setup$rxns$adapter  %>% mutate(step = "Adapter Ligation")
      fcload.tbl  <- setup$rxns$fc_load  %>% mutate(step = "Flow Cell Loading")
      fcprime.tbl <- setup$rxns$fc_prime %>% mutate(step = "Flow Cell Priming")
      combined_tbl <- bind_rows(endprep.tbl, adapter.tbl, fcload.tbl, fcprime.tbl) %>%  mutate(N = setup$n_rxns)
      
      req(combined_tbl)
      report_params$rxns <- combined_tbl
      
    }
    
  })
  
  
}

barcode_reactives <- function(input, output, setup, samples) {
  
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      
      
      req(setup$barcodes)
      observeEvent(getReactableState("barcodes", "selected"), {
        
        selected <- getReactableState("barcodes", "selected")
        
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
      
      observeEvent(input$barcode_cols_confirm, {
        nav_select("barcode_tabs", "barcode_wells")
        
        req(setup$barcode_wells)
        output$barcode_wells  <- renderReactable({
          reactable(
            setup$barcode_wells,
            columns            = cols_barcode_wells,
            theme               = format_select,
            selection           = "multiple", 
            onClick             = "select")
        })  
      })
      
      req(setup$barcode_wells)
      observeEvent(getReactableState("barcode_wells", "selected"), {
        selected           <- getReactableState("barcode_wells", "selected")
        selected_wells     <- setup$barcode_wells[selected, ] %>% distinct()
        
        req(selected_wells, setup$n_rxns)
        output$barcode_footer <- renderText({
          paste0(length(selected), 
                 " barcodes selected out of ", 
                 setup$n_rxns, 
                 " needed")
        })
        
        
        req(selected_wells)
        setup$barcodes_confirmed <- selected_wells
        
        })
        
      
      observeEvent(input$barcode_wells_confirm, {
        req(setup$barcodes_confirmed)
        setup$barcodes_confirmed <- setup$barcodes_confirmed %>%
          select(Barcode,
                 BarcodePos) %>%
          mutate(LibraryTube = row_number())
        
        req(setup$barcodes_confirmed$LibraryTube)
        output$barcodes_confirmed <- renderReactable({
          reactable(
            setup$barcodes_confirmed,
            columns = cols_barcodes_confirmed)
        
        })
        
        accordion_panel_open("barcodes_selected", "barcodes_confirmed")
      })
      
    }
    
  })
  
  
}


lsk_input_reactives <- function(input, output, setup) {
  observe({
    req(setup$workflow)
  if (setup$workflow == "lsk") {
    observeEvent(input$strands, {
      req(input$strands)
      setup$strands <- as.numeric(input$strands)
    })
    observeEvent(input$fragments, {
      req(input$fragments)
      setup$fragment_type <- as.numeric(input$fragments)
    })
    observeEvent(input$submit, {
      req(setup$fragment_type)
      setup$Length         <- calculate_length(setup$fragment_type)
      req(setup$Length)
      output$adjust_length <- renderUI({
        sliderInput(
          "fragment_length", 
          "Adjust Length (bp) if needed", 
          min   = 100, 
          max   = 20000, 
          value = setup$Length)
      })
      
      req(setup$fragment_type, setup$strands)
      setup$InputMassStart <- calculate_mass_start(setup$fragment_type, setup$Length, setup$strands)
    
      req(setup$InputMassStart)
      output$adjust_input <- renderUI({
        req(setup$InputMassStart)
        numericInput(
          "mass_confirmed", 
          "Adjust input mass (ng)", 
          value = setup$InputMassStart,  
          min   = 1, 
          max   = 2000)
      })
      
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
  })
  
}

setup_reactives <- function(input, output, setup, samples) {
  observeEvent(input$dynamic_done, {

    req(setup$fragment_type, setup$Length, setup$strands)
    setup$InputMassFinal      <- calculate_mass_final(setup$fragment_type, setup$Length, setup$strands)
    
    req(setup$barcodes_confirmed,
        setup$TemplateVolLoading,
        setup$Length,  
        setup$InputMassStart,
        setup$InputMassFinal,
        setup$TemplateVolPrep)
    samples$calculations <- samples$calculations %>%
      select(-c("Barcode", "BarcodePos")) %>%
      left_join(setup$barcodes_confirmed, by = join_by(LibraryTube))  %>%
      mutate(TemplateVolLoading  = setup$TemplateVolLoading,
             Length              = setup$Length,  
             InputMassStart      = setup$InputMassStart,
             InputMassFinal      = setup$InputMassFinal,
             TemplateVolPrep     = setup$TemplateVolPrep
      ) %>%
      mutate(ExtractInputVol    = if_else((InputMassStart/ExtractConc) >= TemplateVolPrep, TemplateVolPrep, InputMassStart/ExtractConc)) %>%
      mutate(ExtractDiluteWater = TemplateVolPrep - ExtractInputVol)
    
    req(samples$calculations)
    output$setup_summary <- renderReactable({
      reactable(
        samples$calculations,
        columns             = cols_setup,
        highlight           = TRUE
      )
    })
  })
  
  observeEvent(input$submit_start_note, {
    req(input$start_note)
    setup$setup_note <- timestamp("Setup note recorded at ", paste0(input$start_note))
    req(setup$setup_note)
    output$start_note_submitted <- renderText({ setup$setup_note })
  })
  
  observeEvent(input$setup_done, {
    
    
    req(samples$calculations)
    output$qc1_result <- renderUI({
      fluidRow(
        pmap(samples$calculations %>% select(LibraryTube, ExtractConc), QC1_input()),
        actionButton("confirm_qc1", "Confirm QC1 Values"))
    })
    
    output$extract_prep  <- renderReactable({
      reactable(
        samples$calculations,
        columns       = cols_extract_prep,
        theme         = format_checklist,
        selection     = "multiple", 
        onClick       = "select")
    })
    
    req(samples$calculations$LibraryTube)
    output$checklist_tubes <- renderUI({
      tagList(
        checkboxGroupInput(
          inputId = "add_rxnmix",
          label   = "Check when Reaction Mix Added to Tube",
          choices = c(samples$calculations$LibraryTube),
          inline  = TRUE,
          width   = "100%"),
        checkboxGroupInput(
          inputId = "add_template",
          label   = "Check when Template Added to Tube",
          choices = c(samples$calculations$LibraryTube),
          inline  = TRUE,
          width   = "100%"))
    })
    
    
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      output$part1_rap16s       <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part1_rap16s,
          theme         = format_checklist
        )
      })
      
      
      req(setup$rxns$pcr16s)
      output$pcr_react          <- renderReactable({
        reactable(
          setup$rxns$pcr16s,
          columns             = cols_rxns,
          theme               = format_checklist,
          selection           = "multiple", 
          onClick             = "select"
        )
      })
      
    } else if(setup$workflow == "lsk") {
      
      output$part1_lsk          <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part1_lsk
        )
      })
      req(setup$rxns$endprep)
      output$endprep_react      <- renderReactable({
        reactable(
          setup$rxns$endprep,
          columns             = cols_rxns,
          theme               = format_checklist,
          selection           = "multiple", 
          onClick             = "select"
        )
      })
      req(setup$rxns$adapter)
      output$adapter_react      <- renderReactable({
        reactable(
          setup$rxns$adapter,
          columns             = cols_rxns,
          theme               = format_checklist,
          selection           = "multiple", 
          onClick             = "select"
        )
      })
    }
  })
}

part1_reactives <- function(input, output, setup, samples) {
  
  observeEvent(input$confirm_qc1, {
    
    req(samples$calculations)  
    samples$calculations <- samples$calculations %>%
      mutate(Conc_QC1 = map_dbl(LibraryTube, ~ input[[paste0("QC1_", .x)]] %||% NA_real_))
    
    req(setup$workflow)
    if (setup$workflow == "rapid16s") { 
      
      req(samples$calculations$Conc_QC1)
      pooling_result <- pooling_calculations(samples$calculations$Conc_QC1)
      
      req(pooling_result$TotalPoolVol)
      setup$beadvol  <- 0.6*(pooling_result$TotalPoolVol)
      
      req(setup$beadvol)
      output$beadvol <- renderText({
        paste(setup$beadvol)
      })
      
      req(pooling_result$SampVolPool, setup$beadvol)
      samples$calculations <- samples$calculations %>%
        mutate(SampVolPool  = pooling_result$SampVolPool,
               TotalPoolVol = pooling_result$TotalPoolVol,
               BeadVol      = setup$beadvol)
      
      req(samples$calculations)
      output$pooling_ratios     <- renderReactable({
        reactable(
          samples$calculations,
          columns             = cols_pooling,
          theme               = format_checklist,
          selection           = "multiple", 
          onClick             = "select")
      })
      
      output$qc2_result <- renderUI({
        fluidRow(
          numericInput(
            inputId = "qc2",
            label   = "Concentration for Pooled Library",
            value   = 0,
            min     = 0,
            max     = 1000),
          actionButton("confirm_qc2", "Confirm QC2 Value"))
      })

    } else if (setup$workflow == "lsk") {
      req(samples$calculations, setup$LibraryLoadingVol, setup$beadvol)  
      samples$calculations <- samples$calculations %>%
        mutate(TotalPoolVol = setup$LibraryLoadingVol,
               SampVolPool  = setup$LibraryLoadingVol,
               BeadVol      = setup$beadvol)
      
      output$qc2_result <- renderUI({
        req(samples$calculations$LibraryTube, samples$calculations$Conc_QC1)
        fluidRow(
          pmap(samples$calculations %>% select(LibraryTube, Conc_QC1), QC2_input()),
          actionButton("confirm_qc2", "Confirm QC2 Values"))
      })
      
    }
  })
  
  observeEvent(input$part1_done, {
    req(setup$workflow)
    if (setup$workflow == "rapid16s") { 
      
      req(samples$calculations)
      output$part1_rap16s       <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part1_rap16s,
          theme         = format_checklist
        )
      })
      
    } else if (setup$workflow == "lsk") {
      
      req(samples$calculations)
      output$part2_rap16s       <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part2_rap16s
        )
      })
    }
    
  })
  
  
}

part2_reactives <- function(input, output, setup, samples) {

  
  observeEvent(input$confirm_qc2, {
    
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      req(input$qc2)
      setup$Conc_QC2          <- as.numeric(input$qc2)
      
      req(setup$Conc_QC2, setup$TemplateVolLoading, setup$InputMassFinal)
      setup$LibraryLoadingVol <- if_else(
        (setup$InputMassFinal/setup$Conc_QC2) >= setup$TemplateVolLoading, setup$TemplateVolLoading,
        (setup$InputMassFinal/setup$Conc_QC2)
      )
      
      req(setup$LibraryLoadingVol)
      setup$LibraryWaterVol <- setup$TemplateVolLoading - setup$LibraryLoadingVol
      
      req(setup$LibraryWaterVol)
      observeEvent(input$confirm_qc2, {
        output$loading_vol <- renderUI({
          req(setup$LibraryLoadingVol, setup$LibraryWaterVol)
          value_box(
            title = paste0("To reach total volume of 11 ", ul),
            value = paste0(setup$LibraryLoadingVol, ul, " Eluate + ", setup$LibraryWaterVol, ul, " Elution Buffer")
          )
        })
      })
      
      
      samples$calculations <- samples$calculations %>%
        mutate(Conc_QC2          = setup$Conc_QC2,
               LibraryLoadingVol = setup$LibraryLoadingVol,
               LibraryWaterVol   = setup$LibraryWaterVol)
      
      
    } else if (setup$workflow == "lsk") {
      
      samples$calculations <- samples$calculations %>%
        mutate(Conc_QC2 = map_dbl(LibraryTube, ~ input[[paste0("QC2_", .x)]] %||% NA_real_))    
      req(samples$calculations$Conc_QC2)
      samples$calculations <- samples$calculations %>%
        mutate(LibraryLoadingVol = if_else(
          (InputMassFinal / Conc_QC2) >= TemplateVolLoading, TemplateVolLoading,
          (InputMassFinal / Conc_QC2))) %>%
        mutate(LibraryWaterVol = TemplateVolLoading - LibraryLoadingVol)
    }

    
  })
  
  observeEvent(input$part2_done, {    
    req(samples$calculations)
    output$part3      <- renderReactable({
      reactable(
        samples$calculations,
        columns       = cols_part3
      )
    })
    req(setup$rxns$fcprime)
    output$fcprime_react <- renderReactable({
      reactable(
        setup$rxns$fcprime,
        columns             = cols_rxns,
        theme               = format_checklist,
        selection           = "multiple", 
        onClick             = "select"
      )
    })
    req(setup$rxns$fcload)
    output$fcload_react  <- renderReactable({
      reactable(
        setup$rxns$fcload,
        columns             = cols_rxns,
        theme               = format_checklist,
        selection           = "multiple", 
        onClick             = "select"
      )
    })
    
  })
  
  
}

conclude_reactives <- function(input, output, setup, samples, report_params, step_data) {
  
  observeEvent(input$end_note, {
    req(input$end_note)
    setup$conclusion_note <- timestamp("Concluding note recorded at ", paste0(input$end_note))
    req(setup$conclusion_note)
    output$end_note_render <- renderText({ setup$conclusion_note })
  })
  
  observeEvent(input$generate_report, {
    
    isolate({
      report_params$setup         <- reactiveValuesToList(setup)
      report_params$steps         <- reactiveValuesToList(setup$steps)
      report_params$step_data     <- step_data
      report_params$selected      <- samples$selected
      report_params$params        <- samples$params
      report_params$calculations  <- samples$calculations
    })
    
    output$step_progress <- renderUI({
      req(report_params$step_data)
      steps <- isolate(reactiveValuesToList(report_params$step_data))
      tagList(
        if (!is.null(report_params$setup$setup_note)) tags$blockquote(report_params$setup$setup_note),
        tags$ol(
          lapply(steps, function(step) {
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
    
    
    output$download_report <- downloadHandler(
      filename = function() {
        req(setup$file_prefix)
        paste0("notebook_", setup$file_prefix, ".html")
      },
      content = function(file) {
        tempReport <- file.path(tempdir()    , "report.Rmd")
        template   <- path$report_template
        
        file.copy(template, tempReport, overwrite = TRUE)
        
        req(report_params)
        params <- isolate(reactiveValuesToList(report_params))
        
        rmarkdown::render(
          input       = tempReport, 
          output_file = file,
          params      = params,
          envir       = new.env(parent = globalenv())
        )
      })
    
    output$download_tsv <- downloadHandler(
      filename = function() {
        req(report_params$sampleset)
        subject <- isolate(report_params$sampleset)
        req(setup$file_prefix)
        paste0("libraries_", subject, "_updated_", setup$file_prefix, ".tsv")
      },
      content  = function(file) { 
        req(report_params$libprep)
        library_prep <- isolate(report_params$libprep) 
        
        write.csv(library_prep, file, row.names = FALSE)
      }
    )
    
  })
  
  
  
}