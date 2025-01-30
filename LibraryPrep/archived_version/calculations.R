
lsk_input_calculations      <- function(input, output, setup) {
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
  
}
values_from_inputs          <- function(input, setup) {
  observe({
    req(setup$n_controls, setup$n_extracts)
    setup$n_rxns <- sum(setup$n_controls, setup$n_extracts)
  })
  
  observeEvent(input$dynamic_done, {
    req(setup$fragment_type, setup$Length, setup$strands)
    setup$InputMassFinal      <- calculate_mass_final(setup$fragment_type, setup$Length, setup$strands)
  })
  
  observeEvent(input$samples_done, {
    req(setup$rxns, setup$n_rxns)
    
    # Modify `setup$rxns` using `rxn_vols` and `setup$n_rxns`
    updated_rxns <- modify2(setup$rxns, setup$n_rxns, \(x, y) rxn_vols(x, y))
    
    # Update the reactive value
    setup$rxns <- updated_rxns
  })
}

volumes_from_concentrations <- function(input, setup, samples) {
  
  # Update concentrations based on QC1 inputs
  observeEvent(input$setup_done, {
    req(setup$concentrations)
    setup$concentrations <- imap(setup$concentrations, ~ {
      TubeNo <- .y
      inputID <- paste0("QC1_", TubeNo)
      req(input[[inputID]])
      as.numeric(input[[inputID]])
    })
  })
  
  # Handle confirmation of QC1
  observeEvent(input$confirm_qc1, {
    update_samples_after_qc1(input, setup, samples)
  })
  
  # Workflow-specific concentration updates (QC2)
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      req(input$Conc_QC2)
      setup$Conc_QC2 <- as.numeric(input$Conc_QC2)
    } else if (setup$workflow == "lsk") {
      req(setup$concentrations, input$confirm_qc1)
      setup$concentrations <- imap(setup$concentrations, ~ {
        TubeNo <- .y
        inputID <- paste0("QC2_", TubeNo)
        req(input[[inputID]])
        as.numeric(input[[inputID]])
      })
    }
  })
  
  # Handle confirmation of QC2
  observeEvent(input$confirm_qc2, {
    update_samples_after_qc2(input, setup, samples)
  })
}

