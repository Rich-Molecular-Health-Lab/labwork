# /LibraryPrep/server/server.R

server <- function(input, output, session) {
  
  session$setCurrentTheme(bs_theme(bootswatch = "lumen"))
  step_data  <- reactiveValues()

  setup <- reactiveValues(
    steps              = list(),
    workflow           = character(),
    sampleset          = character(),
    LibPrepDate        = as.Date(character()),
    LibraryCode        = character(),
    LibPrepBy          = character(),
    LibPrepAssist      = character(),
    FlowCellType       = character(),
    pores_needed       = numeric(),
    FlowCellSerial     = character(),
    SeqDevice          = character(),
    fragment_type      = numeric(),
    strands            = numeric(),
    Length             = numeric(),
    InputMassStart     = numeric(),
    TemplateVolPrep    = numeric(),
    Conc_QC2           = numeric(),
    LibraryLoadingVol  = numeric(),
    LibraryWaterVol    = numeric(),
    InputMassFinal     = numeric(),
    TemplateVolLoading = numeric(),
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
    rxns               = list(),
    summary            = tibble(
      
    )
  )
  
  control_rows <- tibble(
    ExtractID           = "ControlLibPrep", 
    ExtractDate         = NA,  
    ExtractedBy         = "None",  
    ExtractKit          = "None",  
    ExtractBox          = "None",  
    ExtractNotes        = "None",  
    ExtractConc         = 0
  )
  
  samples    <- reactiveValues(
    compilation   = tibble(
      SampleID            = character(),  
      CollectionDate      = as.Date(character()),  
      Subj_Certainty      = character(),  
      Subject             = character(),  
      SampleCollectedBy   = character(),  
      SampleNotes         = character(),  
      ExtractID           = character(),  
      ExtractDate         = as.Date(character()),  
      ExtractConc         = numeric(),  
      ExtractedBy         = character(),  
      ExtractKit          = character(),  
      ExtractBox          = character(),  
      ExtractNotes        = character(),  
      LibraryCode         = character(),  
      LibPrepWorkflow     = character(),  
      LibPrepDate         = as.Date(character()),  
      SequenceID          = character(),  
      LibraryTube         = integer(),  
      LibraryBarcode      = character(),  
      LibraryConc_QC2     = numeric(),  
      LibraryTotalPoolVol = numeric()
    ),
    selected      = tibble(
      ExtractID           = character(), 
      ExtractDate         = as.Date(character()),  
      ExtractedBy         = character(),  
      ExtractKit          = character(),  
      ExtractBox          = character(),  
      ExtractNotes        = character(),  
      ExtractConc         = numeric() 
    ),
    controls = tibble(
      ExtractID           = "ControlLibPrep", 
      ExtractDate         = NULL,  
      ExtractedBy         = "None",  
      ExtractKit          = "None",  
      ExtractBox          = "None",  
      ExtractNotes        = "None",  
      ExtractConc         = 0
    ),
    calculations = tibble(
      LibraryTube         = integer(), 
      SequenceID          = character(),  
      ExtractID           = character(), 
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
    step_data         = list(),
    steps             = list(),
    selected          = tibble(),
    libprep_output    = tibble(),
    rxns              = tibble(
      step         = character(),
      Reagent      = character(),
      N            = numeric(),
      Volume_rxn   = numeric(),
      Volume_total = numeric()
    )
  )
  
  source(paste0(path$helper_functions))
  source(paste0(path$load_data))
  source(paste0(path$inputs))
  source(paste0(path$steps))
  source(paste0(path$col_defs))
  source(paste0(path$reactives))
  source(paste0(path$dynamic_ui))
  
  switch_tabs(input, setup)
  link_tabs(input)
  render_images(output)
  workflow_reactives(input, output, setup, samples)
  observe_steps(input, output, setup, step_data)
  samples_reactives(input, output, setup, samples, report_params)
  barcode_reactives(input, output, setup, samples)
  lsk_input_reactives(input, output, setup)
  setup_reactives(input, output, setup, samples)
  part1_reactives(input, output, setup, samples)
  part2_reactives(input, output, setup, samples)
  conclude_reactives(input, output, setup, samples, report_params, step_data)
  render_dynamic_cards(input, output, setup)
  render_protocol_outputs(output, setup)
  dynamic_protocol(input, output, setup)
  
  
  
  
}
