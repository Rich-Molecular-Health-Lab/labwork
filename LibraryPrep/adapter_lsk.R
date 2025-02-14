adapter_lsk  <- list(
  list(
    step     = "Spin down the Ligation Adapter (LA) and Salt-T4® DNA Ligase, and place on ice.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Thaw Ligation Buffer (LNB) at room temperature, spin down and mix by pipetting.",
    note     = "Due to viscosity, vortexing this buffer is ineffective.",
    substeps = list("Place on ice immediately after thawing and mixing."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Thaw the Elution Buffer (EB) at room temperature and mix by vortexing.",
    note     = NULL,
    substeps = list("Then spin down and place on ice."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Thaw either Long Fragment Buffer (LFB) or Short Fragment Buffer (SFB) at room temperature and mix by vortexing.",
    note     = NULL,
    substeps = list("Then spin down and keep at room temperature."),
    element  = tagList(value_box(
      title = "Important",
      value = "Depending on the wash buffer (LFB or SFB) used, the clean-up step after adapter ligation is designed to either enrich for DNA fragments of >3 kb, or purify all fragments equally.",
      "To enrich for DNA fragments of 3 kb or longer, use Long Fragment Buffer (LFB)",
      "To retain DNA fragments of all sizes, use Short Fragment Buffer (SFB)",
      showcase = icon("triangle-exclamation")
    ))
  ),
  list(
    step     = "In a fresh 1.5 ml Eppendorf DNA LoBind tube (one per sample), add each of the reagents below in the order shown.",
    note     = NULL,
    substeps = list("Pipette mix 10-20 times between each addition"),
    element  = tagList(reactableOutput("lsk_adapter_mix"))
  ),
  list(
    step     = "Thoroughly mix the reaction by gently pipetting and briefly spinning down.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Incubate the reaction for 10 minutes at room temperature.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  )
)  %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))