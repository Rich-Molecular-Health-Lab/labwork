
colDefs <- list(
steps_remaining     = colDef(name = "Sample State"             , sticky = "left"),
ExtractID           = colDef(name = "DNA Extract"              , aggregate = "count", sticky = "left"),
Subject             = colDef(name = "Subject Name"             , aggregate = "frequency"),
Subj_Certainty      = colDef(name = "Subj ID Certain?"         ),
CollectionDate      = colDef(name = "Date Collected"           , aggregate = "count", format = colFormat(date = TRUE)),
ExtractConc         = colDef(name = "DNA Concentration (ng/ul)", aggregate = "max"  , format = colFormat(digits = 2)),
ExtractBox          = colDef(name = "Box No."),
LibraryTube         = colDef(name = "Tube No."),
LibraryCode         = colDef(name = "Pooled Library ID"),
SequenceID          = colDef(name = "Sequence Output"),
Barcode             = colDef(name = "Barcode"),
BarcodePos          = colDef(name = "Barcode Plate Position")   ,
TemplateVolPrep     = colDef(name = "Template volume for first rxn"         ,format = colFormat(suffix = ul  , digits = 2)),          
ExtractInputVol     = colDef(name = "Volume extract to start with"          ,format = colFormat(suffix = ul  , digits = 2)),          
ExtractDiluteWater  = colDef(name = "Volume to dilute extract"              ,format = colFormat(suffix = ul  , digits = 2)),
Conc_QC2            = colDef(name = "Final Concentration"                   ,format = colFormat(suffix = ngul, digits = 2)),           
SampVolPool         = colDef(name = "Volume to add to Pool"                 ,format = colFormat(suffix = ul  , digits = 2)),     
TemplateVolLoading  = colDef(name = "Volume to load on flow cell"           ,format = colFormat(suffix = ul  , digits = 2)),    
LibraryLoadingVol   = colDef(name = "Volume library to include"             ,format = colFormat(suffix = ul  , digits = 2)),           
LibraryWaterVol     = colDef(name = "Volume to dilute final library"        ,format = colFormat(suffix = ul  , digits = 2)),
BeadVol             = colDef(name = "Volume beads to add to pooled library" ,format = colFormat(suffix = ul  , digits = 2)),    
TotalPoolVol        = colDef(name = "Library volume after pooling"          ,format = colFormat(suffix = ul  , digits = 2)),
column              = colDef(name = "8-well Strip/Column"),
row_A               = colDef(name = "Row A"),
row_B               = colDef(name = "Row B"),
row_C               = colDef(name = "Row C"),
row_D               = colDef(name = "Row D"),
row_E               = colDef(name = "Row E"),
row_F               = colDef(name = "Row F"),
row_G               = colDef(name = "Row G"),
row_H               = colDef(name = "Row H")
)

colGroups <- list(
  barcodes = colGroup(
             name    = "Barcodes (N = 24)", 
             columns = c("row_A", 
                         "row_B", 
                         "row_C", 
                         "row_D", 
                         "row_E", 
                         "row_F", 
                         "row_G", 
                         "row_H")
             )
  )