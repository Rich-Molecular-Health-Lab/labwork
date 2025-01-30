generate_ui <- function(output, dynamic_cards, part) {
  observe({
    req(dynamic_cards)
    
    # Filter cards for the specific part
    card_list <- keep_at(dynamic_cards, paste0(part)) %>% list_flatten(name_spec = "{inner}")
    
    # Iterate over cards and generate UI
    imap(card_list, ~ {
      card <- .x  # Current card configuration
      card_id <- .y  # Output ID
      req(card$type)  # Ensure the card has a `type` field
      
      # Render UI based on type
      output[[card_id]] <- renderUI({
        switch(card$type,
               reactableOutput = reactableOutput(card$id),
               gt_output = gt_output(card$id),
               tagList = card$content,
               value_box = value_box(title = card$title, value = card$value),
               illustration = card(
                 accordion(open = FALSE, accordion_panel(
                   title = "Illustration", imageOutput(card$image)
                 ))
               ),
               img_x2 = card(
                 accordion(open = FALSE, accordion_panel(
                   title = "Illustrations",
                   layout_columns(
                     col_widths = c(1, 1),
                     imageOutput(card$image1),
                     imageOutput(card$image2)
                   )
                 ))
               ),
               img_x3 = card(
                 accordion(open = FALSE, accordion_panel(
                   title = "Illustrations",
                   layout_columns(
                     col_widths = c(1, 1, 1),
                     imageOutput(card$image1),
                     imageOutput(card$image2),
                     imageOutput(card$image3)
                   )
                 ))
               ),
               warning = card(
                 class = "bg-warning",
                 card_header("IMPORTANT"),
                 card_body(card$body),
                 if (!is.null(card$footer)) card_footer(card$footer)
               ),
               tip = card(
                 class = "bg-info",
                 card_header(card$header),
                 card_body(card$body),
                 if (!is.null(card$footer)) card_footer(card$footer)
               ),
               img_captioned = card(
                 class = card$class,
                 card_header(card$header),
                 card_body(
                   accordion(open = FALSE, accordion_panel(
                     title = "Illustration",
                     imageOutput(card$image)
                   ))
                 ),
                 card_footer(card$caption)
               ),
               stop(paste("Unsupported type:", card$type, "for output ID:", card_id))
        )
      })
    })
  })
}
setup_workflow <- function(input, output, setup, samples, steps_parts) {
  
  observeEvent(input$select_workflow, {
    req(input$select_workflow)
    setup_vals <- keep_at(setup_vals, paste0(input$select_workflow)) %>% list_flatten(name_spec = "{inner}")
    req(setup_vals)
    setup$steps              <- setup_vals$steps             
    setup$workflow           <- setup_vals$workflow          
    setup$fragment_type      <- setup_vals$fragment_type     
    setup$strands            <- setup_vals$strands           
    setup$Length             <- setup_vals$Length            
    setup$InputMassStart     <- setup_vals$InputMassStart    
    setup$TemplateVolLoading <- setup_vals$TemplateVolLoading
    setup$TotalPoolVol       <- setup_vals$TotalPoolVol      
    setup$beadvol            <- setup_vals$beadvol           
    setup$PoolSamples        <- setup_vals$PoolSamples       
    setup$rxns               <- setup_vals$rxns              
    
    req(setup$workflow)
    barcode_tbl <- keep_at(barcodes, paste0(setup$workflow)) %>% pluck(1)
    setup$barcodes  <- rows_append(setup$barcodes, barcode_tbl)
    steps_parts <- keep_at(steps_workflow, paste0(setup$workflow)) %>% list_flatten(name_spec = "{inner}")
    setup$dynamic_cards <- keep_at(workflow_config, paste0(setup$workflow)) %>%
      list_flatten(name_spec = "{inner}")
    
    req(steps_parts)
    lapply(names(steps_parts), function(part_name) {
      output[[paste0(part_name, "_steps")]] <- renderUI({
        req(steps_parts[[part_name]])
        tagList(make_steps(steps_parts[[part_name]]))
      })
    })
    req(setup$dynamic_cards)
    lapply(c("part1", "part2", "part3"), function(part) {
      generate_ui(output, setup$dynamic_cards, part)
    })
    
    
  })
  
}
