image_list <- list(
  flg_III_1   = "Flongle_flow_cell_contacts.png",
  flg_III_3_a = "Named_items_of_the_flongle_A0.png",
  flg_III_3_b = "Flow_cell_adapter_insertion.png",
  flg_III_4   = "Flow_cell_insertion.png",
  flg_III_5_a = "Peel_back_tab_1.png",
  flg_III_5_b = "Peel_back_tab_2.png",
  flg_III_5_c = "Peel_back_tab_3.png",
  flg_III_6   = "Air_gap.png",
  flg_III_9_a = "Re-sealing_flow_cell_1.png",
  flg_III_9_b = "Re-sealing_flow_cell_4.png",
  mn_III_3_a  = "Flow_Cell_Loading_Diagrams_Step_1a.svg",
  mn_III_3_b  = "J2853_-_Flow_Cell_Image_Update_Step_1b__3.svg",
  mn_III_4    = "Flow_Cell_Loading_Diagrams_Step_2.svg",
  mn_III_5    = "Flow_Cell_Loading_Diagrams_Step_03_V5.gif",
  mn_III_6    = "Flow_Cell_Loading_Diagrams_Step_04_V5.gif",
  mn_III_9_a  = "Flow_Cell_Loading_Diagrams_Step_5.svg",
  mn_III_9_b  = "Flow_Cell_Loading_Diagrams_Step_06_V5.gif",
  mn_III_11   = "Flow_Cell_Loading_Diagrams_Step_07_V5.gif",
  mn_III_12_a = "Step_8_update.png",
  mn_III_12_b = "Flow_Cell_Loading_Diagrams_Step_9.svg",
  mn_III_12_a = "Step_8_update.png",
  mn_III_13   = "J2264_-_Light_shield_animation_Flow_Cell_FAW_optimised.gif"
)


workflow_config <- list(
  rapid16s = list(
    part1 = list(
      card_I_1 = list(type = "reactableOutput", id = "rap16s_I_1"),
      card_I_5 = list(type = "reactableOutput", id = "extract_prep"),
      card_I_6 = list(type = "reactableOutput", id = "rap16s_I_6"),
      card_I_7 = list(type = "reactableOutput", id = "rap16s_I_7"),
      card_I_9 = list(type = "tagList", content = tagList(
        gt_output("rap16s_I_9"),
        card(class = "bg-warning",
             card_header("DO NOT DAMAGE THE THERMAL CYCLER"),
             card_body("Please ask for help if you have not used the thermal cycler before.",
                       tags$ul(
                         tags$li("Ensure all tube lids are properly closed."),
                         tags$li("Do not force the thermal cycler lid to avoid damage.")
                       )
             )
        )
      ))
    ),
    part2 = list(
      card_II_1 = list(type = "gt_output", id = "rap16s_II_1"),
      card_II_4 = list(type = "tagList", content = tagList(
        card(uiOutput("qc1_inputs"), card_footer(actionButton("confirm_qc1", "Click to confirm values")))
      )),
      card_II_5 = list(type = "reactableOutput", id = "rap16s_II_5"),
      card_II_7 = list(type = "value_box", 
                       title = paste0("Volume AMPure XP Beads (in ", ul, "):"),
                       value = textOutput("beadvol")
                       ),
      card_II_17 = list(type = "tagList", content = tagList(
        card(uiOutput("qc2_inputs"), 
             card_footer(actionButton("confirm_qc2", "Click to confirm values")))
      )),
      card_II_18 = list(type = "value_box", 
                       title = paste0("To reach total volume of 15 ", ul),
                       value = textOutput("LibDilute")
      ),
      card_II_19 = list(type = "gt_output", id = "rap16s_II_19")
    ),
    part3 = list(
      card_III_1 = list(type = "img_captioned",
                        class = "bg-warning",
                        header = "IMPORTANT",
                        caption = "Do NOT touch the reverse side of the Flongle flow cell array or the contact pads on the Flongle adapter. ALWAYS wear gloves when handling Flongle flow cells and adapters to avoid damage to the flow cell or adapter.",
                        image = "flg_III_1"
      ),
      card_III_2 = list(type = "gt_output", id = "flg_III_2"),
      card_III_3 = list(type = "tagList", content = tagList(
        card(class = "bg-secondary",
             card_header("The diagram below shows the components of the Flongle flow cell:"),
             render_illustration("flg_III_3_a"),
             card_footer("The seal tab, air vent, waste channel, drain port and sample port are visible here. The sample port, drain port and air vent only become accessible once the seal tab is peeled back.")
        ),
        card(class = "bg-warning", card_header("IMPORTANT"),
             "The adapter needs to be plugged into your device, and the device should be plugged in and powered on before inserting the Flongle flow cell.",
             render_illustration("flg_III_3_b")
        )
      )),
      card_III_4 = list(type = "img_captioned",
                        class = "bg-secondary",
                        header = "The flow cell should sit evenly and flat inside the adapter, to avoid any bubbles forming inside the fluidic compartments.",
                        image = "flg_III_4"),
      card_III_5 = list(type = "img_x3", 
                        image1 = "flg_III_5_a", 
                        image2 = "flg_III_5_b", 
                        image3 = "flg_III_5_c"),
      card_III_6 = list(type = "illustration", image = "flg_III_6"),
      card_III_7 = list(type = "warning", 
                        body = "The Library Beads (LIB) tube contains a suspension of beads. These beads settle very quickly. It is vital that they are mixed immediately before use.",
                        footer = "ONT recommends using the Library Beads (LIB) for most sequencing experiments. However, the Library Solution (LIS) is available for more viscous libraries."
                        ),
      card_III_9 = list(type = "img_x2", 
                        image1 = "flg_III_9_a", 
                        image2 = "flg_III_9_b")
    )
 ),
  lsk = list(
    part1 = list(
      card_I_1 = list(type = "tip", 
                      header = "Tip from ONT", 
                      body = "ONT recommends using the DNA Control Sample (DCS) for troubleshooting.",
                      footer = "Alternatively, use extra DNA from your sample."),
      card_I_3 = list(type = "reactableOutput", id = "extract_prep"),
      card_I_4 = list(type = "reactableOutput", id = "lsk_I_4"),
      card_I_19 = list(type = "tagList", content = tagList(
        card(uiOutput("qc1_inputs"), 
             card_footer(actionButton("confirm_qc1", "Click to confirm values"))
        ),
        card(class = "bg-dark",
             card_header("End of Step"),
             "Twake forward the repaired and end-prepped DNA into the adapter ligation step.",
             card_footer("However, at this point it is also possible to store the sample at 4°C overnight.")
        )
      )
    )
    ),
    part2 = list(
      card_II_4 = list(type = "value_box", 
                       title = "Wash the beads by adding 250 ",
                       value = textOutput("fragbuffer")),
      card_II_5 = list(type = "reactableOutput", id = "lsk_II_5"),
      card_II_12 = list(type = "value_box", 
                        title = paste0("Wash the beads by adding 250 ", ul, "of the:"), 
                        value = textOutput("fragbuffer")
                        ),
      card_II_18 = list(type = "tagList", content = tagList(
        card(uiOutput("qc2_inputs"), 
             card_footer(actionButton("confirm_qc2", "Click to confirm values")))
      )),
      card_II_19 = list(type = "tagList", content = tagList(
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
      )
      
    ),
    part3 = list(
      card_III_1 = list(type = "warning",
                        body = "For optimal sequencing performance and improved output on MinION R10.4.1 flow cells (FLO-MIN114), ONT recommends adding Bovine Serum Albumin (BSA) to the flow cell priming mix at a final concentration of 0.2 mg/ml.",
                        footer = "ONT does not recommend using any other albumin type (e.g. recombinant human serum albumin)."
      ),
      card_III_2 = list(type = "gt_output", id = "mn_III_2"),
      card_III_3 = list(type = "img_x2", 
                        image1 = "mn_III_3_a",
                        image2 = "mn_III_3_b"
      ),
      card_III_4 = list(type = "img_captioned",
                        class = "bg-warning",
                        caption = "Take care when drawing back buffer from the flow cell. Do not remove more than 20-30 µl, and make sure that the array of pores are covered by buffer at all times. Introducing air bubbles into the array can irreversibly damage pores.",
                        image = "mn_III_4"),
      card_III_5 = list(type = "illustration", 
                        image = "mn_III_5"),
      card_III_6 = list(type = "illustration", image = "mn_III_6"),
      card_III_7 = rapid16s$part3$card_III_7,
      card_III_9 = list(type = "img_x2", 
                        image1 = "mn_III_9_a", 
                        image2 = "mn_III_9_b"),
      card_III_11 = list(type = "illustration", 
                        image = "mn_III_11"),
      card_III_12 = list(type = "tagList",
                         content = tagList(
                           render_illustration_x2("mn_III_12_a", "mn_III_12_b"),
                           card(class = "bg-warning", card_header("IMPORTANT"),
                                "Install the light shield on your flow cell as soon as library has been loaded for optimal sequencing output.",
                                card_footer("ONT recommends leaving the light shield on the flow cell when library is loaded, including during any washing and reloading steps. The shield can be removed when the library has been removed from the flow cell.")
                           )
                          )
                         ),
      card_III_13 = list(type = "img_captioned",
                        class = "bg-warning",
                        caption = "The MinION Flow Cell Light Shield is not secured to the flow cell and careful handling is required after installation.",
                        image = "mn_III_13")
    )
  )
  
)
