# /LibraryPrep/server/render_reactables.R

render_selection_tables <- function(input, output, samples, setup) {
  observeEvent(input$basics_done, {
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
  
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      
      observeEvent(input$samples_done, {
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
      })
      
      req(setup$barcode_wells)
      output$barcode_wells  <- renderReactable({
        reactable(
          setup$barcode_wells,
          columns            = cols_barcode_wells,
          theme               = format_select,
          selection           = "multiple", 
          onClick             = "select")
      })   
      
      req(setup$barcodes_confirmed)
      output$barcodes_confirmed <- renderReactable({
        reactable(
          setup$barcodes_confirmed,
          columns = cols_barcodes_confirmed)
      })
    }
   })
 }



render_summary_tables <- function(input, output, samples, setup) {
  
  observeEvent(input$confirm_samples, {
    req(samples$calculations)
    output$review_samples <- renderReactable({
      reactable(
        samples$calculations,
        columns             = cols_review,
        highlight           = TRUE
      )
    })
    
  })
  
  observe({
    req(samples$calculations)
    output$setup_summary <- renderReactable({
      reactable(
        samples$calculations,
        columns             = cols_setup
      )
    })
  })
  
  observe({
    req(samples$calculations)
    output$extract_prep <- renderReactable({
      reactable(
        samples$calculations,
        columns             = cols_extract_prep,
        theme               = format_checklist
      )
    })
    
    req(samples$calculations)
    output$part3      <- renderReactable({
      reactable(
        samples$calculations,
        columns       = cols_part3
      )
    })
  })
  
  
  observe({
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
      req(samples$calculations)
      output$part2_rap16s       <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part2_rap16s
        )
      })
      
    } else if(setup$workflow == "lsk") {
      
      req(samples$calculations)
      output$part1_lsk          <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part1_lsk
        )
      })
      req(samples$calculations)
      output$part2_lsk          <- renderReactable({
        reactable(
          samples$calculations,
          columns       = cols_part2_lsk
        )
      })
    }
  })
}

render_reaction_tables <- function(input, output, samples, setup) {
  observe({
    req(samples$calculations)
    output$extract_prep  <- renderReactable({
      reactable(
        samples$calculations,
        columns       = cols_extract_prep,
        theme         = format_checklist,
        selection     = "multiple", 
        onClick       = "select")
    })
    
  })
  observe({
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
    
  })
  
  observe({
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
 
   observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      
      req(samples$calculations)
      output$pooling_ratios     <- renderReactable({
        reactable(
          samples$calculations,
          columns             = cols_pooling,
          theme               = format_checklist,
          selection           = "multiple", 
          onClick             = "select")
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


