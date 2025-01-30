
setup_rxns  <- keep_at(rxns , "rapid16s") %>% list_flatten(name_spec = "{inner}")
steps_part1 <- keep_at(part1_steps, "rapid16s") %>% list_flatten(name_spec = "{inner}")
steps_part2 <- keep_at(part2_steps, "rapid16s") %>% list_flatten(name_spec = "{inner}")
steps_part3 <- keep_at(part3_steps, "rapid16s") %>% list_flatten(name_spec = "{inner}")

setup_steps <- keep_at(steps, "rapid16s") %>% list_flatten(name_spec = "{inner}")
steps_list <- setup_steps

steps_record <- imodify(steps_list, ~ {
  name        <- .y
  step        <- .x
  main_step   <- step[[1]]
  substeps    <- step[-1]
  
  step <- list(
    detail     = main_step,
    substeps   = substeps,
    timestamp  = NULL,
    note       = NULL
  ) %>% set_names(name)
})

steps_parts <- keep_at(steps_workflow, "rapid16s") %>% list_flatten(name_spec = "{inner}")

setup <- keep_at(setup_vals, "rapid16s") %>% list_flatten(name_spec = "{inner}")

setup <- reactiveValues(
  steps              = list(),
  steps_record       = list(),
  workflow           = character(),
  sampleset          = character(),
  LibPrepDate        = as.Date(character()),
  LibraryCode        = character(),
  LibPrepBy          = character(),
  LibPrepAssist      = character(),
  FlowCellType       = character(),
  FragBuffer         = character(),
  pores_needed       = numeric(),
  FlowCellSerial     = character(),
  SeqDevice          = character(),
  fragment_type      = numeric(),
  strands            = numeric(),
  Length             = numeric(),
  InputMassStart     = numeric(),
  TemplateVolPrep    = numeric(),
  concentrations     = list(),
  Conc_QC2           = numeric(),
  LibraryLoadingVol  = numeric(),
  LibraryWaterVol    = numeric(),
  InputMassFinal     = numeric(),
  TemplateVolLoading = numeric(),
  TotalPoolVol       = numeric(),
  beadvol            = numeric(),
  n_controls         = numeric(),
  n_extracts         = numeric(),
  n_rxns             = numeric(),
  barcodes           = tibble(
    column = integer(),
    A      = character(),
    B      = character(),
    C      = character(),
    D      = character(),
    E      = character(),
    F      = character(),
    G      = character(),
    H      = character()
  ),
  barcode_wells      = tibble(),
  barcodes_confirmed = tibble(
    Barcode     = character(),
    BarcodePos  = character(),
    LibraryTube = integer()
  ),
  file_prefix        = character(),
  setup_note         = character(),
  conclusion_note    = character(),
  PoolSamples        = character(),
  rxns               = list(rapid16s = rxns_rapid16s, lsk = rxns_lsk))

setup_vals <- list(
  rapid16s = list(
    steps              = list(),
    steps_record       = list(),
    workflow           = "rapid16s",
    sampleset          = character(),
    LibPrepDate        = as.Date(character()),
    LibraryCode        = character(),
    LibPrepBy          = character(),
    LibPrepAssist      = character(),
    FlowCellType       = character(),
    FragBuffer         = character(),
    pores_needed       = numeric(),
    FlowCellSerial     = character(),
    SeqDevice          = character(),
    fragment_type      = 2,
    strands            = 2,
    Length             = 1500,
    InputMassStart     = 10,
    TemplateVolPrep    = numeric(),
    concentrations     = list(),
    Conc_QC2           = numeric(),
    LibraryLoadingVol  = numeric(),
    LibraryWaterVol    = numeric(),
    InputMassFinal     = numeric(),
    TemplateVolLoading = 15,
    TotalPoolVol       = numeric(),
    beadvol            = numeric(),
    n_controls         = numeric(),
    n_extracts         = numeric(),
    n_rxns             = numeric(),
    barcodes           = barcodes.24,
    barcode_wells      = tibble(),
    barcodes_confirmed = tibble(
      Barcode     = character(),
      BarcodePos  = character(),
      LibraryTube = integer()
    ),
    file_prefix        = character(),
    setup_note         = character(),
    conclusion_note    = character(),
    PoolSamples        = "Yes",
    rxns               = rxns_rapid16s
  ),
  lsk = list(
    steps              = list(),
    steps_record       = list(),
    workflow           = "lsk",
    sampleset          = character(),
    LibPrepDate        = as.Date(character()),
    LibraryCode        = character(),
    LibPrepBy          = character(),
    LibPrepAssist      = character(),
    FlowCellType       = character(),
    FragBuffer         = character(),
    pores_needed       = numeric(),
    FlowCellSerial     = character(),
    SeqDevice          = character(),
    fragment_type      = numeric(),
    strands            = numeric(),
    Length             = numeric(),
    InputMassStart     = numeric(),
    TemplateVolPrep    = numeric(),
    concentrations     = list(),
    Conc_QC2           = numeric(),
    LibraryLoadingVol  = numeric(),
    LibraryWaterVol    = numeric(),
    InputMassFinal     = numeric(),
    TemplateVolLoading = 12,
    TotalPoolVol       = 100,
    beadvol            = 40,
    n_controls         = numeric(),
    n_extracts         = numeric(),
    n_rxns             = numeric(),
    barcodes           = NULL,
    barcode_wells      = NULL,
    barcodes_confirmed = NULL,
    file_prefix        = character(),
    setup_note         = character(),
    conclusion_note    = character(),
    PoolSamples        = "No",
    rxns               = rxns_lsk
  )
)


render_cards_part1 <- function(output, setup) {
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      output$card_I_1   <- renderUI({reactableOutput("rap16s_I_1")})
      output$card_I_5   <- renderUI({reactableOutput("extract_prep")})
      output$card_I_6   <- renderUI({reactableOutput("rap16s_I_6")})
      output$card_I_7   <- renderUI({reactableOutput("rap16s_I_7")})
      output$card_I_9   <- renderUI({
        tagList(
          gt_output("rap16s_I_9"),
          card(class = "bg-warning",
               card_header("DO NOT DAMAGE THE THERMAL CYCLER"),
               card_body("Please ask for help if you have not used the thermal cycler before.",
                         tags$ul(
                           tags$li("You want to be sure all tube lids are properly closed. If they are not, you may waste an entire reaction due to evaporation of reagents."), 
                           tags$li("Be sure the thermal cycler lid latches securely, but DO NOT force the lid if you are struggling. This could damage or destroy the equipment.")
                         )
               )
          )
        )
      })
      
    } else if (setup$workflow == "lsk") {
      output$card_I1 <- renderUI({
        card(class = "bg-info",
             card_header("Tip from ONT"),
             card_body("ONT recommends using the DNA Control Sample (DCS) in your library prep for troubleshooting purposes."),
             card_footer("You can also omit this step and make up the extra 1 µl with your sample DNA, if preferred.")
        )
      })
      output$card_I_3   <- renderUI({reactableOutput("extract_prep")})
      output$card_I_4   <- renderUI({reactableOutput("lsk_I_4")})
      output$card_I_19  <- renderUI({
        tagList(
          card(uiOutput("qc1_inputs"), 
               card_footer(actionButton("confirm_qc1", "Click to confirm values"))
          ),
          card(class = "bg-dark",
               card_header("End of Step"),
               "Take forward the repaired and end-prepped DNA into the adapter ligation step.",
               card_footer("However, at this point it is also possible to store the sample at 4°C overnight.")
          )
        )
      })
      
    }
    
  })
}

render_cards_part2 <- function(output, setup) {
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      output$card_II_1  <- renderUI({gt_output("rap16s_II_1")})
      output$card_II_4  <- renderUI({ 
        tagList(
          card(uiOutput("qc1_inputs"), card_footer(actionButton("confirm_qc1", "Click to confirm values"))) 
        )
      })
      output$card_II5  <- renderUI({reactableOutput("rap16s_II_5")})
      output$card_II7  <- renderUI({
        value_box(
          title = paste0("Volume AMPure XP Beads (in ", ul, "):"),
          value = textOutput("beadvol")
        )
      })
      output$card_II_17 <- renderUI({
        card(uiOutput("qc2_inputs"), 
             card_footer(actionButton("confirm_qc2", "Click to confirm values")))
      })
      output$card_II_18 <- renderUI({
        value_box(
          title = paste0("To reach total volume of 15 ", ul),
          value = textOutput("LibDilute")
        )
      })
      output$card_II_19 <- renderUI({gt_output("rap16s_II_19")})
      
    } else if (setup$workflow == "lsk") {
      output$card_II_4  <- renderUI({value_box(title = paste0("Wash the beads by adding 250 ", ul, "of the:"), value = textOutput("fragbuffer"))})
      output$card_II_5  <- renderUI({reactableOutput("lsk_II_5")})
      output$card_II_12 <- renderUI({value_box(title = paste0("Wash the beads by adding 250 ", ul, "of the:"), value = textOutput("fragbuffer"))})
      output$card_II_18 <- renderUI({card(uiOutput("qc2_inputs"), card_footer(actionButton("confirm_qc2", "Click to confirm values")))})
      output$card_II_19 <- renderUI({
        tagList(
          reactableOutput("lsk_II_19"),
          card(class = "bg-dark",
               card_header("End of Step"),
               "The prepared library is used for loading into the ﬂow cell. Store the library on ice or at 4°C until ready to load."
          ),
          card(class = "bg-success",
               card_header("Library storage recommendations"),
               "ONT recommends storing libraries in Eppendorf DNA LoBind tubes at 4°C for short-term storage or repeated use, for example, re-loading flow cells between washes. For single use and long-term storage of more than 3 months, they recommend storing libraries at -80°C in Eppendorf DNA LoBind tubes."
          )
        )
      })
      
    }
  })
}

render_cards_part3 <- function(output, setup) {
  output$card_III_7 <- renderUI({
    card(class = "bg-warning",
         card_header("IMPORTANT"),
         "The Library Beads (LIB) tube contains a suspension of beads. These beads settle very quickly. It is vital that they are mixed immediately before use.",
         card_footer("ONT recommends using the Library Beads (LIB) for most sequencing experiments. However, the Library Solution (LIS) is available for more viscous libraries.")
    )
  })
  
  observe({
    req(setup$workflow)
    if (setup$workflow == "rapid16s") {
      output$card_III_1 <- renderUI({
        tagList(
          card(class = "bg-warning",
               card_header("IMPORTANT"),
               "Do NOT touch the reverse side of the Flongle flow cell array or the contact pads on the Flongle adapter. ALWAYS wear gloves when handling Flongle flow cells and adapters to avoid damage to the flow cell or adapter.",
               render_illustration("flg_III_1")
          ))
      })
      output$card_III_2 <- renderUI({gt_output("flg_III_2")})
      output$card_III_3 <- renderUI({
        tagList(
          card(class = "bg-secondary",
               card_header("The diagram below shows the components of the Flongle flow cell:"),
               render_illustration("flg_III_3_a"),
               card_footer("The seal tab, air vent, waste channel, drain port and sample port are visible here. The sample port, drain port and air vent only become accessible once the seal tab is peeled back.")
          ),
          card(class = "bg-warning", card_header("IMPORTANT"),
               "The adapter needs to be plugged into your device, and the device should be plugged in and powered on before inserting the Flongle flow cell.",
               render_illustration("flg_III_3_b")
          ))
      })
      output$card_III_4 <- renderUI({
        tagList(
          card(class = "bg-secondary", card_header("The flow cell should sit evenly and flat inside the adapter, to avoid any bubbles forming inside the fluidic compartments."),
               render_illustration("flg_III_4")
          )
        )
      })
      output$card_III_5 <- renderUI({
        tagList(
          layout_column_wrap(
            render_illustration("flg_III_5_a"),
            render_illustration("flg_III_5_b"),
            render_illustration("flg_III_5_c")
          )
        )
      })
      output$card_III_6 <- renderUI({render_illustration("flg_III_6")})
      output$card_III_9 <- renderUI({render_illustration_x2("flg_III_9_a", "flg_III_9_b")})
      
    } else if (setup$workflow == "lsk") {
      output$card_III_1 <- renderUI({
        card(class = "bg-warning", card_header("IMPORTANT"),
             card_body("For optimal sequencing performance and improved output on MinION R10.4.1 flow cells (FLO-MIN114), ONT recommends adding Bovine Serum Albumin (BSA) to the flow cell priming mix at a final concentration of 0.2 mg/ml."),
             card_footer("ONT does not recommend using any other albumin type (e.g. recombinant human serum albumin).")
        )
      })
      output$card_III_2 <- renderUI(gt_output("mn_III_2"))
      output$card_III_3 <- renderUI({
        tagList(
          card(class = "bg-secondary", card_header("The diagram below shows the components of the Flongle flow cell:"),
               render_illustration("flg_III_3_a"),
               card_footer("The seal tab, air vent, waste channel, drain port and sample port are visible here. The sample port, drain port and air vent only become accessible once the seal tab is peeled back.")
          ),
          card(class = "bg-warning", card_header("IMPORTANT"),
               "The adapter needs to be plugged into your device, and the device should be plugged in and powered on before inserting the Flongle flow cell.",
               render_illustration("flg_III_3_b")
          )
        )
      })
      output$card_III_4 <- renderUI({
        tagList(
          render_illustration("mn_III_4"),
          card(class = "bg-warning", card_header("IMPORTANT"),
               "Take care when drawing back buffer from the flow cell. Do not remove more than 20-30 µl, and make sure that the array of pores are covered by buffer at all times. Introducing air bubbles into the array can irreversibly damage pores."
          )
        )
      })
      output$card_III_5 <- renderUI({render_illustration("mn_III_5")})
      output$card_III_6 <- renderUI({render_illustration("mn_III_6")})
      output$card_III_8 <- renderUI({reactableOutput("lsk_III_8")})
      output$card_III_9 <- renderUI({render_illustration_x2("mn_III_9_a", "mn_III_9_b")})
      output$card_III_11 <- renderUI({render_illustration("mn_III_11")})
      output$card_III_12 <- renderUI({
        tagList(
          render_illustration_x2("mn_III_12_a", "mn_III_12_b"),
          card(class = "bg-warning", card_header("IMPORTANT"),
               "Install the light shield on your flow cell as soon as library has been loaded for optimal sequencing output.",
               card_footer("ONT recommends leaving the light shield on the flow cell when library is loaded, including during any washing and reloading steps. The shield can be removed when the library has been removed from the flow cell.")
          )
        )
      })
      
      output$card_III_13 <- renderUI({
        tagList(
          render_illustration("mn_III_12_a"),
          card(class = "bg-warning", card_header("CAUTION"),
               "The MinION Flow Cell Light Shield is not secured to the flow cell and careful handling is required after installation."
          )
        )
      })
      
    }
    
  })
  
}

dynamic_cards <- keep_at(workflow_config, "rapid16s") %>%
  list_flatten(name_spec = "{inner}")


make_steps <- function(nested_steps) {
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]
    display_name <- str_c(str_replace_all(step_name, "_", "\\."), ".")    
    
    substep_list <- if (length(substeps) > 0) {
      tags$ol(
        map(names(substeps), ~ tags$li(substeps[[.x]])),
        style = "list-style-type: lower-alpha;"
      )
    } else {
      NULL
    }
    
    card(
      id = paste0("step_", step_name),
      class = "bg-primary",
      card_header(textOutput(outputId = paste0("stamp_", step_name))),
      layout_sidebar(
        fillable = TRUE,
        sidebar = sidebar(
          open = FALSE,
          textAreaInput(inputId = paste0("text_", step_name), label = "Add note"),
          actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
          textOutput(outputId = paste0("note_", step_name))
        ),
        layout_columns(
          col_widths = c(1, 2, 9),
          checkboxInput(inputId = paste0("check_", step_name), label = ""),
          tags$h5(display_name),
          tagList(
            tags$h5(main_step),
            substep_list
          )
        ),
        layout_column_wrap(
          uiOutput(outputId = paste0("card_", step_name))
        )
      )
    )
  })
}

make_steps <- function(nested_steps) {
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]
    display_name <- str_c(str_replace_all(step_name, "_", "\\."), ".")    
    
    substep_list <- if (length(substeps) > 0) {
      tags$ol(
        map(names(substeps), ~ tags$li(substeps[[.x]])),
        style = "list-style-type: lower-alpha;"
      )
    } else {
      NULL
    }
    
    card(
      id = paste0("step_", step_name),
      class = "bg-primary",
      card_header(textOutput(outputId = paste0("stamp_", step_name))),
      card_title(
        layout_columns(
          col_widths = c(1, 2, 9),
          checkboxInput(inputId = paste0("check_", step_name), label = ""), display_name, main_step)
      ),
      card_body(substep_list),
      card_body(layout_column_wrap(uiOutput(outputId = paste0("card_", step_name)))),
      card_footer(accordion(open = F,accordion_panel("Add Note",
                                                     textAreaInput(inputId = paste0("text_", step_name), label = "Add note"),
                                                     actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
                                                     textOutput(outputId = paste0("note_", step_name))
      )))
    )
  )
  )
)
  })
}
