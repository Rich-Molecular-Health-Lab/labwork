# /LibraryPrep/server/reactable_columns.R

source(global$global_cols)

cols_extract_prep <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(name = "DNA Extract"),    
  ExtractBox          = colDef(name = "Box No."),
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
  TotalPoolVol        = colDef(show = FALSE)   ,
  .selection          = colDef(name = "Check when dilution prepared", sticky = "left")
)

cols_part1_rap16s <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(name = "DNA Extract"),    
  ExtractBox          = colDef(name = "Box No."),
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




cols_part2_rap16s <- list(  
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
  Conc_QC1            = colDef(name = "QC1 Concentration"                     ,format = colFormat(suffix = ngul, digits = 2)) ,                      
  Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul, digits = 2)) ,            
  SampVolPool         = colDef(name = "Volume to add to Pool"                 ,format = colFormat(suffix = ul, digits = 2)) ,      
  TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul, digits = 2)) ,     
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul, digits = 2)) ,            
  LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul, digits = 2)) ,
  BeadVol             = colDef(name = "Volume beads to add to pooled library" ,format = colFormat(suffix = ul, digits = 2)) ,     
  TotalPoolVol        = colDef(name = "Library volume after pooling"          ,format = colFormat(suffix = ul, digits = 2)) 
)


cols_pooling <- list(  
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


cols_part1_lsk <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  LibraryCode         = colDef(name = "Pooled Library ID"),
  SequenceID          = colDef(name = "Sequence Output"),
  ExtractID           = colDef(name = "DNA Extract"),    
  ExtractBox          = colDef(name = "Box No."),
  Barcode             = colDef(show = FALSE),               
  BarcodePos          = colDef(show = FALSE),                   
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

cols_part2_lsk <- list(  
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
  BeadVol             = colDef(name = "Volume beads to add to pooled library" ,format = colFormat(suffix = ul, digits = 2)) ,     
  TotalPoolVol        = colDef(name = "Library volume after pooling"          ,format = colFormat(suffix = ul, digits = 2))     
)

cols_part3 <- list(  
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

