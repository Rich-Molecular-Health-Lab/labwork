

build_reactables <- function(input, output, samples, setup) {
  
  observeEvent(input$basics_done, {
    req(samples$compilation)
    output$samples <- renderReactable({
      reactable(
        isolate(samples$compilation),
        height          = 600,
        columns         = samples_select,
        selection       = "multiple",
        onClick         = "select",
        highlight       = TRUE,
        compact         = TRUE,
        defaultPageSize = 20
      )
    })
  })
  
  observeEvent(input$confirm_samples, {
    req(samples$calculations)
    output$selected <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height = 300,
        columns = cols_selected
      )
    })
  })
  
  observeEvent(input$samples_done, {
    req(setup$barcodes)
    output$barcodes <- renderReactable({
      reactable(
        isolate(setup$barcodes),
        height = 600,
        columns         = cols_barcodes,
        columnGroups    = groups_barcodes,
        selection       = "multiple",
        onClick         = "select",
        highlight       = TRUE
      )
    })
  })
  
  observeEvent(input$barcode_cols_confirm, {
    req(setup$barcode_wells)
    output$barcode_wells <- renderReactable({
      reactable(
        isolate(setup$barcode_wells),
        height = 600,
        columns = cols_barcode_wells,
        selection        = "multiple",
        onClick         = "select",
        highlight      = TRUE
      )
    })
  })
  
  observeEvent(input$barcode_wells_confirm, {
    req(setup$barcodes_confirmed)
    output$barcodes_confirmed <- renderReactable({
      reactable(
        isolate(setup$barcodes_confirmed),
        height = 300,
        columns = cols_barcodes_confirmed
      )
    })
  })
  
  observeEvent(input$dynamic_done, {
    req(samples$calculations)
    output$setup_summary <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height = 300,
        columns = cols_setup
      )
    })
  })
  
  observeEvent(input$setup_done, {
    req(samples$calculations)
    output$rap16s_I_1 <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height = 300,
        columns = cols_rap16s_I.1.
      )
    })
    
    output$extract_prep <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height  = 300,
        columns = cols_setup,
        select = "multiple",
        onClick  = "select"
      )
    })
    
    output$rap16s_I_7 <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height = 300,
        columns = cols_rap16s_I_1
      )
    })
    
    req(setup$rxns$rap16s_pcr)
    output$rap16s_I_6 <- renderReactable({
      reactable(
        isolate(setup$rxns$rap16s_pcr),
        height  = 300,
        columns  = cols_rxns,
        select = "multiple",
        onClick  = "select"
      )
    })
    
    req(setup$rxns$lsk_endprep)
    output$lsk_I_4 <- renderReactable({
      reactable(
        isolate(setup$rxns$lsk_endprep),
        height  = 300,
        columns  = cols_rxns,
        select = "multiple",
        onClick  = "select"
      )
    })
    
    req(setup$rxns$lsk_adapter)
    output$lsk_II_5 <- renderReactable({
      reactable(
        isolate(setup$rxns$lsk_adapter),
        height  = 300,
        columns  = cols_rxns,
        select = "multiple",
        onClick  = "select"
      )
    })
    
  })
  
  
  observeEvent(input$confirm_qc1, {
    req(samples$calculations)
    output$rap16s_II_5 <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height = 300,
        columns = cols_rap16s_II_5
      )
    })
  })
  
  
  observeEvent(input$confirm_qc2, {
    req(samples$calculations)
    output$lsk_II_19 <- renderReactable({
      reactable(
        isolate(samples$calculations),
        height = 300,
        columns = cols_lsk_II_19
      )
    })
  })
  
  observeEvent(input$part2_done, {
    req(setup$rxns$minion_load)
    output$lsk_III_8 <- renderReactable({
      reactable(
        isolate(setup$rxns$minion_load),
        height  = 300,
        columns  = cols_rxns,
        select = "multiple",
        onClick  = "select"
      )
    })
  })
}

build_gt_tabs <- function(output) {
  observe({
    output$rap16s_I_9   <- render_gt({expr = "rap16s_cycles"})
    output$rap16s_II_1  <- render_gt({expr = "part2_reagents_rap16s"})
    output$rap16s_II_19 <- render_gt({expr = "rap16s_adapt"})
    output$flg_III_2    <- render_gt({expr = "flg_prime"})
    output$mn_III_2     <- render_gt({expr = "mn_prime"})
  })
}


