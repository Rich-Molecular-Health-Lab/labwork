cleanup_pooled  <- list(
  list(
    step     = "Resuspend the AMPure XP Beads (AXP) by vortexing.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Use the dynamic value box below to add the proper volume of resuspended AMPure XP Beads (AXP) to the entire pooled barcoded sample.",
    note     = NULL,
    substeps = list("Mix by flicking the tube."),
    element  = tagList(value_box(
      title = "Volume of AMPure XP Beads (AXP) added",
      value = textOutput("pooled_bead_vol"),
      showcase = icon("vial-circle-check")
    ))
  ),
  list(
    step     = "Incubate on a Hula mixer (rotator mixer) at room temperature according to the time shown below.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(value_box(
      title = "Incubation time (minutes)",
      value = textOutput("pooled_cleanup_incubation"),
      showcase = icon("stopwatch")
    ))
    ),
  list(
    step     = "Prepare at least 2 ml of fresh 80% ethanol in nuclease-free water.",
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
    step     = "Keep the tube on the magnet and wash the beads with 1 ml of freshly prepared 80% ethanol without disturbing the pellet.",
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
    step     = "Remove the tube from the magnetic rack and resuspend the pellet by pipetting in 15 µl Elution Buffer (EB).",
    note     = NULL,
    substeps = list("Incubate at room temperature according to the time shown below.."),
    element  = tagList(value_box(
      title = "Incubation time (minutes)",
      value = textOutput("pooled_cleanup_incubation"),
      showcase = icon("stopwatch")
    ))
  ),
  list(
    step     = "Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Remove and retain the full volume of eluate into a clean 1.5 ml Eppendorf DNA LoBind tube.",
    note     = NULL,
    substeps = list("Remove and retain the eluate which contains the DNA library in a clean 1.5 ml Eppendorf DNA LoBind tube.",
                    "Dispose of the pelleted beads."),
    element  = tagList(NULL)
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))