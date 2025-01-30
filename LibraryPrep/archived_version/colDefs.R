samples_select <- list(
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

cols_barcodes <- list(
  column     = colDef(name = "8-well Strip/Column"),
  row_A      = colDef(name = "Row A"),
  row_B      = colDef(name = "Row B"),
  row_C      = colDef(name = "Row C"),
  row_D      = colDef(name = "Row D"),
  row_E      = colDef(name = "Row E"),
  row_F      = colDef(name = "Row F"),
  row_G      = colDef(name = "Row G"),
  row_H      = colDef(name = "Row H"),
  .selection = colDef(name =  "Select strips/columns", sticky = "left")
)

groups_barcodes <- list(
  colGroup(name    = "Barcodes (N = 24)", 
           columns = c("row_A", 
                       "row_B", 
                       "row_C", 
                       "row_D", 
                       "row_E", 
                       "row_F", 
                       "row_G", 
                       "row_H"))
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
  Length              = colDef(show = FALSE),
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


cols_rap16s_I_1 <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(show = FALSE),
  SequenceID          = colDef(show = FALSE),
  ExtractID           = colDef(name = "DNA Extract"),    
  ExtractBox          = colDef(show = FALSE),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(name = "Barcode Plate Position"),             
  ExtractConc         = colDef(show = FALSE) ,     
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
  LibraryWaterVol     = colDef(show = FALSE)   ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)   
)

cols_rxns <-  list(
  Reagent           = colDef(name = "Reagent"),
  Volume_rxn        = colDef(name = "Volume per Rxn", format = colFormat(suffix = ul,   digits = 1))  ,
  N_rxns            = colDef(name = "N Rxns"        , format = colFormat(digits = 0))  ,
  Volume_total      = colDef(name = "Total Volume"  , format = colFormat(suffix = ul,   digits = 1))  ,  
  .selection        = colDef(name = "Check when added", sticky = "left")
)

cols_rap16s_II_5 <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(show = FALSE),    
  ExtractBox          = colDef(show = FALSE),
  Barcode             = colDef(show = FALSE),               
  BarcodePos          = colDef(show = FALSE),                   
  ExtractConc         = colDef(show = FALSE) ,     
  TemplateVolPrep     = colDef(show = FALSE) ,             
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(show = FALSE) ,             
  ExtractDiluteWater  = colDef(show = FALSE) ,             
  Conc_QC1            = colDef(show = FALSE) ,                      
  Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul, digits = 2)) ,            
  SampVolPool         = colDef(name = "Volume to add to Pool"                 ,format = colFormat(suffix = ul, digits = 2)) ,      
  TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul, digits = 2)) ,     
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul, digits = 2)) ,            
  LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul, digits = 2)) ,
  BeadVol             = colDef(name = "Volume beads to add to pooled library" ,format = colFormat(suffix = ul, digits = 2)) ,     
  TotalPoolVol        = colDef(name = "Library volume after pooling"          ,format = colFormat(suffix = ul, digits = 2)) 
)

cols_lsk_II_19 <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(show = FALSE),    
  ExtractBox          = colDef(show = FALSE),
  Barcode             = colDef(show = FALSE),               
  BarcodePos          = colDef(show = FALSE),                   
  ExtractConc         = colDef(show = FALSE) ,     
  TemplateVolPrep     = colDef(show = FALSE) ,             
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(show = FALSE) ,             
  ExtractDiluteWater  = colDef(show = FALSE) ,             
  Conc_QC1            = colDef(show = FALSE) ,                      
  Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul, digits = 2)) ,            
  SampVolPool         = colDef(show = FALSE) ,      
  TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul, digits = 2)) ,     
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul, digits = 2)) ,            
  LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul, digits = 2)) ,
  BeadVol             = colDef(show = FALSE) ,     
  TotalPoolVol        = colDef(show = FALSE) 
)
