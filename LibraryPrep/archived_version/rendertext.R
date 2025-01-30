render_text_outputs <- function(input, output, setup) {
  observeEvent(input$flowcell_type, {
    req(setup$pores_needed, setup$FlowCellType)
    output$flowcell_check <- renderText({ setup$pores_needed })
  })
  
  observe({
    req(setup$n_rxns, setup$n_extracts, setup$n_controls)
    output$samples_count <- renderText({
      paste0("Total Selected: ", setup$n_extracts, " (+ ", setup$n_controls, " Controls, Total ", setup$n_rxns, " rxns)")
    })
  })
  
  observe({
    req(setup$barcodes_confirmed, setup$n_rxns)
    output$barcode_footer <- renderText({
      paste0(nrow(setup$barcodes_confirmed), " barcodes selected out of ", setup$n_rxns, " needed")
    })
  })
  
  observeEvent(input$dynamic_done, {
    req(setup$FragBuffer)
    output$fragbuffer <- renderText({ setup$FragBuffer })
  })
  
  observeEvent(input$submit_start_note, {
    req(setup$setup_note)
    output$start_note_submitted <- renderText({ setup$setup_note })
  })
  
  
  observeEvent(input$confirm_qc1, {
    req(setup$beadvol)
    output$beadvol <- renderText({ setup$beadvol })
  })
  
  observeEvent(input$confirm_qc2, {
    output$LibDilute <- renderText({ 
      if (setup$LibraryWaterVol <= 1) {
        "Dilution not needed."
      } else {
        paste0(setup$LibraryLoadingVol, ul, " Eluate + ", setup$LibraryWaterVol, ul, " Elution Buffer")
      }
    })
  })
  
  observeEvent(input$generate_report, {
    req(setup$conclusion_note)
    output$end_note_render <- renderText({ setup$conclusion_note })
  })

}
