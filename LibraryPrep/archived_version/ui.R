# /LibraryPrep/ui/ui.R


ui <- page_fillable(
  useShinyjs(),
  navset_tab(
    id = "setup.nav",
    workflow_tab(), 
    samples_tab(),
    barcodes(),
    lsk_input_tab(),
    setup_tab(),
    conclude_tab()
    ),
  navset_tab(
    id = "main.nav", 
      part1_tab(),
      part2_tab(),
      part3_tab()
  ))