cleanup_endprep  <- list(
  list(
    step     = "Resuspend the AMPure XP Beads (AXP) by vortexing.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Transfer the DNA sample to a clean 1.5 ml Eppendorf DNA LoBind tube.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Add 60 µl of resuspended the AMPure XP Beads (AXP) to the end-prep reaction and mix by flicking the tube.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Incubate on a Hula mixer (rotator mixer) for 5 minutes at room temperature.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Prepare 500 μl of fresh 80% ethanol in nuclease-free water.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Spin down the sample and pellet on a magnet until supernatant is clear and colorless.",
    note     = NULL,
    substeps = list("Keep the tube on the magnet, and pipette off the supernatant."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Keep the tube on the magnet and wash the beads with 200 µl of freshly prepared 80% ethanol without disturbing the pellet.",
    note     = NULL,
    substeps = list("Remove the ethanol using a pipette and discard."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Repeat the previous step.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Briefly spin down and place the tube back on the magnet.",
    note     = NULL,
    substeps = list("Pipette off any residual ethanol.", 
                    "Allow to dry for 30 seconds, but do not dry the pellet to the point of cracking."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Remove the tube from the magnetic rack and resuspend the pellet in 61 µl nuclease-free water.",
    note     = NULL,
    substeps = list("Incubate at for 2 minutes at room temperature"),
    element  = tagList(NULL)
  ),
  list(
    step     = "Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Remove and retain 61 µl of eluate into a clean 1.5 ml Eppendorf DNA LoBind tube.",
    note     = NULL,
    substeps = list("Remove and retain the eluate which contains the DNA library in a clean 1.5 ml Eppendorf DNA LoBind tube.",
                    "Dispose of the pelleted beads."),
    element  = tagList(value_box(
      title    = "End of Step",
      value    = "Take forward the repaired and end-prepped DNA into the adapter ligation step. However, at this point it is also possible to store the sample at 4°C overnight.",
      showcase = icon("circle-stop")
    ))
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))