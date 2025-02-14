endprep_lsk  <- list(
  list(
    step     = "Prepare DNA Control Sample (Optional)",
    note     = NULL,
    substeps = list("Thaw DNA Control Sample (DCS) at room temperature.",
                    "Spin down.",
                    "Mix by pipetting.",
                    "Place on ice."),
    element  = tagList(value_box(
      title    = "Tip",
      value    = "ONT recommends using the DNA Control Sample (DCS) in your library prep for troubleshooting purposes. However, you can omit this step and make up the extra 1 µl with your sample DNA.",
      showcase = icon("hand-pointer")
    ))
  ),
  list(
    step     = "Prepare the NEB reagents in accordance with manufacturer’s instructions (see below), and place on ice.",
    note     = NULL,
    substeps = list("Thaw all reagents on ice.",
                    "Flick and/or invert the reagent tubes to ensure they are well mixed (Note: Do not vortex the FFPE DNA Repair Mix or Ultra II End Prep Enzyme Mix.).",
                    "Always spin down tubes before opening for the first time each day.",
                    "Vortex the FFPE DNA Repair Buffer v2, or the NEBNext FFPE DNA Repair Buffer and Ultra II End Prep Reaction Buffer to ensure they are well mixed (Note: These buffers may contain a white precipitate. If this occurs, allow the mixture(s) to come to room temperature and pipette the buffer several times to break up the precipitate, followed by a quick vortex to mix.).",
                    "The FFPE DNA Repair Buffer may have a yellow tinge and is fine to use if yellow."
                    ),
    element  = tagList(NULL)
  ),
  list(
    step     = "Prepare the DNA in nuclease-free water.",
    note     = NULL,
    substeps = list("Transfer 1 μg (or 100-200 fmol) input DNA into a 1.5 ml Eppendorf DNA LoBind tube according to the dynamic table below.",
                    "Adjust the volume to 47 μl with nuclease-free water.",
                    "Mix thoroughly by pipetting up and down, or by flicking the tube.",
                    "Spin down briefly in a microfuge."),
    element  = tagList(reactableOutput("dna_dilutions"))
  ),
  list(
    step     = "Prepare the reaction mix according to the volumes in the table below.",
    note     = NULL,
    substeps = list("Add 13 µl of the reaction mix to [each] tube",
                    "Add 47 µl DNA from the previous step to [each] tube"),
    element  = tagList(reactableOutput("endprep_rxn"))
  ),
  list(
    step     = "Thoroughly mix the reaction by gently pipetting and briefly spinning down.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Using a thermal cycler, incubate at 20°C for 5 minutes and 65°C for 5 minutes.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))
