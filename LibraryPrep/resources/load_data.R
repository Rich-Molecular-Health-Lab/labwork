# /LibraryPrep/resources/load_data.R

barcodes.24 <- tibble(
  "column" = c(1:12),
  "A"      = rep(c("01", "09", "17", "blank"), times = 3),
  "B"      = rep(c("02", "10", "18", "blank"), times = 3),
  "C"      = rep(c("03", "11", "19", "blank"), times = 3),
  "D"      = rep(c("04", "12", "20", "blank"), times = 3),
  "E"      = rep(c("05", "13", "21", "blank"), times = 3),
  "F"      = rep(c("06", "14", "22", "blank"), times = 3),
  "G"      = rep(c("07", "15", "23", "blank"), times = 3),
  "H"      = rep(c("08", "16", "24", "blank"), times = 3),
)

barcodes.24_wells <- barcodes.24 %>%
  pivot_longer(
    cols      = !column,
    names_to  = "row",
    values_to = "Barcode"
  ) %>%
  mutate(BarcodePos = paste0(row, column)) 

rxn_pcr16s  <- tibble(Reagent = c("DNA Template", 
                                  "LongAmp Hot Start Taq 2X Master Mix"), 
                      Volume_rxn = c(15, 25))

rxn_rapadapt  <- tibble(Reagent = c("Rapid Adapter (RA)", 
                                   "Adapter Buffer (ADB)"), 
                      Volume_rxn = c(1.5, 3.5)) %>%
  mutate(Volume_units = str_glue("{Volume_rxn}", " uL")) %>%
  select(
    Reagent, Volume_units
  ) %>%
  gt() %>%
  fmt_units(columns = "Volume_units") %>%
    cols_label(Volume_units = "Volume") %>%
    opt_stylize(color = "blue", style = 1)

rxn_endprep <- tibble(Reagent = c("DNA Template", 
                                  "DNA CS (optional)",
                                  "NEBNext FFPE DNA Repair Buffer v2",
                                  "NEBNext FFPE DNA Repair Mix ",
                                  "Ultra II End-prep Enzyme Mix"), 
                      Volume_rxn = c(47, 1, 7, 2, 3))
rxn_adapter <- tibble(Reagent = c("DNA Template",
                                  "Ligation Adapter (LA)",
                                  "Ligation Buffer (LNB)",
                                  "Salt-T4® DNA Ligase"), 
                      Volume_rxn = c(60, 5, 25, 10))
rxn_fcprime <- tibble(Reagent = c("Flow Cell Flush (FCF)",
                                  "Bovine Serum Albumin (BSA) at 50 mg/ml",
                                  "Flow Cell Tether (FCT)"), 
                      Volume_rxn = c(1170, 5, 30))

rxn_fcload  <- tibble(Reagent = c("DNA Template",
                                  "Sequencing Buffer (SB)",
                                  "Library Beads (LIB) mixed immediately before use"), 
                      Volume_rxn = c(12, 37.5, 25.5))

rxn_flgprime <- tibble(Reagent = c("Flow Cell Flush (FCF)",
                                  "Flow Cell Tether (FCT)"), 
                      Volume_rxn = c(1170, 3))

rxn_flgload  <- tibble(Reagent = c("DNA Template",
                                   "Sequencing Buffer (SB)",
                                   "Library Beads (LIB) mixed immediately before use"), 
                       Volume_rxn = c(5, 15, 10))

rxns_rap16s  <- list(pcr16s   = rxn_pcr16s,
                     fcprime  = rxn_flgprime,
                     fcload   = rxn_flgload)

rxns_lsk  <- list(endprep     = rxn_endprep,
                  adapter     = rxn_adapter,
                  fcprime     = rxn_fcprime,
                  fcload      = rxn_fcload)

part2_reagents_rap16s <- tibble(
  Reagent = c("Rapid Adapter (RA)",
              "Adapter Buffer (ADB)",
              "AMPure XP Beads (AXP)",
              "Elution Buffer (EB)",
              "EDTA (EDTA)"),
  Thaw = c("minus",
           "check",
           "check",
           "check",
           "check"),
  Spin = c("check",
           "check",
           "check",
           "check",
           "check"),
  Mix  = c("Pipette",
           "Vortex or Pipette",
           "Mix by vortexing immediately before use",
           "Vortex or Pipette",
           "Vortex or Pipette")
) %>%
  gt(rowname_col = "Reagent", id = "part2_reagents_rap16s") %>%
  fmt_icon(columns = c("Thaw", "Spin")) %>%
  cols_label(
    Thaw = "Thaw at Room Temperature?",
    Spin = "Spin Down Briefly?",
    Mix  = "Mix well by..."
  ) %>%
  cols_align(align = "center", columns = c("Thaw", "Spin")) %>%
  tab_header("Next Set of Reagents to Prepare:") %>%
  tab_source_note("Note: Once thawed, keep all reagents on ice.") %>%
  cols_width(
    Thaw ~ px(40),
    Spin ~ px(40)
  ) %>%
  opt_stylize(color = "blue", style = 1)


rap16s_cycles <- tibble(
  Cycle_step  = c(
    "Initial denaturation",
    "Denaturation",
    "Annealing",
    "Extension",
    "Final extension",
    "Hold"
  ),
  Temperature = c("95 degC", "95 degC", "55 degC", "65 degC" , "65 degC" , "4 degC"),
  Time        = c("60 s", "20 s", "30 s", "2 m", "5 m", "infinity"),
  N_Cycles    = c("1" , "25", "25", "25" , "1"  , "infinity")
) %>%
  gt(rowname_col = "Cycle_step", id = "rap16s_cycles") %>%
  fmt_units(columns = c("Temperature")) %>%
  fmt_units(columns = c("Time"), rows = Time != "infinity") %>%
  fmt_icon(columns = c("Time", "N_Cycles"), rows = Time == "infinity") %>%
  tab_header("Amplify using the following cycling conditions:") %>%
  tab_source_note("Note the warnings at the top of the page if you have not used the Thermal Cycler before.") %>%
  cols_align("center") %>%
  cols_width(
    stub()       ~ px(120),
    Temperature  ~ px(100),
    Time         ~ px(90),
    N_Cycles     ~ px(90)
  ) %>%
  opt_stylize(color = "blue", style = 1)


