adapter_rapid  <- list(
  list(
    step     = "Transfer 11 µl of pooled, barcoded sample into a clean 1.5 ml Eppendorf DNA LoBind tube.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "In a fresh 1.5 ml Eppendorf DNA LoBind tube, dilute the Rapid Adapter (RA) as follows and pipette mix.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(reactableOutput("rapid_adapter_mix"))
  ),
  list(
    step     = "Add 1 µl of the diluted Rapid Adapter (RA) to the barcoded DNA.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Mix gently by flicking the tube, and spin down.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Incubate the reaction for 5 minutes at room temperature.",
    note     = "Tip: While this incubation step is taking place you can proceed to the Flow Cell priming and loading section of the protocol.",
    substeps = list(NULL),
    element  = tagList(value_box(
      title    = "End of Step",
      value    = "The prepared library is used for loading into the flow cell. Store the library on ice until ready to load.",
      showcase = icon("circle-stop")
    ))
  )
)  %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))