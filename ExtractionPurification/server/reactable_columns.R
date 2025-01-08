# /ExtractionPurification/server/reactable_columns.R

cols_samples <- list(
  SampleID            = colDef(name = "Sample"),
  SampleCollectedBy   = colDef(name = "Collected by")   ,  
  SampleNotes         = colDef(name = "Sample Notes")   ,  
  CollectionDate      = colDef(name = "Date Collected"      , align = "left" , sortable   = TRUE, format = colFormat(date = TRUE), aggregate = "frequency"),
  Subj_Certainty      = colDef(name = "Confirmed"           , align = "right", filterable = TRUE, aggregate = "unique"   , maxWidth = 80, aggregated = certainty_js, cell = certainty_r),
  Subject             = colDef(name = "Name"                , align = "left" , filterable = TRUE, aggregate = "frequency", maxWidth = 80 , sortable   = TRUE),
  n_dna_extracts      = colDef(name = "DNA Extracts"        , align = "left" , filterable = TRUE, aggregate = "unique"   , maxWidth = 75, aggregated = checklist_js, cell = checklist_r, sortable   = TRUE),
  n_16s_sample        = colDef(name = "Libraries Sequenced" , align = "left" , filterable = TRUE, aggregate = "unique"   , maxWidth = 75, aggregated = checklist_js, cell = checklist_r, sortable   = TRUE),
  .selection          = colDef(name =  "Check Sample Rows to Include", sticky = "left")
)

groups_samples <- list(colGroup(name    = "N per Sample"       , columns = c("n_dna_extracts", "n_16s_sample")), 
                       colGroup(name    = "Subject"            , columns = c("Subject", "Subj_Certainty")))
