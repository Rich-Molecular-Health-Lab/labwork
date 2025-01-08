# /LibraryPrep/server/reactable_columns.R

source(paste0(path$global_cols))

cols_extract_prep <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(name = "Barcode Plate Position"),        
  ExtractID           = colDef(name = "DNA Extract ID"),              
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
  LibraryWaterVol     = colDef(show = FALSE)   ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)   ,
  .selection          = colDef(name = "Check when dilution prepared", sticky = "left")
)

cols_part1_rap16s <- list(
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(name = "Barcode"),               
  BarcodePos          = colDef(show = FALSE)   ,   
  ExtractID           = colDef(show = FALSE)   ,     
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul)) ,     
  TemplateVolPrep     = colDef(show = FALSE)   ,
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
  LibraryWaterVol     = colDef(show = FALSE)   ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)   
)




cols_part2_rap16s <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(show = FALSE)   ,          
  BarcodePos          = colDef(show = FALSE)   ,   
  ExtractID           = colDef(show = FALSE)   ,     
  ExtractConc         = colDef(show = FALSE)   ,        
  TemplateVolPrep     = colDef(show = FALSE)   ,
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(show = FALSE)   ,                 
  ExtractDiluteWater  = colDef(show = FALSE)   ,             
  Conc_QC1            = colDef(name = "QC1 Concentration"                     ,format = colFormat(suffix = ngul)) ,                      
  Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul)) ,            
  SampVolPool         = colDef(name = "Volume to add to Pool"                 ,format = colFormat(suffix = ul)) ,      
  TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul)) ,     
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul)) ,            
  LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul)) ,
  BeadVol             = colDef(name = "Volume beads to add to pooled library" ,format = colFormat(suffix = ul)) ,     
  TotalPoolVol        = colDef(name = "Library volume after pooling"          ,format = colFormat(suffix = ul)) 
)


cols_pooling <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(show = FALSE)   ,    
  BarcodePos          = colDef(show = FALSE)   ,   
  ExtractID           = colDef(show = FALSE)   ,     
  ExtractConc         = colDef(show = FALSE)   ,   
  TemplateVolPrep     = colDef(show = FALSE)   ,
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(show = FALSE)   ,             
  ExtractDiluteWater  = colDef(show = FALSE)   ,         
  Conc_QC1            = colDef(name = "QC1 Concentration"              ,format = colFormat(suffix = ngul)) ,                      
  Conc_QC2            = colDef(show = FALSE)   ,          
  SampVolPool         = colDef(name = "Volume to add to Pool"          ,format = colFormat(suffix = ul)) ,      
  TemplateVolLoading  = colDef(show = FALSE)   ,  
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(show = FALSE)   ,            
  LibraryWaterVol     = colDef(show = FALSE)   ,  
  BeadVol             = colDef(name = "Volume beads to add to pooled library" ,format = colFormat(suffix = ul)) ,     
  TotalPoolVol        = colDef(name = "Library volume after pooling"          ,format = colFormat(suffix = ul)) 
)


cols_part1_lsk <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(show = FALSE)   ,       
  BarcodePos          = colDef(show = FALSE)   ,   
  ExtractID           = colDef(show = FALSE)   ,     
  ExtractConc         = colDef(name = "Extract Concentration", format = colFormat(suffix = ngul)) ,     
  TemplateVolPrep     = colDef(show = FALSE)   ,
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
  LibraryWaterVol     = colDef(show = FALSE)   ,
  BeadVol             = colDef(show = FALSE)   ,  
  TotalPoolVol        = colDef(show = FALSE)   
)

cols_part2_lsk <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(show = FALSE)   ,          
  BarcodePos          = colDef(show = FALSE)   ,   
  ExtractID           = colDef(show = FALSE)   ,     
  ExtractConc         = colDef(show = FALSE)   ,        
  TemplateVolPrep     = colDef(show = FALSE)   ,
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(show = FALSE)   ,                 
  ExtractDiluteWater  = colDef(show = FALSE)   ,             
  Conc_QC1            = colDef(name = "QC1 Concentration"                     ,format = colFormat(suffix = ngul)) ,                      
  Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul)) ,            
  SampVolPool         = colDef(show = FALSE)   ,                  
  TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul)) ,     
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul)) ,            
  LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul)) ,
  BeadVol             = colDef(show = FALSE)   ,                  
  TotalPoolVol        = colDef(show = FALSE)               
)

cols_part3 <- list(  
  LibraryTube         = colDef(name = "Tube No.")  ,
  SequenceID          = colDef(name = "Sequenced Output ID"),
  Barcode             = colDef(show = FALSE)   ,          
  BarcodePos          = colDef(show = FALSE)   ,   
  ExtractID           = colDef(show = FALSE)   ,     
  ExtractConc         = colDef(show = FALSE)   ,        
  TemplateVolPrep     = colDef(show = FALSE)   ,
  Length              = colDef(show = FALSE)   ,
  InputMassStart      = colDef(show = FALSE)   ,  
  ExtractInputVol     = colDef(show = FALSE)   ,                 
  ExtractDiluteWater  = colDef(show = FALSE)   ,             
  Conc_QC1            = colDef(show = FALSE)   ,                               
  Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul)) ,            
  SampVolPool         = colDef(show = FALSE)   ,                  
  TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul)) ,     
  InputMassFinal      = colDef(show = FALSE)   ,     
  LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul)) ,            
  LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul)) ,
  BeadVol             = colDef(show = FALSE)   ,                  
  TotalPoolVol        = colDef(show = FALSE)    
)

