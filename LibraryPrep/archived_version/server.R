# /LibraryPrep/server/server.R

server <- function(input, output, session) {
  options(shiny.error = browser)
  
  session$setCurrentTheme(bs_theme(bootswatch = "lumen"))
  
  steps_parts <- reactiveValues(
    part1 = list(),
    part2 = list(),
    part3 = list()
  )
  

  setup <- reactiveValues(
    steps              = list(),
    steps_record       = list(),
    dynamic_cards      = list(),
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
      column = numeric(),
      row_A  = character(),
      row_B  = character(),
      row_C  = character(),
      row_D  = character(),
      row_E  = character(),
      row_F  = character(),
      row_G  = character(),
      row_H  = character()
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
    rxns               = list())
  
  samples    <- reactiveValues(
    compilation   = tibble(
      steps_remaining = character(),
      ExtractID       = character(),
      Subject         = character(),
      Subj_Certainty  = character(),
      CollectionDate  = as.Date(character()),
      ExtractConc     = numeric(),
      ExtractBox      = character()
    ),
    selected      = tibble(
      ExtractID           = character(),  
      ExtractConc         = numeric() ,
      ExtractBox          = character()
    ),
    controls = tibble(
      ExtractID           = "ControlLibPrep",   
      ExtractConc         = 0, 
      ExtractBox          = "None"
    ),
    calculations = tibble(
      LibraryTube         = integer(), 
      LibraryCode         = character(),
      SequenceID          = character(),  
      ExtractID           = character(),
      ExtractBox          = character(),
      Barcode             = character(),
      BarcodePos          = character(),
      ExtractConc         = numeric(),
      TemplateVolPrep     = numeric(),
      Length              = numeric(),
      InputMassStart      = numeric(),  
      ExtractInputVol     = numeric(),
      ExtractDiluteWater  = numeric(),
      Conc_QC1            = numeric(),
      Conc_QC2            = numeric(),
      SampVolPool         = numeric(),
      TemplateVolLoading  = numeric(),
      InputMassFinal      = numeric(),
      LibraryLoadingVol   = numeric(),
      LibraryWaterVol     = numeric(),
      BeadVol             = numeric(),
      TotalPoolVol        = numeric()
    )
  )
    
  
  report_params <- reactiveValues(
    setup             = list(),
    steps             = list(),
    notes             = list(),
    calculations      = tibble(),
    rxns              = tibble(
      step         = character(),
      Reagent      = character(),
      N            = numeric(),
      Volume_rxn   = numeric(),
      Volume_total = numeric()
    )
  )
  
  source(path$load_data)
  source(path$card_config)
  source(path$workflow_vals)
  source(path$helper_functions)
  source(path$steps)
  source(global$inputs)
  source(path$setup_values)
  source(path$col_defs)
  source(path$tabs)
  source(path$build_tables)
  source(path$render_text)
  source(path$configure_workflow)
  source(path$record_log)
  source(path$calculations)
  source(path$navigation)

  navigate(input, setup)
  
  render_image_list(output, image_list)

  
  observe_basics(input, setup)
  observe_steps(input, output, setup)
  setup_workflow(input, output, setup, samples, steps_parts)
  record_steps(input, output, setup)
  
  setup_lsk_values(input, setup)
  sample_selection(input, setup, samples)
  barcodes_selection(input, setup, samples)
  render_qc_inputs(input, output, setup)
  build_reactables(input, output, samples, setup)
  build_gt_tabs(output)
  render_text_outputs(input, output, setup) 
  record_notes(input, output, setup)
  record_tables(input, setup, samples, report_params)
  compile_report(input, output, report_params, setup)
  values_from_inputs(input, setup) 
  lsk_input_calculations(input, output, setup)
  volumes_from_concentrations(input, setup, samples)
  
  

  
  
  
}
