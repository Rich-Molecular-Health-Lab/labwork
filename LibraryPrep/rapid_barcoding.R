barcoding_rapid  <- list(
  list(
    step     = "Program the thermal cycler.",
    note     = NULL,
    substeps = list("30°C for 2 minutes.", "80°C for 2 minutes."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Thaw kit components at room temperature, spin down briefly using a microfuge and mix by pipetting as indicated by the table below:",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(reactableOutput("rapid_reagents"))
  ),
  list(
    step     = "Prepare the DNA in nuclease-free water.",
    note     = NULL,
    substeps = list("Transfer 200 ng of genomic DNA per sample into 0.2 ml thin-walled PCR tubes.",
                    "Adjust the volume of each sample to 10 μl with nuclease-free water.",
                    "Pipette mix the tubes thoroughly and spin down briefly in a microfuge."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Select a unique barcode for every sample to be run together on the same flow cell.",
    note     = "Use one barcode per sample.",
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "In the 0.2 ml thin-walled PCR tubes mix the following:",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(reactableOutput("rapid_barcoding_mix"))
  ),
  list(
    step     = "Ensure the components are thoroughly mixed by pipetting and spin down briefly.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Incubate the tubes at 30°C for 2 minutes and then at 80°C for 2 minutes using the thermal cycler.",
    note     = NULL,
    substeps = list("Briefly put the tubes or plate on ice to cool."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Spin down the tubes to collect the liquid at the bottom.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Pool all barcoded samples in a clean 2 ml Eppendorf DNA LoBind tube.",
    note     = NULL,
    substeps = list("Enter the total volume below."),
    element  = tagList(numericInput("pooled_volume", "Enter total volume in \u+03b3L"))
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))
