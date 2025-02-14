cleanup_adapter <- list(
  list(
    step     = "Resuspend the AMPure XP Beads (AXP) by vortexing.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Add 40 µl of resuspended the AMPure XP Beads (AXP) to the adapter reaction and mix by flicking the tube.",
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
    step     = "Spin down the sample and pellet on a magnet until supernatant is clear and colorless.",
    note     = NULL,
    substeps = list("Keep the tube on the magnet, and pipette off the supernatant."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Keep the tube on the magnet and wash the beads by adding either 250 μl Long Fragment Buffer (LFB) or 250 μl Short Fragment Buffer (SFB) without disturbing the pellet.",
    note     = NULL,
    substeps = list("Flick the beads to resuspend, spin down, then return the tube to the magnetic rack and allow the beads to pellet.",
                    "Remove the supernatant using a pipette and discard."),
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
    step     = "Remove the tube from the magnetic rack and resuspend the pellet in 15 µl Elution Buffer (EB).",
    note     = "For high molecular weight DNA, incubating at 37°C can improve the recovery of long fragments.",
    substeps = list("Spin down and incubate at for 10 minutes at room temperature"),
    element  = tagList(NULL)
  ),
  list(
    step     = "Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Remove and retain 15 µl of eluate into a clean 1.5 ml Eppendorf DNA LoBind tube.",
    note     = NULL,
    substeps = list("Remove and retain the eluate which contains the DNA library in a clean 1.5 ml Eppendorf DNA LoBind tube.",
                    "Dispose of the pelleted beads."),
    element  = tagList(NULL)
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))