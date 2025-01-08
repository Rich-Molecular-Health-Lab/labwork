blank.libraries <- tibble(
  LibraryTube       = c(1),
  ExtractID         = c("BLANK"),
  SequenceID        = c("BLANK"),
  LibPrepDate       = c("2024-12-31"),
  Pipeline          = c("NONE"),
  LibraryBarcode    = c("NONE"),
  LibraryFinalConc  = c(0),
  LibraryCode       = c("NONE"),
  LibraryPoolVol_ul = c(0)
) %>%
  mutate(LibPrepDate = ymd(LibPrepDate))

blank.extracts <- tibble(
  SampleID       = c("BLANK"),
  CollectionDate = c("2024-12-31"),
  Subj_Certainty = c("BLANK"),
  Subject        = c("BLANK"),
  n_16s_extract  = c(0),
  n_16s_sample   = c(0),
  ExtractID      = c("BLANK"),
  ExtractDate    = c("2024-12-31"),
  ExtractConc    = c(0),
  ExtractedBy    = c("BLANK"),
  ExtractKit     = c("BLANK"),
  ExtractBox     = c("BLANK"),
  ExtractNotes   = c("BLANK")
) %>%
  mutate(CollectionDate = ymd(CollectionDate), ExtractDate = ymd(ExtractDate))


export_extracts <- function(path) {
  write.table(blank.extracts,
              path,
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}

export_libraries <- function(path) {
  write.table(blank.libraries,
              path,
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}


export_extracts(path$extracts_isolates)
export_extracts(path$extracts_bats)
export_extracts(path$extracts_envir)

export_libraries(path$libraries_isolates)
export_libraries(path$libraries_bats)
export_libraries(path$libraries_envir)

