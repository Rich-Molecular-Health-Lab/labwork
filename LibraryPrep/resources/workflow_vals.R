setup_vals <- list(
    rapid16s = list(
      steps              = c(part1_rap16s, part2_rap16s, part3_flongle),
      workflow           = "rapid16s",
      fragment_type      = 2,
      strands            = 2,
      Length             = 1500,
      InputMassStart     = 10,
      TemplateVolLoading = 15,
      TotalPoolVol       = numeric(),
      beadvol            = numeric(),
      PoolSamples        = "Yes",
      rxns               = rxns_rapid16s
    ),
  lsk = list(
    steps              = c(part1_lsk, part2_lsk, part3_minion),
    workflow           = "lsk",
    fragment_type      = numeric(),
    strands            = numeric(),
    Length             = numeric(),
    InputMassStart     = numeric(),
    TemplateVolLoading = 12,
    TotalPoolVol       = 100,
    beadvol            = 40,
    PoolSamples        = "No",
    rxns               = rxns_lsk
  )
  )
  

barcodes <- list(
  rapid16s = tibble(
    "column"     = c(1:12),
    "row_A"      = rep(c("01", "09", "17", "blank"), times = 3),
    "row_B"      = rep(c("02", "10", "18", "blank"), times = 3),
    "row_C"      = rep(c("03", "11", "19", "blank"), times = 3),
    "row_D"      = rep(c("04", "12", "20", "blank"), times = 3),
    "row_E"      = rep(c("05", "13", "21", "blank"), times = 3),
    "row_F"      = rep(c("06", "14", "22", "blank"), times = 3),
    "row_G"      = rep(c("07", "15", "23", "blank"), times = 3),
    "row_H"      = rep(c("08", "16", "24", "blank"), times = 3),
  ),
  
  lsk = tibble(
    "column" = c("None"),
    "row_A" = c("None"),
    "row_B" = c("None"),
    "row_C" = c("None"),
    "row_D" = c("None"),
    "row_E" = c("None"),
    "row_F" = c("None"),
    "row_G" = c("None"),
    "row_H" = c("None")
  )
)