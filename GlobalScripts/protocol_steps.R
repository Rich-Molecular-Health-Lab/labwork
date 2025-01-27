 list(
   sample_prep = list(
     name     = "Sample Preparation",
     process  = "Prepare samples for library prep.",
     stop_opt = "any",
     consumables = list(
       "Nuclease-free water",
       "1 M Tris Buffer, pH8 (colonies only)",
       "Single colony culture of ~2-3 mm grown overnight on an agar plate (colonies only).",
       "Buffer D2 (cultures only)",
       "Cells stored in PBS (cultures only)"
     ),
     equipment = list(
       "Incubator (colonies or cultures only)",
       "Vortex",
       "Microfuge (colonies or cultures only)"
     ),
     versions = list(
       default = list(
         name     = "Prepare DNA Extracts for Library Prep",
         process  = "Dilute quantified samples to reach target starting concentration for protocol.",
         minutes  = 5
       ),
       colonies = list(
         name     = "Prepare Direct-from-Colony Samples",
         process  = "Resuspend each single colony in Tris Buffer.",
         minutes  = 5
       ),
       cultures = list(
         name     = "Prepare Direct-from-Culture Samples for MDA",
         process  = "Incubate 4 μl cell material (supplied with PBS sc) with 3 μl Buffer D2.",
         minutes  = 10
       )
     )
   ),
   REPLIgMDA = list(
     name     = "Multiple Displacement Amplification (MDA)",
     process  = "Amplify the genomic DNA using random hexamer primers.",
     stop_opt = "any",,
     consumables = list(
       "REPLI-g sc DNA Polymerase (sc only)",
       "Buffer DLB",
       "Buffer D2",
       "REPLI-g sc Reaction Buffer (sc only)",
       "Stop Solution"
     ),
     equipment = list(
       "Thermal cycler"
     ),
     versions = list(
       sc = list(
         name     = "Prepare DNA Extracts for Library Prep",
         process  = "Amplify very low input DNA amounts from single cells or colonies using random hexamer primers.",
         minutes  = 5
       ),
       mt = list(
         name     = "Prepare DNA Extracts for Library Prep",
         process  = "Amplify very low input DNA amounts using random hexamer primers to target whole mtDNA genomes.",
         minutes  = 5
       )
     )
   ),
   preamplify = list(
     name     = "PCR amplification",
     process  = "Amplify low-yield samples before library prep.",
     stop_opt = "any",
     consumables = list(
       "Primers",
       "LongAmp Hot Start Taq 2X Master Mix"
     ),
     equipment = list(
       "Thermal cycler"
     ),
     versions = list(
       default = list(
         name     = "Amplify targeted loci before library prep.",
         process  = "Use custom primers to amplify and increase concentrations of target loci.",
         minutes  = 20
       ),
       tailed = list(
         name     = "Incorporate tailed primers during PCR",
         process  = "Perform a round of PCR to incoporate tailed primers before library prep.",
         minutes  = 35
       ),
       barcodes = list(
         name     = "Amplify samples with ligated barcode adapters",
         process  = "Perform a round of PCR to attach barcodes to ligated barcode adapters.",
         minutes  = 40
       )
     )
   ),
   tagment = list(
     name     = "Tagmentation",
     process  = "Tagment your DNA.",
     stop_opt = "none",
     consumables = list(
       "Fragmentation Mix"
     ),
     equipment = list(
       "Microfuge",
       "Thermal Cycler"
     ),
     versions = list(
       default = list(
         name     = "Tagmentation for Rapid Sequencing",
         process  = "Tagment your DNA using the Fragmentation Mix.",
         minutes  = 5
       )
     )
   ),
  endprep = list(
    name     = "DNA End-prep",
    process  = "Repair the DNA and prepare the DNA ends for adapter attachment.",
    stop_opt = "4°C overnight",
    consumables = list(
      "NEBNext® FFPE DNA Repair Mix (M6630) from the NEBNext® Companion Module v2",
      "NEBNext® FFPE DNA Repair Buffer v2 (E7363) from the NEBNext® Companion Module v2",
      "NEBNext® Ultra II End Prep Enzyme Mix (E7646) from the NEBNext® Companion Module v2"
    ),
    equipment = list(
      "Thermal cycler"
    ),
    versions = list(
      default = list(
        name     = "DNA repair and end-prep",
        process  = "Repair the DNA and prepare the DNA ends for adapter attachment.",
        minutes  = 35
      ),
      pooled = list(
        name     = "Pooled DNA repair and end-prep",
        process  = "Repair the DNA and prepare the DNA ends for adapter attachment after barcoding and pooling.",
        minutes  = 35
      )
    )
  ),
  adapter = list(
    name     = "Adapter Ligation",
    process  = "Attach the sequencing adapters to the DNA ends.",
    stop_opt = "Sequence asap, store at 4°C for short-term re-sequencing.",
    consumables = list(
      "(Rapid or Ligation) Adapter",
      "(Rapid or Ligation) Adapter Buffer",
      "Elution Buffer",
      "Salt-T4® DNA Ligase (default only)"
    ),
    equipment = list(
      "Microfuge",
      "Vortex"
    ),
    versions = list(
      rapid = list(
        name     = "Rapid Adapter ligation",
        process  = "Attach the sequencing adapters to the DNA ends.",
        minutes  = 5
      ),
      default = list(
        name     = "Adapter ligation with clean-up",
        process  = "Attach the sequencing adapters to the DNA ends.",
        minutes  = 20
      )
    )
  ),
  barcoding = list(
    name     = "DNA barcoding",
    process  = "Tagmentation of the DNA for pooling.",
    stop_opt = "4°C overnight",
    consumables = list(
      "Barcodes (plated)",
      "LongAmp Hot Start Taq 2X Master Mix (PCR Only)",
      "EDTA (PCR Only)"
    ),
    equipment = list(
      "Thermal cycler",
      "Microfuge",
      "Plate Microfuge"
    ),
    versions = list(
      rapid = list(
        name     = "Rapid DNA barcoding",
        process  = "Tagmentation of the DNA using the Rapid Barcoding Kit.",
        minutes  = 15
      ),
      pcr = list(
        name     = "DNA barcoding via PCR",
        process  = "PCR using the barcoded primer supplied in the kit.",
        minutes  = 15
      ),
      rap16s = list(
        name     = "16S barcoded PCR amplification",
        process  = "Amplify the 16S gene using barcodes supplied in the kit.",
        minutes  = 10
      ),
      ligation = list(
        name     = "PCR Ligation of barcodes",
        process  = "Attach barcoding adapters to the DNA ends via PCR.",
        minutes  = 40
      )
    )
  ),
  pooling = list(
    name     = "Sample pooling",
    process  = "Pooling of barcoded libraries",
    stop_opt = "4°C overnight",
    consumables = list(
      "Elution Buffer"
    ),
    equipment = list(
    ),
    versions = list(
      default = list(
        name     = "Sample pooling and clean-up",
        process  = "Pooling of barcoded libraries and AMPure XP Bead clean-up.",
        minutes  = 25
      ),
      rap16s = list(
        name     = "Barcoded sample pooling and bead clean-up",
        process  = "Quantify and pool the barcoded samples and perform a library clean-up using beads.",
        minutes  = 15
      )
    )
  ),
  cleanup = list(
    name     = "AMPure XP Bead clean-up",
    process  = "Perform a library clean-up using beads.",
    stop_opt = "any",
    consumables = list(
      "AMPure XP Beads (AXP)",
      "Freshly prepared 80% ethanol in nuclease-free water",
      "Elution Buffer",
      "T7 Endonuclease I (postMDA only)",
      "NEBuffer 2 (postMDA only)",
      "1 M Tris-HCl (postMDA only)",
      "0.5 M EDTA pH 8 (postMDA only)",
      "5 M NaCl (postMDA only)",
      "PEG 8000 (postMDA only)",
      "TE buffer, pH 8 (postMDA only)"
    ),
    equipment = list(
      "Magnetic rack",
      "Hula mixer"
    ),
    versions = list(
      default = list(
        name     = "Sample clean-up",
        process  = "Perform a clean-up of individual samples using beads.",
        minutes  = 5
      ),
      pooled = list(
        name     = "Pooled library clean-up",
        process  = "Perform a clean-up of pooled, barcoded libraries.",
        minutes  = 5
      ),
      postMDA = list(
        name     = "Treat MDA Products",
        process  = "Treat the products with T7 endonuclease I and clean-up using beads and custom buffer.",
        minutes  = 60
      )
    )
  ),
  qc = list(
    qubit = list(
      name     = "DNA Quantification",
      process  = "Measure DNA concentration using Qubit assay kit and fluorometer.",
      stop_opt = "any",
      consumables = list(
        "Qubit dsDNA HS Assay Kit",
        "Qubit™ Assay Tubes"
      ),
      equipment = list(
        "Qubit fluorometer"
      ),
      versions = list(
        default = list(
          name     = "DNA Quantification of Samples",
          process  = "Quantify DNA concentrations for individual samples/libraries.",
          minutes  = 5
        ),
        pooled = list(
          name     = "DNA Quantification of Pooled Library",
          process  = "Quantify DNA concentration of pooled, barcoded libraries.",
          minutes  = 5
        )
      )
    )
  )
)
 
 
