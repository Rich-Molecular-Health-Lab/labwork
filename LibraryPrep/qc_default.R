elements <- list(
  qubit_standards = tagList(
    layout_column_wrap(
      numericInput("standard1_result", "Result for Standard 1", 0), 
      numericInput("standard2_result", "Result for Standard 2", 0)
    )
  ),
  qubit_samples = tagList(
    layout_column_wrap(
      numericInput("sample_result", "Result for Sample", 0)
    )
  )
)

kit <- keep_at(kits, "dsDNAqubit") %>% 
  list_flatten(name_spec = "{inner}")

reagents <- kit$contents

steps  <- list(
  list(
    step     = "Set up the required number of assay tubes (or tube strips) for 2 standards + N samples.",
    note     = "Use thin-wall, clear, 0.5-mL PCR tubes (Cat. No. Q32856) for the Qubit™ 4 Fluorometer.",
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Label the tube **lids** with sample tubes beginning at 3.",
    note     = "Do not label the side of the tube as this could interfere with the sample read.",
    substeps = list("Calibration of the Qubit™ Fluorometer requires the standards to be inserted into the instrument in the right order, so **Standard 1 and Standard 2 should be Tube 1 and Tube 2, respectively**."),
    element  = tagList(reactableOutput("qcTubes"))
  ),
  list(
    step     = "Add 10 µL of each Qubit™ standard to the appropriate tube (Tube 1 and Tube 2).",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Add 1 μL of each sample to a tube, beginning with Tube 3.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Prepare an aliquot of the Qubit™ 1X dsDNA working solution and add to each tube.",
    note     = "You will need 380 µL for both standards + 1 µL per sample. Always prepare an extra 2 µL of working solution to account for pipetting error.",
    substeps = list(
      "Add 190 µL to each tube of standard (Tube 1 and Tube 2).",
      "Add 199 µL to each sample tube (beginning with Tube 3)."
    ),
    element  = tagList(
      value_box(id       = "working_solution",
                theme    = "bg-success",
                showcase = bsicons::bs_icon("calculator"),
                title    = "Aliquot Working Volume of:",
                value    = textOutput("vol_working_solution"))
    )
  ),
  list(
    step     = "Mix each sample vigorously by vortexing for 3–5 seconds",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Incubate at room temperature for 2 minutes.",
    note     = NULL,
    substeps = list(NULL),
    element  = tagList(NULL)
  ),
  list(
    step     = "Prepare the Qubit 4 Fluorometer for reading results.",
    note     = NULL,
    substeps = list(
      "Press DNA on the Home screen.",
      "Select 1X dsDNA HS as the assay type.",
      "Press Read Standards to proceed."
    ),
    element  = tagList(NULL)
  ),
  list(
    step     = "Calibrate the Qubit 4 Fluorometer.",
    note     = "If you just recently calibrated using the same standards in this protocol, you can skip this step.",
    substeps = list(
      "Insert the tube containing Standard 1 into the sample chamber, close the lid, then press Read standard. ",
      "When the reading is complete (~3 seconds), remove Standard 1. ",
      "Insert the tube containing Standard 2 into the sample chamber, close the lid, then press Read standard. ",
      "When the reading is complete (~3 seconds), remove Standard 2.",
      "Note the calibration results shown on the screen."
    ),
    element  = elements$qubit_standards
  ),
  list(
    step     = "Prepare the Qubit 4 Fluorometer for sample readings.",
    note     = NULL,
    substeps = list(
      "Press Run samples.",
      "On the assay screen, use the + and - buttons until the screen reads 1.",
      "From the unit dropdown menu, select µL."
    ),
    element  = tagList(NULL)
  ),
  list(
    step     = "Perform sample readings (repeat this for each sample).",
    note     = "The top value (in large font) is the concentration of the original sample. The bottom value is the dilution concentration.",
    substeps = list(
      "Insert a sample tube into the sample chamber, close the lid, then press Read tube.",
      "When the reading is complete (~3 seconds), remove the sample tube.",
      "Record the values on the screen."
    ),
    reagents = NULL,
    element  = elements$qubit_samples
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))
