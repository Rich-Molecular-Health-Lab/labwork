
lsk_input_calculations <- function() {
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

values_from_inputs <- function() {
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
    modify2(setup$rxns, setup$n_rxns, \(x, y) rxn_vols(x, y))
  })
}


volumes_from_concentrations <- function() {

    observeEvent(input$setup_done, {
    req(concentrations)
    imap(concentrations, ~ {
      TubeNo        <- .y
      Concentration <- .x
      inputID <- paste0("QC1_", TubeNo)
      req(input[[inputID]])
      concentrations[[paste0(TubeNo)]] <- as.numeric(input[[inputID]])
    })
  })
  
  observeEvent(input$confirm_qc1, {
    qc1_result <- isolate({
      list_rbind(concentrations, names_to = "LibraryTube") %>%
        select(LibraryTube, Conc_QC1 = concentrations)
    })
    req(qc1_result, samples$calculations)
    samples$calculations <- samples$calculations %>%
      select(-Conc_QC1) %>%
      left_join(qc1_result, by = join_by(LibraryTube)) %>%
      mutate(TemplateVolLoading = setup$TemplateVolLoading)
    
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      req(samples$calculations)
      pool_results <- pooling_calculations(
        Conc_QC1    = samples$calculations$Conc_QC1,
        LibraryTube = samples$calculations$LibraryTube
      )
      
      req(pool_results$TotalPoolVol)
      setup$TotalPoolVol <- as.numeric(pool_results$TotalPoolVol)
      req(setup$TotalPoolVol)
      setup$beadvol <- setup$TotalPoolVol * 6
      
      req(pool_results$SampVolPool)
      pool_vols <- list_rbind(pool_results$SampVolPool, names_to = "LibraryTube")
      
      req(pool_vols, samples$calculations, setup$beadvol, setup$TotalPoolVol)
      samples$calculations <- samples$calculations %>%
        select(-SampVolPool) %>%
        left_join(pool_vols, by = join_by(LibraryTube)) %>%
        mutate(TotalPoolVol = setup$TotalPoolVol) %>%
        mutate(BeadVol = setup$beadvol)
    } else if (setup$workflow == "lsk") {
      req(samples$calculations, setup$beadvol, setup$TotalPoolVol)
      samples$calculations <- samples$calculations %>%
        mutate(
          TotalPoolVol = setup$TotalPoolVol,
          BeadVol      = setup$beadvol
        )
    }
    
  })
  
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      req(input$Conc_QC2)
      setup$Conc_QC2 <- as.numeric(input$Conc_QC2)
      
    } else if (setup$workflow == "lsk") {
      req(concentrations, input$confirm_qc1)
      imap(concentrations, ~ {
        TubeNo        <- .y
        Concentration <- .x
        inputID <- paste0("QC2_", TubeNo)
        req(input[[inputID]])
        concentrations[[paste0(TubeNo)]] <- as.numeric(input[[inputID]])
      })
    }
  })
  

observeEvent(input$confirm_qc2, {
  req(setup$workflow, input$Conc_QC2)
  if (setup$workflow == "rapid16s") {
    
    req(setup$Conc_QC2, setup$InputMassFinal)
    setup$LibraryLoadingVol <- setup$InputMassFinal/setup$Conc_QC2
    req(setup$LibraryLoadingVol, setup$TemplateVolLoading)
    setup$LibraryWaterVol <- setup$TemplateVolLoading - setup$LibraryLoadingVol
    
    req(samples$calculations, 
        setup$Conc_QC2, 
        setup$InputMassFinal, 
        setup$LibraryLoadingVol, 
        setup$TemplateVolLoading,
        setup$LibraryWaterVol)
    samples$calculations <- samples$calculations %>%
      mutate(Conc_QC2           = setup$Conc_QC2,
             InputMassFinal     = setup$InputMassFinal    ,
             LibraryLoadingVol  = setup$LibraryLoadingVol ,
             TemplateVolLoading = setup$TemplateVolLoading,
             LibraryWaterVol    = setup$LibraryWaterVol   
      )
  } else if (setup$workflow == "lsk") {
    req(concentrations)
    qc2_result <- isolate({
      list_rbind(concentrations, names_to = "LibraryTube") %>%
        select(LibraryTube, Conc_QC2 = concentrations)
    })
    req(samples$calculations, 
        qc2_result, 
        setup$InputMassFinal, 
        setup$TemplateVolLoading)
    samples$calculations <- samples$calculations %>%
      select(-Conc_QC2) %>%
      left_join(qc2_result, by = join_by(LibraryTube)) %>%
      mutate(InputMassFinal     = setup$InputMassFinal,
             TemplateVolLoading = setup$TemplateVolLoading) %>%
      mutate(LibraryLoadingVol = InputMassFinal/Conc_QC2) %>%
      mutate(LibraryWaterVol   = TemplateVolLoading - LibraryLoadingVol)
  }
  
})

}


