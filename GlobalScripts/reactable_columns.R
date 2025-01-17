# /GlobalScripts/reactable_columns.R

cols_rxns <-  list(
  Reagent           = colDef(name = "Reagent"),
  Volume_rxn        = colDef(name = "Volume per Rxn", format = colFormat(suffix = ul,   digits = 1))  ,
  Volume_total      = colDef(name = "Total Volume"  , format = colFormat(suffix = ul,   digits = 1))  ,  
  .selection        = colDef(name = "Check when added", sticky = "left")
)

cols_compilation <- list(
  steps_remaining   = colDef(name = "Sample State", sticky = "left"),
  ExtractID         = colDef(name = "DNA Extract", aggregate = "count", sticky = "left"),
  Subject           = colDef(name = "Subject Name", aggregate = "frequency"),
  Subj_Certainty    = colDef(name = "Subj ID Certain?"),
  CollectionDate    = colDef(name = "Date Collected", format = colFormat(date = TRUE), aggregate = "count"), 
  ExtractConc       = colDef(name = "DNA Concentration (ng/ul)", aggregate = "max", format = colFormat(digits = 2)),  
  ExtractBox        = colDef(name = "Box No."),
  .selection        = colDef(name = "Select Extracts", sticky = "left")
)

cols_selected <- list(
  ExtractID         = colDef(name = "DNA Extract", aggregate = "count", sticky = "left"),
  ExtractConc       = colDef(name = "DNA Concentration (ng/ul)", aggregate = "max", format = colFormat(digits = 2)),    
  ExtractBox        = colDef(name = "Box No.")
)


cols_review <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(name = "DNA Extract"),    
  ExtractBox          = colDef(name = "Box No."),
  Barcode             = colDef(show = FALSE)   ,            
  BarcodePos          = colDef(show = FALSE)   ,            
  ExtractConc         = colDef(name = "DNA Concentration", format = colFormat(suffix = ngul, digits = 2)) ,     
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
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(name = "DNA Extract"),    
  ExtractBox          = colDef(show = FALSE),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(name = "Barcode Plate Position"),                   
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul, digits = 2)) ,     
  TemplateVolPrep     = colDef(name = "Template volume for first rxn",format = colFormat(suffix = ul, digits = 2)) ,             
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(name = "Volume extract to start with",format = colFormat(suffix = ul, digits = 2)) ,             
  ExtractDiluteWater  = colDef(name = "Volume to dilute extract",format = colFormat(suffix = ul, digits = 2)) ,                                              
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
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(name = "DNA Extract"),   
  ExtractBox          = colDef(name = "Box No."),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(show = FALSE)   ,            
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul, digits = 2)) ,     
  TemplateVolPrep     = colDef(name = "Template volume for first rxn",format = colFormat(suffix = ul, digits = 2)) ,             
  Length              = colDef(name = "Estimated length (bp)"),
  InputMassStart      = colDef(name = "Optimal starting mass")   ,  
  ExtractInputVol     = colDef(name = "Volume extract to start with",format = colFormat(suffix = ul, digits = 2)) ,             
  ExtractDiluteWater  = colDef(name = "Volume to dilute extract",format = colFormat(suffix = ul, digits = 2)) ,                                              
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
