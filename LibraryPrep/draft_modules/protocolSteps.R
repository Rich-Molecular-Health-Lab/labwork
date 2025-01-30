part1_rap16s <- list(
  list("Prepare the barcodes you selected in the previous steps.",
       a = "Check the barcode number and plate position in the table below.",
       b = "Break the set of barcodes needed away from the 96-well plate from the kit and return the rest to storage."),
  list("Thaw the selected barcodes at room temperature."),
  list("Briefly centrifuge barcodes in a microfuge to make sure the liquid is at the bottom of the tubes and cooling block or ice."),
  list("Thaw the LongAmp Hot Start Taq 2X Master Mix, spin down briefly, mix well by pipetting and place on ice."),
  list("Prepare the DNA in nuclease-free water according to the values in the table below.",
       a = "Transfer the 'Extract to add' volume into a 1.5 ml Eppendorf DNA LoBind tube.",
       b = "Add nuclease-free water according to the volume under 'H2O to add' to reach the total volume.",
       c = "Check each row as you go to keep track of progress.",
       d = "Mix thoroughly by pipetting up and down, or by flicking the tube to avoid shearing.",
       e = "Spin down briefly in a microfuge."),
  list("Prepare the 16S PCR as follows:",
       a = "In a 0.2 ml thin-walled PCR tube, prepare the reaction mix according to the volumes in the table below",
       b = "Ensure the components are thoroughly mixed by pipetting and spin down briefly."),
  list("Line up the barcodes with their matching reaction tube according to the table below.",
       a = "Using clean pipette tips, carefully pierce the foil surface of the required barcodes.", 
       b = "Use a new tip for each barcode to avoid cross-contamination."),
  list("Transfer 10 μl of each 16S Barcode into respective sample-containing tubes.", 
       a = "Using a multichannel pipette, mix the 16S barcodes by pipetting up and down 10 times.", 
       b = "Check the boxes above as you add each barcode to its assigned tube.",
       c = "Ensure the components are thoroughly mixed by pipetting the contents of the tubes 10 times and spin down. Note: Mix gently to minimise introducing air bubbles to the reactions."),
  list("Place the tubes in the thermal cycler and run the PCR by selecting the program below or manually entering it.")) %>%
  set_names(paste0("I_", seq_along(.)))

part2_rap16s <- list(
  list("Prepare the supplies for sample pooling, bead clean-up, and adapter ligation according to the table below.",
       a = "Thaw reagents at room temperature.",
       b = "Spin down briefly using a microfuge",
       c = "Mix by pipetting."),
  list("Once the PCR cycles have completed, remove the tubes and add EDTA to stop the reaction.",
       a = "Add 4 µl of EDTA to each barcoded sample.",
       b = "Mix thorougly by pipetting and spin down briefly."),
  list("Incubate for 5 minutes at room temperature."),
  list("Quantify 1 µl of each barcoded sample using a Qubit fluorometer. Enter the QC results below before proceeding."),
  list("Pool all barcoded samples in equimolar ratios in a 1.5 ml Eppendorf DNA LoBind tube."),
  list("Resuspend the AMPure XP Beads (AXP) by vortexing."),
  list("Add a 0.6X volume ratio of resuspended AMPure XP Beads to the pool of barcoded samples.",
       a = "The value box below will automatically update with the proper volume for your samples.",
       b = "Mix by pipetting."),
  list("Incubate on a Hula mixer (rotator mixer) for 5 minutes at room temperature."),
  list("Prepare 2 ml of fresh 80% ethanol in nuclease-free water."),
  list("Spin down the sample and pellet on a magnet until supernatant is clear and colourless. Keep the tube on the magnet, and pipette off the supernatant."),
  list("Keep the tube on the magnet and wash the beads with 1 ml of freshly prepared 80% ethanol without disturbing the pellet. Remove the ethanol using a pipette and discard."),
  list("Repeat the previous step."),
  list("Spin down and place the tube back on the magnet. Pipette off any residual ethanol. Allow to dry for ~30 seconds, but do not dry the pellet to the point of cracking."),
  list("Remove the tube from the magnetic rack and resuspend the pellet in 15 µl Elution Buffer (EB). Spin down and incubate for 5 minutes at room temperature."),
  list("Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute."),
  list("Remove and retain 15 µl of eluate into a clean 1.5 ml Eppendorf DNA LoBind tube."),
  list("Quantify 1 µl of eluted sample using a Qubit fluorometer. Enter the QC result for the pooled library below before proceeding."),
  list("Transfer your eluted sample into a clean 1.5 ml Eppendorf DNA LoBind tube. Dilute with elution buffer if necessary (see below)"),
  list("In a fresh 1.5 ml Eppendorf DNA LoBind tube, dilute the Rapid Adapter (RA) as follows:"),
  list("Add 1 µl of the diluted Rapid Adapter (RA) to the barcoded DNA.",
       a = "Mix gently by flicking the tube.",
       b = "Spin down briefly."),
  list("Incubate the reaction for 5 minutes at room temperature."))%>%
  set_names(paste0("II_", seq_along(.)))


part1_lsk <- list(
  list("Thaw DNA Control Sample (DCS) at room temperature, spin down, mix by pipetting, and place on ice."),
  list("Prepare the NEB reagents in accordance with manufacturer’s instructions, and place on ice.",
       a = "Thaw all reagents on ice.",
       b = "Flick and/or invert the reagent tubes to ensure they are well mixed. Do not vortex the FFPE DNA Repair Mix or Ultra II End Prep Enzyme Mix.",
       c = "Always spin down tubes before opening for the first time each day.",
       d = "Vortex the FFPE DNA Repair Buffer v2, or the NEBNext FFPE DNA Repair Buffer and Ultra II End Prep Reaction Buffer to ensure they are well mixed.",
       e = "The FFPE DNA Repair Buffer may have a yellow tinge and is fine to use if yellow."),
  list("Prepare the DNA in nuclease-free water according to the values in the table below.",
       a = "Transfer the 'Extract to add' volume into a 1.5 ml Eppendorf DNA LoBind tube.",
       b = "Add nuclease-free water according to the volume under 'H2O to add' to reach the total volume.",
       c = "Check each row as you go to keep track of progress.",
       d = "Mix thoroughly by pipetting up and down, or by flicking the tube.",
       e = "Spin down briefly in a microfuge."),
  list("In a 0.2 ml thin-walled PCR tube, prepare the reaction mix."),
  list("Thoroughly mix the reaction by gently pipetting and briefly spinning down."),
  list("Using a thermal cycler, incubate at 20°C for 5 minutes and 65°C for 5 minutes."),
  list("Resuspend the AMPure XP Beads (AXP) by vortexing."),
  list("Transfer the DNA sample to a clean 1.5 ml Eppendorf DNA LoBind tube."),
  list("Add 60 µl of resuspended the AMPure XP Beads (AXP) to the end-prep reaction and mix by flicking the tube."),
  list("Incubate on a Hula mixer (rotator mixer) for 5 minutes at room temperature."),
  list("Prepare 500 μl of fresh 80% ethanol in nuclease-free water."),
  list("Spin down the sample and pellet on a magnet until supernatant is clear and colourless. Keep the tube on the magnet, and pipette off the supernatant."),
  list("Keep the tube on the magnet and wash the beads with 200 µl of freshly prepared 80% ethanol without disturbing the pellet. Remove the ethanol using a pipette and discard."),
  list("Repeat the previous step."),
  list("Spin down and place the tube back on the magnet. Pipette off any residual ethanol. Allow to dry for ~30 seconds, but do not dry the pellet to the point of cracking."),
  list("Remove the tube from the magnetic rack and resuspend the pellet in 61 µl nuclease-free water. Incubate for 2 minutes at room temperature."),
  list("Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute."),
  list("Remove and retain 61 µl of eluate into a clean 1.5 ml Eppendorf DNA LoBind tube."),
  list("Quantify 1 µl of eluted sample using a Qubit fluorometer. Enter the QC results for each library below before proceeding.")) %>%
  set_names(paste0("I_", seq_along(.)))

part2_lsk <- list(
  list("Spin down the Ligation Adapter (LA) and Salt-T4® DNA Ligase, and place on ice."),
  list("Thaw Ligation Buffer (LNB) at room temperature, spin down and mix by pipetting. Due to viscosity, vortexing this buffer is ineffective. Place on ice immediately after thawing and mixing."),
  list("Thaw the Elution Buffer (EB) at room temperature and mix by vortexing. Then spin down and place on ice."),
  list("Thaw either Long Fragment Buffer (LFB) or Short Fragment Buffer (SFB) at room temperature (see below for selection) and mix by vortexing. Then spin down and place on ice."),
  list("In a 1.5 ml Eppendorf DNA LoBind tube, prepare the reaction mix shown below."),
  list("Thoroughly mix the reaction by gently pipetting and briefly spinning down."),
  list("Incubate the reaction for 10 minutes at room temperature."),
  list("Resuspend the AMPure XP Beads (AXP) by vortexing."),
  list("Add 40 µl of resuspended AMPure XP Beads (AXP) to the reaction and mix by flicking the tube."),
  list("Incubate on a Hula mixer (rotator mixer) for 5 minutes at room temperature."),
  list("Spin down the sample and pellet on a magnet. Keep the tube on the magnet, and pipette off the supernatant when clear and colourless."),
  list("Wash the beads by adding either 250 μl Long Fragment Buffer (LFB) or 250 μl Short Fragment Buffer (SFB). Flick the beads to resuspend, spin down, then return the tube to the magnetic rack and allow the beads to pellet. Remove the supernatant using a pipette and discard."),
  list("Repeat the previous step."),
  list("Spin down and place the tube back on the magnet. Pipette off any residual supernatant. Allow to dry for ~30 seconds, but do not dry the pellet to the point of cracking."),
  list("Remove the tube from the magnetic rack and resuspend the pellet in 15 µl Elution Buffer (EB). Spin down and incubate for 10 minutes at room temperature. For high molecular weight DNA, incubating at 37°C can improve the recovery of long fragments."),
  list("Pellet the beads on a magnet until the eluate is clear and colourless, for at least 1 minute."),
  list("Remove and retain 15 µl of eluate containing the DNA library into a clean 1.5 ml Eppendorf DNA LoBind tube. Dispose of the pelleted beads"),
  list("Quantify 1 µl of eluted sample using a Qubit fluorometer. Enter the QC results for each library below before proceeding."),
  list("Prepare your final library in 12 µl of Elution Buffer (EB) according to the table below.")) %>%
  set_names(paste0("II-", seq_along(.), "-"))

part3_flongle <- list(
  list("Thaw the Sequencing Buffer (SB) Library Beads (LIB), Flow Cell Tether (FCT) and Flow Cell Flush (FCF) at room temperature before mixing by vortexing. Then spin down and store on ice."),
  list("To prepare the flow cell priming mix with BSA, combine Flow Cell Flush (FCF) and Flow Cell Tether (FCT), as directed below. Mix by pipetting at room temperature."),
  list("Open the MinION device lid and place the Flongle adapter into the MinION device."),
  list("Place the flow cell into the Flongle adapter. Press down firmly on the flow cell until you hear a click.",
       note = "The flow cell should sit evenly and flat inside the adapter, to avoid any bubbles forming inside the
fluidic compartments."),
  list("Peel back the seal tab from the Flongle flow cell, up to a point where the sample port is exposed, as follows:",
       a = "Lift up the seal tab (image below)",
       b = "Pull the seal tab to open access to the sample port (image below)",
       c = "Hold the seal tab open by using adhesive on the tab to stick to the MinION lid (image below)"),
  list("To prime your flow cell with the mix of Flow Cell Flush (FCF) and Flow Cell Tether (FCT) that was prepared earlier , ensure that there is no air gap in the sample port or the pipette tip.",
       a = "Place the P200 pipette tip inside the sample port and slowly dispense the 120 µl of priming fluid into the Flongle flow cell by twisting the pipette plunger down (this avoids flushing the flow cell too vigorously)."),
  list("Prepare the Sequencing Mix as follows:",
       a = "Vortex the vial of Library Beads (LIB).",
       b = "Note that the beads settle quickly, so immediately prepare the Sequencing Mix (see below) in a fresh 1.5 ml Eppendorf DNA LoBind tube for loading the Flongle"),
  list("Add the Sequencing Mix to the flow cell as follows:",
       a = "Ensure that there is no air gap in the sample port or the pipette tip.",
       b = "Place the P200 tip inside the sample port and slowly dispense the Sequencing Mix into the flow cell by slowly twisting the pipette plunger down to avoid flushing the flow cell too vigorously (image below)."),
  list("Seal the Flongle flow cell using the adhesive on the seal tab, as follows:",
       a = "Stick the transparent adhesive tape to the sample port.",
       b = "Replace the top (Wheel icon section) of the seal tab to its original position.")) %>%
  set_names(paste0("III_", seq_along(.)))

part3_minion <- list(
  list("Thaw the Sequencing Buffer (SB) Library Beads (LIB), Flow Cell Tether (FCT) and Flow Cell Flush (FCF) at room temperature before mixing by vortexing. Then spin down and store on ice."),
  list("To prepare the flow cell priming mix with BSA, combine Flow Cell Flush (FCF) and Flow Cell Tether (FCT), as follows:",
       a = "For kits with the old single-use tube format, add 5 µl Bovine Serum Albumin (BSA) at 50 mg/ml and 30 µl Flow Cell Tether (FCT) directly to a tube of Flow Cell Flush (FCF).",
       b = "For kits with the newer bottle format, follow the volumes shown in the table below.",
       c = "For either format, mix by pipetting at room temperature."),
  list("Open the MinION device lid and slide the flow cell under the clip. Press down firmly on the flow cell to ensure correct thermal and electrical contact."),
  list("Slide the flow cell priming port cover clockwise to open the priming port."),
  list("After opening the priming port, check for a small air bubble under the cover. Draw back a small volume to remove any bubbles.",
       a = "Set a P1000 pipette to 200 µl",
       b = "Insert the tip into the priming port",
       c = "Turn the wheel until the dial shows 220-230 µl, to draw back 20-30 µl, or until you can see a small volume of buffer entering the pipette tip",
       d = "Visually check that there is continuous buffer from the priming port across the sensor array."),
  list("Load 800 µl of the priming mix into the flow cell via the priming port, avoiding the introduction of air bubbles. Wait for five minutes. During this time, prepare the library for loading by following the steps below."),
  list("Thoroughly mix the contents of the Library Beads (LIB) by pipetting."),
  list("In a new 1.5 ml Eppendorf DNA LoBind tube, prepare the flow cell reaction mix as follows:"),
  list("Complete the flow cell priming.",
       a = "Gently lift the SpotON sample port cover to make the SpotON sample port accessible.",
       b = "Load 200 µl of the priming mix into the flow cell priming port (not the SpotON sample port), avoiding the introduction of air bubbles."),
  list("Mix the prepared library gently by pipetting up and down just prior to loading."),
  list("Add 75 μl of the prepared library to the flow cell via the SpotON sample port in a dropwise fashion. Ensure each drop flows into the port before adding the next."),
  list("Gently replace the SpotON sample port cover, making sure the bung enters the SpotON port and close the priming port."),
  list("Place the light shield onto the flow cell.",
       a = "Carefully place the leading edge of the light shield against the clip. Note: Do not force the light shield underneath the clip.",
       b = "Gently lower the light shield onto the flow cell. The light shield should sit around the SpotON cover, covering the entire top section of the flow cell.")) %>%
  set_names(paste0("III_", seq_along(.)))


steps <- list(
  rapid16s = c(part1_rap16s, part2_rap16s, part3_flongle),
  lsk      = c(part1_lsk, part2_lsk, part3_minion)
)

steps_workflow <- list(
  rapid16s = list(
    part1 = part1_rap16s,
    part2 = part2_rap16s,
    part3 = part3_flongle
  ),
  lsk = list(
    part1 = part1_lsk,
    part2 = part2_lsk,
    part3 = part3_minion
  )
)

part1_steps <- list(rapid16s = part1_rap16s , lsk = part1_lsk)
part2_steps <- list(rapid16s = part2_rap16s , lsk = part2_lsk)
part3_steps <- list(rapid16s = part3_flongle, lsk = part3_minion)
