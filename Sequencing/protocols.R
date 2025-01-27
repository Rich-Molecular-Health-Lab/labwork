sequencing <- list(
  flowcells = list(
    flongle = list(
      "name"         = "Flongle Flow Cell",
      "catalog"      = "FLO-FLG114",
      "cost"         = 810,
      "pack"         = 12,
      "storage_wks"  = 4,
      "minPores"     = 50,
      "reuse"        = "no",
      "runMaxhr"     = 24,
      "lib_ul"       = 5
      
    ),
    minion = list(
      "name"         = "Flow Cell",
      "catalog"      = "FLO-MIN114",
      "cost"         = 700,
      "pack"         = 1,
      "storage_wks"  = 12,
      "minPores"     = 800,
      "reuse"        = "yes",
      "runMaxhr"     = 72,
      "lib_ul"       = 12
      
    )
  )
)

sequencing <- list(
  prime_load = list(
    name     = "Priming and loading the flow cell",
    process  = "Prime the flow cell and load the prepared library for sequencing.",
    stop_opt = "Sequence immediately.",
    versions = list(
      flongle = list(
        name     = "Prime and Load the Flongle Flow Cell",
        process  = "Prime the flongle flow cell and load the prepared library for sequencing.",
        minutes  = 5
      ),
      flongle = list(
        name     = "Prime and Load the MinION Flow Cell",
        process  = "Prime the MinION flow cell and load the prepared library for sequencing.",
        minutes  = 5
      )
    )
  )
)