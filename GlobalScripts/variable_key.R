selected <- list(
  ExtractID       =  "unique id for each (DNA) extract",
  ExtractConc     = "DNA concentration in ng/ul taken from post-extraction QC"
)

assigned <- list(
  LibraryTube         = "unique number for each tube run per sequencing run",
  Barcode             = "unique barcode for each multiplexed tube",
  BarcodePos          = "position of selected barcode on kit plate",
  TemplateVolPrep     = "total volume (ul) of template + water added in first rxn of library prep",
  Length              = "estimated length of target DNA sequence",
  InputMassStart      = "recommended input mass of DNA for library prep step 1",  
  TemplateVolLoading  = "Total volume (ul) solution to load onto library after all library prep is complete",
  InputMassFinal      = "recommended input mass of DNA when loading final library onto flow cell",
)

calculated <- list(
  SequenceID          = "unique id for each sequencing run per sample",
  ExtractInputVol     = "volume (ul) DNA extract to add to water for dilution before adding TemplateVolPrep to first rxn",
  ExtractDiluteWater  = "volume (ul) water to use when diluting DNA Extracts before adding TemplateVolPrep to first rxn",
  SampVolPool         = "volume (ul) of sample to add after barcoding when pooling sample",
  LibraryLoadingVol   = "volume (ul) of final library to add to water for dilution before loading flow cell",
  LibraryWaterVol     = "volume (ul) water to use when diluting final library before loading flow cell",
  BeadVol             = "volume (ul) AmPure Beads to add to pooled library during final cleanup step",
  TotalPoolVol        = "intial volume (ul) of pooled samples before proceeding to final library cleanup step",
)

value.input <- list(
  LibraryCode     = "unique id for each pooled library", 
  Conc_QC1        = "DNA concentration in ng/ul measured via Qubit after initial step in Library Prep",
  Conc_QC2        = "DNA concentration in ng/ul measured via Qubit for final (pooled or singlplex) library before flow cell loading",
)

selection.vars <- list(
  "ExtractID"         ,
  "Subject"          ,
  "Subj_Certainty"  ,
  "CollectionDate"    , 
  "ExtractConc"      ,  
  "steps_remaining"   ,
  "ExtractBox"       
)


report.vars <- list(
  "SequenceID"       ,  
  "ExtractID"        ,
  "SampleID"         ,  
  "LibraryCode"      ,  
  "LibraryBarcode"   ,  
  "TotalPoolVol"     ,  
  "Conc_QC2"         ,  
  "FlowCellSerial"   ,  
  "SeqRunID"         ,  
  "LibPrepDate"      ,  
  "LibPrepKit"       ,  
  "FlongleAdapter"   ,  
  "strands"          ,  
  "Length"           ,  
  "TemplateVolPrep"  ,  
  "InputMassFinal"   ,  
  "LibraryTube"       ,
  "SampVolPool"       ,
  "BeadVol"           ,
  "SeqDate"           ,
  "SampleSet"         ,
  "LibPrepWorkflow"   ,
  "FlowCellType"      ,
  "SeqDevice"         ,
  "fragment_type"     ,
  "InputMassStart"    ,
  "PoolSamples"       ,
)

minion.vars <- list(
  "reads_unclassified",
  "protocol_group_id" ,
  "SeqDateTime"      
)