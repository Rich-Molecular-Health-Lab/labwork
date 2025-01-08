# /GlobalScripts/reactable_columns.R

cols_rxns <-  list(
  Reagent           = colDef(name = "Reagent"),
  Volume_rxn        = colDef(name = "Volume per Rxn", format = colFormat(suffix = ul,   digits = 1))  ,
  Volume_total      = colDef(name = "Total Volume"  , format = colFormat(suffix = ul,   digits = 1))  ,  
  .selection        = colDef(name = "Check when added", sticky = "left")
)

cols_compilation <- list(
  SampleID            = colDef(name = "ID"),
  CollectionDate      = colDef(name = "Date Collected"     , align = "left" , sortable   = TRUE, format = colFormat(date = TRUE), aggregate = "frequency"),
  Subj_Certainty      = colDef(name = "Subj Certain?"      , align = "right", filterable = TRUE, aggregate = "unique"   , maxWidth = 80, aggregated = certainty_js, cell = certainty_r),
  Subject             = colDef(name = "Subj Name"          , align = "left" , filterable = TRUE, aggregate = "frequency", maxWidth = 80 , sortable   = TRUE),
  SampleCollectedBy   = colDef(name = "Collector"          ),
  SampleNotes         = colDef(name = "Notes"              , align = "left" , maxWidth = 200) ,
  ExtractID           = colDef(name = "ID"                 , align = "left" , sortable   = TRUE, filterable = TRUE, aggregate = "count", maxWidth = 125),
  ExtractDate         = colDef(name = "Date Done"          , align = "left" , sortable   = TRUE, aggregate = "max",format = colFormat(date = TRUE)),
  ExtractConc         = colDef(name = "Concentration"      , align = "left", filterable = TRUE, aggregate = "max", maxWidth = 125, sortable   = TRUE, format = colFormat(suffix = ngul)),
  ExtractedBy         = colDef(name = "Done by"),
  ExtractKit          = colDef(name = "Kit"),
  ExtractBox          = colDef(name = "Storage Box"        , align = "left" , maxWidth = 150) ,
  ExtractNotes        = colDef(name = "Notes"              , align = "left" , maxWidth = 200) ,
  LibraryCode         = colDef(name = "Unique Code for Run", align = "left" , sortable   = TRUE, filterable = TRUE, aggregate = "count", maxWidth = 125)  ,  
  LibPrepWorkflow     = colDef(name = "Workflow"),
  LibPrepDate         = colDef(name = "Date"                  , align = "left" , format = colFormat(date = TRUE)),           
  SequenceID          = colDef(name = "Output ID"             , align = "left" , sortable   = TRUE, filterable = TRUE, aggregate = "count", maxWidth = 125),
  LibraryTube         = colDef(name = "Tube No.")             ,
  LibraryBarcode      = colDef(name = "Barcode"               , align = "left"),                                                      
  LibraryConc_QC2     = colDef(name = "Final Concentration"   , align = "left", maxWidth = 125, format = colFormat(suffix = ngul)) ,            
  LibraryTotalPoolVol = colDef(name = "Pooled Vol"            , align = "left", format = colFormat(suffix = ul)) ,  
  .selection          = colDef(name = "Select rows to use", sticky = "left")
)

compilation_groups <- list(
  colGroup(name = "Samples Collected", columns = c("SampleID", 
                                                   "CollectionDate", 
                                                   "Subj_Certainty", 
                                                   "Subject",
                                                   "SampleCollectedBy",
                                                   "SampleNotes")),
  colGroup(name = "DNA Extracts", columns = c("ExtractID",
                                              "ExtractDate",
                                              "ExtractConc",
                                              "ExtractedBy",
                                              "ExtractKit",
                                              "ExtractBox",
                                              "ExtractNotes")),
  colGroup(name = "Sequenced Libraries", columns = c("LibraryCode",
                                                     "LibPrepWorkflow",
                                                     "LibPrepDate",
                                                     "SequenceID",
                                                     "LibraryTube",
                                                     "LibraryBarcode",
                                                     "LibraryConc_QC2",
                                                     "LibraryTotalPoolVol")))

cols_selected <- list(
  ExtractID           = colDef(name = "DNA Extract ID"     , align = "left" , sortable   = TRUE, filterable = TRUE, aggregate = "count", maxWidth = 125),
  ExtractDate         = colDef(name = "Date Extracted"     , align = "left" , sortable   = TRUE, aggregate = "max",format = colFormat(date = TRUE)),
  ExtractedBy         = colDef(name = "Done By"            , align = "left", aggregate = "unique"),
  ExtractKit          = colDef(name = "Kit"                , align = "left" , filterable = TRUE, maxWidth = 150, sortable = TRUE),
  ExtractBox          = colDef(name = "Storage Box"        , align = "left" , maxWidth = 150) ,
  ExtractNotes        = colDef(name = "Notes"              , align = "left" , maxWidth = 200) ,
  ExtractConc         = colDef(name = "Concentration"      , align = "left", filterable = TRUE, aggregate = "max", maxWidth = 125, sortable   = TRUE, format = colFormat(suffix = ngul)),
  .selection          = colDef(name =  "Select Extracts"   , sticky = "left")
)

cols_review <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(show = FALSE)   ,            
  BarcodePos          = colDef(show = FALSE)   ,            
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul)) ,     
  TemplateVolPrep     = colDef(show = FALSE)   ,               
  Length              = colDef(show = FALSE)   ,    
  InputMassStart      = colDef(show = FALSE)   ,    
  ExtractInputVol     = colDef(show = FALSE)   ,              
  ExtractDiluteWater  = colDef(show = FALSE)   ,                                           
  Conc_QC1            = colDef(show = FALSE)   ,               
  Conc_QC2            = colDef(show = FALSE)   ,       
  SampVolPool         = colDef(show = FALSE)   ,      
  TemplateVolLoading  = colDef(show = FALSE)   ,  
  InputMassFinal      = colDef(show = FALSE)   ,  
  LibraryLoadingVol   = colDef(show = FALSE)   ,            
  LibraryWaterVol     = colDef(show = FALSE)    ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)   
)

cols_calculations <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(name = "Barcode Plate Position"),                   
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul)) ,     
  TemplateVolPrep     = colDef(name = "Template volume for first rxn",format = colFormat(suffix = ul)) ,             
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(name = "Volume extract to start with",format = colFormat(suffix = ul)) ,             
  ExtractDiluteWater  = colDef(name = "Volume to dilute extract",format = colFormat(suffix = ul)) ,                                              
  Conc_QC1            = colDef(show = FALSE)   ,               
  Conc_QC2            = colDef(show = FALSE)   ,       
  SampVolPool         = colDef(show = FALSE)   ,      
  TemplateVolLoading  = colDef(show = FALSE)   ,  
  InputMassFinal      = colDef(show = FALSE)   ,  
  LibraryLoadingVol   = colDef(show = FALSE)   ,            
  LibraryWaterVol     = colDef(show = FALSE)    ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)
)

cols_setup <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(show = FALSE)   ,            
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul)) ,     
  TemplateVolPrep     = colDef(name = "Template volume for first rxn",format = colFormat(suffix = ul)) ,             
  Length              = colDef(name = "Estimated length (bp)"),
  InputMassStart      = colDef(name = "Optimal starting mass")   ,  
  ExtractInputVol     = colDef(name = "Volume extract to start with",format = colFormat(suffix = ul)) ,             
  ExtractDiluteWater  = colDef(name = "Volume to dilute extract",format = colFormat(suffix = ul)) ,                                              
  Conc_QC1            = colDef(show = FALSE)   ,               
  Conc_QC2            = colDef(show = FALSE)   ,       
  SampVolPool         = colDef(show = FALSE)   ,      
  TemplateVolLoading  = colDef(show = FALSE)   ,  
  InputMassFinal      = colDef(show = FALSE)   ,  
  LibraryLoadingVol   = colDef(show = FALSE)   ,            
  LibraryWaterVol     = colDef(show = FALSE)    ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)   
)


cols_barcodes <- list(
  column = colDef(name = "8-well Strip/Column"),
  A      = colDef(name = "Row A"),
  B      = colDef(name = "Row B"),
  C      = colDef(name = "Row C"),
  D      = colDef(name = "Row D"),
  E      = colDef(name = "Row E"),
  F      = colDef(name = "Row F"),
  G      = colDef(name = "Row G"),
  H      = colDef(name = "Row H"),
  .selection = colDef(name =  "Select strips/columns", sticky = "left")
)

groups_barcodes <- list(
  colGroup(name    = "Barcodes (N = 24)", 
           columns = c("A", "B", "C", "D", "E", "F", "G", "H"))
)

cols_barcode_wells <- list(
  column            = colDef(show = FALSE)   ,  
  row               = colDef(show = FALSE)   ,  
  BarcodePos        = colDef(name = "Barcode Plate Position"),
  Barcode           = colDef(name = "Barcode ID"),
  .selection = colDef(name =  "Select individual barcodes", sticky = "left")
)

cols_barcodes_confirmed <- list( 
  LibraryTube       = colDef(name = "Tube Number")  ,
  BarcodePos        = colDef(name = "Barcode Plate Position"),
  Barcode           = colDef(name = "Barcode ID")
)
