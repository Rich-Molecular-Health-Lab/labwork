# /LibraryPrep/server/dynamic_ui.R

render_images <- function(output) {
  render_image(output, "imgIII3a"     , "Flow_Cell_Loading_Diagrams_Step_1a.svg"                    , base_path, height = "90%")
  render_image(output, "imgIII3b"     , "Flow_Cell_Loading_Diagrams_Step_1b.svg"                    , base_path, height = "75%")
  render_image(output, "imgIII4"      , "Flow_Cell_Loading_Diagrams_Step_2.svg"                     , base_path, height = "75%")
  render_image(output, "imgIII5"      , "Flow_Cell_Loading_Diagrams_Step_03_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIII6"      , "Flow_Cell_Loading_Diagrams_Step_04_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIII9a"     , "Flow_Cell_Loading_Diagrams_Step_06_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIII11"     , "Flow_Cell_Loading_Diagrams_Step_07_V5.gif"                 , base_path, height = "75%")
  render_image(output, "imgIII12a"    , "Step_8_update.png"                                         , base_path, height = "75%")
  render_image(output, "imgIII12b"    , "Flow_Cell_Loading_Diagrams_Step_9.svg"                     , base_path, height = "75%")
  render_image(output, "imgIII13"     , "J2264_-_Light_shield_animation_Flow_Cell_FAW_optimised.gif", base_path, height = "75%")
}

render_dynamic_cards <- function(input, output, setup) {
  output$card_III.2. <- renderUI(
    render_card(
      header = "In a suitable tube for the number of flow cells, combine the following reagents:",
      reactable_id = "fcprime_react",
      footer_text = "Mix by pipetting at room temperature and check as you add each."))
  
  output$card_III.8. <- renderUI(
    render_card(
      header = "Prepare the reaction mix with diluted library as Template DNA:",
      reactable_id = "fcload_react",
      footer_text = render_illustration("imgIII8")))
  
  output$card_III.3.  <- renderUI(render_illustration_x2("imgIII3a", "imgIII3b"))
  output$card_III.4.  <- renderUI(render_illustration("imgIII4"))
  output$card_III.5.  <- renderUI(render_illustration("imgIII5"))
  output$card_III.6.  <- renderUI(render_illustration("imgIII6"))
  output$card_III.9.  <- renderUI(render_illustration_x2("imgIII9a", "imgIII9b"))
  output$card_III.11. <- renderUI(render_illustration("imgIII11"))
  output$card_III.12. <- renderUI(render_illustration_x2("imgIII12a", "imgIII12b"))
  
  observeEvent(input$workflow_done, {
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      
      output$card_I.1. <- renderUI(reactableOutput("rap16s_I.1."))
      output$card_I.5. <- renderUI(reactableOutput("extract_prep"))
      output$card_I.6. <- renderUI(
          card(
            card_header("In a 0.2 ml thin-walled PCR tube, prepare the reaction mix according to the volumes below."),
            reactableOutput("rap16s_I.6."),
            card_footer("Note: If the amount of input material is altered, the number of PCR cycles may need to be adjusted to produce the same yield.")
          )
      )
      
      output$card_I.8. <- renderUI(uiOutput("barcode_tubes"))
      
      output$card_I.9. <- renderUI(reactableOutput("extract_prep"))
      
      output$card_I.10. <- renderUI(gt_output("table_I.10."))
      
      output$card_II.1. <- renderUI(gt_output("table_II.1."))
      
      output$card_II.1. <- renderUI(gt_output("part2_reagents_rap16s"))
      
      output$card_II.4. <- renderUI(uiOutput("qc1_result"))
      
      output$card_II.5. <- renderUI(
        render_card(
          header = "Use the table below to ensure equimolar ratios based on the QC results from the previous step",
          reactable_id = "pooling_ratios",
          footer_text = "Samples may vary in concentration following the barcoded PCR, therefore the volume of each barcoded sample added to the pool will be different."))
      
      output$card_II.7. <- renderUI(
        value_box(title = paste0("Volume AMPure XP Beads (in ", ul, "):"),
                  value = uiOutput("beadvol")))
      
      
      
      output$card_II.17. <- renderUI(uiOutput("qc2_result"))
      
      output$card_II.18. <- renderUI(
        card(
          card_header("Use the table below to prepare the proper library concentration based on the QC results from the previous step"),
          uiOutput("loading_vol"),
          card_footer("This volume will yield a molecular weight of 50 fmol.")))
      
      output$card_II.19. <- renderUI(gt_output("table_II.19."))
      
    }
    else if (setup$workflow == "lsk") {
      
      output$card_I.3. <- renderUI(reactableOutput("extract_prep"))
      
      output$card_I.4. <- renderUI(
        render_card(
          header       = "After diluting each DNA extract, prepare the reaction mix:",
          reactable_id = "endprep_react",
          footer_text  = "As you add each reagent, pipette mix 10-20 times and check the box."))
      
      output$card_I.19. <- renderUI(uiOutput("qc1_result"))
      
      output$card_II.5. <- renderUI(
        render_card(
          header       = "In a 1.5 ml Eppendorf DNA LoBind tube, mix in the following order:",
          reactable_id = "adapter_react",
          footer_text  = "Between each addition, pipette mix 10-20 times."))
      
      output$card_II.18. <- renderUI(uiOutput("qc2_result"))
      
      output$card_II.19. <- renderUI(
        render_card(
          header       = "Dilute final libraries as follows by adding either additional elution buffer or sterile H2O:",
          reactable_id = "final_libraries",
          footer_text  = "Note: If the library yields are below the input recommendations, load the entire library. You may also want to consider a clean & concentrator kit or other enrichment step first."))
    }
  })
  
}

switch_tabs <- function(input, setup) {
  nav_select("setup.nav", "basics")
  nav_hide("setup.nav", "samples")
  nav_hide("setup.nav", "barcode_cols")
  nav_hide("setup.nav", "barcode_wells")
  nav_hide("setup.nav", "lsk_input")
  nav_hide("setup.nav", "setup")
  nav_hide("setup.nav", "conclude")
  nav_hide("main.nav" , "part1" )
  nav_hide("main.nav" , "part2" )
  nav_hide("main.nav" , "part3" )
  
  observeEvent(input$basics_done, {
    nav_show("setup.nav", "samples", select = TRUE)
    nav_hide("setup.nav", "basics")
  })
  
  observeEvent(input$confirm_samples, {
    accordion_panel_open("samples_selected", "review_samples")
  })
  
  observeEvent(input$samples_done, {
    nav_hide("setup.nav", "samples")
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      nav_show("setup.nav", "barcode_cols", select = TRUE)
      nav_remove("setup.nav", "lsk_input")
    } else if (setup$workflow == "lsk") {
      nav_select("setup.nav", "lsk_input", select = TRUE)
      nav_remove("setup.nav", "barcode_cols")
      nav_remove("setup.nav", "barcode_wells")
    }
  })
  
  observeEvent(input$barcode_cols_confirm, {
    nav_show("setup.nav", "barcode_wells", select = TRUE)
  })
  observeEvent(input$barcode_wells_confirm, {
    accordion_panel_open("barcodes_selected", "barcodes_confirmed")
  })
  
  observeEvent(input$dynamic_done, {
    nav_show("setup.nav", "setup", select = TRUE)
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      nav_hide("setup.nav", "barcode_cols")
      nav_hide("setup.nav", "barcode_wells")
    } else if (setup$workflow == "lsk") {
      nav_hide("setup.nav", "lsk_input")
    }
  })
  
  observeEvent(input$setup_done, {
    nav_hide("setup.nav", "setup")
    nav_show( "main.nav" , "part3", select = FALSE )
    nav_show( "main.nav" , "part2", select = FALSE )
    nav_show( "main.nav" , "part1", select = TRUE)
    nav_select( "main.nav" , "part1")
  }, ignoreInit = FALSE)
  
  observeEvent(input$part1_done, {
    nav_select( "main.nav" , "part2")
  }, ignoreInit = FALSE)
  
  observeEvent(input$part2_done, {
    nav_select( "main.nav" , "part3")
  }, ignoreInit = FALSE)
  
  
  observeEvent(input$part3_done, {
    nav_hide("main.nav" , "part1" )
    nav_hide("main.nav" , "part2" )
    nav_hide("main.nav" , "part3" )
    nav_show("setup.nav", "conclude")
    nav_select( "setup.nav" , "conclude" )
  })
  
}


render_protocol_outputs <- function(output, setup) {
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      
      output$part2_reagents_rap16s <- render_gt({part2_reagents_rap16s})
      output$rap16s_cycles         <- render_gt({rap16s_cycles})
      
    }
    
  })
}

link_tabs <- function(input) {
  
  tab.link <- function(tab1, tab2, input, nav_id = "main.nav") {
    observeEvent(input[[paste0(tab1, "_done")]], {
      req(nav_id, tab2) 
      nav_select(nav_id, tab2)
    })
  }
  tab.link("part1" , "part2"  , input)
  tab.link("part2" , "part3"  , input)
}

dynamic_protocol <- function(input, output, setup) {
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      
      output$supplies <- renderUI({
        navset_card_tab( 
          nav_panel("ONT Kit", "SQK-16S-114", 
                    list_panel(supplies_rap16s$Kits$SQK16S114)),
          nav_panel("Other Reagents", "Other Reagents", 
                    list_panel(supplies_rap16s$reagents)),
          nav_panel("Tubes", "Tubes", 
                    list_panel(supplies_rap16s$tubes)),
          nav_panel("Equipment", "Equipment", 
                    list_panel(supplies_rap16s$equipment))
        )
      })
      
      output$input_dna           <- renderUI({gt_output("input_dna_rap16s")})
      output$part1_heading       <- renderText("I. Barcoding and 16S PCR")
      output$part1_accord        <- renderUI({
        accordion(accordion_panel("Dynamic Summary Table", 
                                  value = "summary_table",
                                  reactableOutput("part1_rap16s")),
                  part1_rap16s.recs)})
      output$part1_steps   <- renderUI({make_steps(part1_rap16s)})
      output$part1_footer  <- renderText("Next: Sample Pooling and Library Cleanup")
      output$part2_heading <- renderText("II. Sample Pooling, Library Cleanup, Adapter Ligation")
      output$part2_accord  <- renderUI({
        accordion(
          accordion_panel("Dynamic Summary Table", 
                          value = "summary_table",
                          reactableOutput("part2_rap16s")))})
      output$part2_steps   <- renderUI({make_steps(part2_rap16s)})
      output$part3_reactable  <- renderUI({reactableOutput("part3_rap16s")})
    }
    else if (workflow == "lsk") {
      
      output$supplies         <- renderUI({
        navset_card_tab( 
          nav_panel("ONT Kit", "SQK-LSK-114", 
                    list_panel(supplies_lsk$Kits$SQKLSK114)),
          nav_panel("NEB Accessory Kit", "NEBNext® Companion Module v2", 
                    list_panel(supplies_lsk$Kits$NEBE7672S)),
          nav_panel("Other Reagents", "Other Reagents", 
                    list_panel(supplies_lsk$reagents)),
          nav_panel("Tubes", "Tubes", 
                    list_panel(supplies_lsk$tubes)),
          nav_panel("Equipment", "Equipment", 
                    list_panel(supplies_lsk$equipment))
        )
      })
      output$input_dna        <- renderUI({gt_output("input_dna_lsk")})
      output$part1_heading    <- renderText("I. DNA Repair and End Prep")
      output$part1_accord     <- renderUI({
        accordion(accordion_panel("Dynamic Summary Table", 
                                  value = "summary_table",
                                  reactableOutput("part1_lsk")),
                  part1_lsk.recs)
        })
      output$part1_steps      <- renderUI(make_steps(part1_lsk))
      output$part1_footer     <- renderText("Next: Adapter Ligation and Library Cleanup")
      output$part2_heading    <- renderText("II. Adapter Ligation and Library Cleanup")
      output$part2_accord     <- renderUI({
        accordion(accordion_panel("Dynamic Summary Table", 
                                  value = "summary_table",
                                  reactableOutput("part2_lsk")),
                  part2_lsk.recs)
        })
      output$part2_steps      <- renderUI({make_steps(part2_lsk)})
      output$part3_reactable  <- renderUI({reactableOutput("part3_lsk")})
    }
  })
  
}
