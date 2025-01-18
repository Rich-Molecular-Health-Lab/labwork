render_reactables <- function() {
  observeEvent(input$basics_done, {
    output$samples       <- renderReactable({
      reactable(isolate(samples$compilation), 
                height              = 600,
                sortable            = TRUE,
                filterable          = TRUE,
                columns             = samples_select,
                theme               = format_select,
                selection           = "multiple", 
                onClick             = "select",
                showPageSizeOptions = TRUE, 
                highlight           = TRUE, 
                compact             = TRUE)
    })
  })
  
  observeEvent(input$confirm_samples, {
    output$selected      <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height              = 400,
        columns             = cols_selected,
        highlight           = TRUE
      )
    })
  })
  
  observeEvent(input$samples_done, {
    output$barcodes           <- renderReactable({
      reactable(
        isolate(setup$barcodes),
        columns             = cols_barcodes,
        columnGroups        = groups_barcodes,
        theme               = format_select,
        selection           = "multiple", 
        onClick             = "select", 
        highlight           = TRUE
      )
    })
    
  })
  
  observeEvent(input$barcode_cols_confirm, {
    output$barcode_wells  <- renderReactable({
      reactable(
        isolate(setup$barcode_wells),
        columns             = cols_barcode_wells,
        theme               = format_select,
        selection           = "multiple", 
        onClick             = "select", 
        highlight           = TRUE)
    })  
  })
  
  observeEvent(input$barcode_wells_confirm, {
    output$barcodes_confirmed <- renderReactable({
      reactable(
        isolate(setup$barcodes_confirmed),
        columns = cols_barcodes_confirmed)
    })
  })
  
  observeEvent(input$dynamic_done, {
    output$setup_summary <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height              = 500,
        columns             = cols_setup,
        highlight           = TRUE
      )
    })
  })
  
  observeEvent(input$setup_done, {
    output$extract_prep  <- renderReactable({
      reactable(
        samples$calculations,
        columns       = cols_setup,
        theme         = format_checklist,
        selection     = "multiple", 
        onClick       = "select")
      
      output$rap16s_I.1.  <- renderReactable({
        reactable(
          isolate(samples$calculations),
          height  = 300,
          columns = cols_rap16s_I.1.
        )
      })
      output$rap16s_I.6.          <- renderReactable({
        reactable(
          isolate(setup$rxns$rap16s_pcr),
          columns             = cols_rxns,
          theme               = format_checklist,
          selection           = "multiple", 
          onClick             = "select"
        )
      })
      output$rap16s_I.7.  <- renderReactable({
        reactable(
          isolate(samples$calculations),
          height  = 300,
          columns = cols_rap16s_I.1.
        )
      })
      
    })
    
    observeEvent(input$confirm_qc1, {
      output$rap16s_II.5.  <- renderReactable({
        reactable(
          isolate(samples$calculations),
          height  = 300,
          columns = cols_rap16s_I.1.
        )
      })
    })
    
    
  })
}

render_gt_tabs <- function() {
  output$rap16s_I.9.   <- render_gt(expr = rap16s_cycles)
  observeEvent(input$part1_done, {
    output$rap16s_II.1.  <- render_gt(expr = part2_reagents_rap16s)
    output$rap16s_II.19. <- render_gt(expr = rxn_rapadapt)
    output$flg_III.2.    <- render_gt(expr = flg_prime)
  })
  
  
}






