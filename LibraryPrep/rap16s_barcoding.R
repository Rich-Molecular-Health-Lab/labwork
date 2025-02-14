barcoding_16s  <- list(
  list(
    step     = "Take one 96-well plate containing 16S barcodes.",
    note     = NULL,
    substeps = list("Break one set of barcodes (1-24, or as desired) away from the plate and return the rest to storage."),
    element  = tagList(value_box(
      title    = "Important",
      value    = "The 96-well plates are designed to break in one direction only. Strips, or multiple strips, of eight wells/barcodes can be removed from the plate at any one time.",
      showcase = icon("triangle-exclamation")
    ))
  ),
  list(
    step     = "Thaw the desired barcodes at room temperature.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Briefly centrifuge barcodes in a microfuge to make sure the liquid is at the bottom of the tubes.",
    note     = NULL,
    substeps = list("Place on ice."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Thaw the LongAmp Hot Start Taq 2X Master Mix.",
    note     = NULL,
    substeps = list("Spin down briefly",
                    "Mix well by pipetting and place on ice."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Prepare the DNA in nuclease-free water.",
    note     = NULL,
    substeps = list("Transfer 10 ng of each genomic DNA sample into a 0.2 ml thin-walled PCR tube.",
                    "Adjust the volume of each sample to 15 μl with nuclease-free water.",
                    "Mix thoroughly by flicking avoiding unwanted shearing.",
                    "Spin down briefly in a microfuge."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Add 25 \u+03bcL LongAmp Hot Start Taq 2X Master Mix to each PCR tube containing 10 ng DNA.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Ensure the components are thoroughly mixed by pipetting and spin down briefly.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Prepare the barcodes.",
    note     = NULL,
    substeps = list("Using clean pipette tips, carefully pierce the foil surface of the required barcodes.",
                    "Use a new tip for each barcode to avoid cross-contamination.",
                    "Make sure you properly match the barcodes assigned to each tube according to the table below."),
    element  = tagList(reactableOutput("barcodes"))
  ),
  list(
    step     = "Add the barcodes to their proper tube.",
    note     = NULL,
    substeps = list("Using a multichannel pipette, mix the 16S barcodes by pipetting up and down 10 times.",
                    "Transfer 10 μl of each 16S Barcode into respective sample-containing tubes."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Mix and spin the reactions.",
    note     = "Mix gently to minimise introducing air bubbles to the reactions.",
    substeps = list("Ensure the components are thoroughly mixed by pipetting the contents of the tubes 10 times.",
                    "Spin down."),
    element  = tagList(NULL)
  ),
  list(
    step     = "Amplify in the thermal cycler using the cycling conditions below.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(reactableOutput("pcrCycles_16s"))
  ),
  list(
    step     = "Thaw kit components at room temperature, spin down briefly using a microfuge and mix by pipetting as indicated by the table below.",
    note     = NULL,
    substeps = list("Also thaw EDTA at room temperature, spin down briefly, and mix well by pipetting or vortexing."),
    element  = tagList(reactableOutput("rapid_reagents"))
  ),
  list(
    step     = "Immediately remove tubes from the thermal cycler at the end of the program.",
    note     = NULL,
    substeps = list("Add 4 µl of EDTA to each barcoded sample.",
                    "Mix thorougly by pipetting.",
                    "Spin down briefly."),
    element  = tagList(reactableOutput("pcrCycles_16s"))
  ),
  list(
    step     = "Incubate for 5 minutes at room temperature.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))