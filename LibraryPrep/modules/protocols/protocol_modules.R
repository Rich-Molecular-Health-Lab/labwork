modules <- list(
  sample_prep = list(
    default = list(
      name      = "Prepare DNA Extracts for Library Prep",
      process   = "Dilute quantified samples to reach target starting concentration for protocol.",
      stop_opt = "any",
      kits      = NULL,
      expansion = NULL
    ),
    colonies = list(
      name     = "Prepare Direct-from-Colony Samples",
      process  = "Resuspend each single colony in Tris Buffer.",
      stop_opt = "any",
      kits      = NULL,
      expansion = NULL
    ),
    cultures = list(
      name     = "Prepare Direct-from-Culture Samples for MDA",
      process  = "Incubate 4 μl cell material (supplied with PBS sc) with 3 μl Buffer D2.",
      stop_opt = "any",
      kits      = NULL,
      expansion = NULL
    )
  ),
  preamplify = list(
    default = list(
      name     = "Amplify targeted loci before library prep.",
      process  = "Use custom primers to amplify and increase concentrations of target loci.",
      stop_opt = "any",
      kits      = NULL,
      expansion = LongAmp
    ),
    tailed = list(
      name     = "Incorporate tailed primers during PCR",
      process  = "Perform a round of PCR to incoporate tailed primers before library prep.",
      stop_opt = "any",
      kits      = NULL,
      expansion = c(LongAmp, PBC096)
    ),
    barcodes = list(
      name     = "Amplify samples with ligated barcode adapters",
      process  = "Perform a round of PCR to attach barcodes to ligated barcode adapters.",
      stop_opt = "any",
      kits      = NULL,
      expansion = c(LongAmp, PBC096)
    ),
    tagment = list(
      rapid = list(
        name     = "Tagmentation for Rapid Sequencing",
        process  = "Tagment your DNA using the Fragmentation Mix.",
        stop_opt = "none",
        kits      = c(RPB114_24, RAD114),
        expansion = NULL
      )
    )
  ),
  endprep = list(
    default = list(
      name     = "DNA repair and end-prep",
      process  = "Repair the DNA and prepare the DNA ends for adapter attachment.",
      stop_opt = "4°C overnight",
      kits      = c(LSK114),
      expansion = NEBNextv2
    ),
    pooled = list(
      name     = "Post-Pooling DNA repair and end-prep",
      process  = "Repair the DNA and prepare the DNA ends for adapter attachment after barcoding and pooling samples.",
      stop_opt = "4°C overnight",
      kits      = c(LSK114),
      expansion = NEBNextv2
    )
  ),
  adapter = list(
    default = list(
      name     = "Adapter ligation",
      process  = "Attach the sequencing adapters to the DNA ends.",
      stop_opt = "Sequence asap, store at 4°C for short-term re-sequencing.",
      kits      = c(LSK114),
      expansion = NEBNextv2
    ),
    rapid = list(
      name     = "Rapid Adapter ligation",
      process  = "Attach the sequencing adapters to the DNA ends.",
      stop_opt = "Sequence asap, store at 4°C for short-term re-sequencing.",
      kits      = c(RPB114_24, rap16S114, RAD114, RBK114_24),
      expansion = NULL
    )
  ),
  barcoding = list(
    rapid = list(
      name     = "Rapid Barcode Tagmentation",
      process  = "Tagmentation of the DNA using the Rapid Barcoding Kit.",
      stop_opt = "4°C overnight",
      kits      = c(RBK114_24),
      expansion = NULL
    ),
    rapidPCR = list(
      name     = "Rapid Barcoding Amplification",
      process  = "PCR using the barcoded primer supplied in the kit.",
      stop_opt = "4°C overnight",
      kits      = c(RPB114_24),
      expansion = LongAmp
    ),
    rapid16s = list(
      name     = "Rapid Barcoding Amplification of 16S",
      process  = "Amplify the 16S gene using barcodes supplied in the kit",
      stop_opt = "4°C overnight",
      kits      = c(rap16S114),
      expansion = LongAmp
    ),
    expPCR = list(
      name     = "PCR Ligation of barcodes",
      process  = "Attach barcoding adapters to the DNA ends via PCR.",
      stop_opt = "4°C overnight",
      kits      = NULL,
      expansion = c(LongAmp, PBC096)
    )
  ),
  pooling = list(
    default = list(
      name     = "Barcoded sample pooling",
      process  = "Pooling of barcoded libraries in equaimolar ratios.",
      stop_opt = "4°C overnight",
      kits      = NULL,
      expansion = NULL
    )
  ),
  cleanup = list(
    default = list(
      name     = "AMPure XP Bead clean-up",
      process  = "Perform a library clean-up using beads.",
      stop_opt = "4°C overnight",
      kits      = c(LSK114, RPB114_24, rap16S114, RBK114_24),
      expansion = NULL
    ),
    pooled = list(
      name     = "AMPure XP Bead clean-up after Pooling",
      process  = "Perform a pooled library clean-up using 0.6x bead concentration.",
      stop_opt = "4°C overnight",
      kits      = c(RPB114_24, rap16S114, RBK114_24),
      expansion = NULL
    ),
    postMDA = list(
      name     = "AMPure XP Bead clean-up of MDA Products",
      process  = "Treat the products with T7 endonuclease I and clean-up using beads and custom buffer.",
      stop_opt = "4°C overnight",
      kits      = c(LSK114, RPB114_24),
      expansion = T7endo
    ),
  qc = list(
    default = list(
      name     = "DNA Quantification",
      process  = "Measure DNA concentration using Qubit assay kit and fluorometer.",
      stop_opt = "any",
      kits      = dsDNAqubit,
      expansion = NULL
      )
    )
  )
)