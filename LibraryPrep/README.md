# Shiny Workflow for Library Prep

This repository contains a Shiny app for managing Rich Lab workflows and lab notebook entries.

## Directory Structure
.
├── app.R                      # Main Shiny app file
├── global.R                   # Global variables and setup
├── README.md                  # Overview of the project
├── .gitignore                 # Git ignore rules
├── resources/                 # Static assets, templates, and additional resources
│   ├── steps /                # Protocol steps to insert into UI
│   │   ├── step_definitions.R # Script to source all step lists and convert them into formatted UI pages/cards
│   │   ├── endprep_steps.R    # List of steps for DNA Repair and End Prep
│   │   ├── adapter_steps.R    # List of steps for Adapter Ligation stage
│   │   ├── cleanup_steps.R    # List of steps for Library Cleanup
│   │   └── flowcell_steps.R   # List of steps for Flow Cell Priming and Loading
│   ├── images/                # Image assets (mostly from ONT's protocol guides)
│   │   ├── Flow_Cell_Loading_Diagrams_Step_03_V5.gif
│   │   ├── Flow_Cell_Loading_Diagrams_Step_04_V5.gif
│   │   ├── Flow_Cell_Loading_Diagrams_Step_06_V5.gif
│   │   ├── Flow_Cell_Loading_Diagrams_Step_07_V5.gif
│   │   ├── Flow_Cell_Loading_Diagrams_Step_1a.svg
│   │   ├── Flow_Cell_Loading_Diagrams_Step_1b.svg
│   │   ├── Flow_Cell_Loading_Diagrams_Step_2.svg
│   │   ├── Flow_Cell_Loading_Diagrams_Step_5.svg
│   │   ├── Flow_Cell_Loading_Diagrams_Step_9.svg
│   │   ├── J2264_-_Light_shield_animation_Flow_Cell_FAW_optimised.gif
│   │   ├── SQK-LSK114_bottle.svg
│   │   ├── SQK-LSK114_tubes.svg
│   │   └── Step_8_update.png
│   ├── templates/             # R Markdown templates for exporting lab notebook entries
│   │   └── report.Rmd
├── ui/                        # UI components
│   ├── ui.R                   # Main UI layout (optional if app.R is self-contained)
│   ├── ui_tabs.R              # Functions defining tab panels
│   └── step_definitions.R     # Definitions of nested lists for protocol steps
├── server/                    # Server logic scripts
│   ├── server.R               # Server-side logic
│   ├── helper_functions.R     # helper functions to perform calculations and formatting
│   ├── reactable_columns.R    # column settings for rendering reactable tables
│   ├── ui_outputs.R           # ui logic to render reactive outputs
│   ├── dynamic_cards.R        # ui logic for adding inputs, outputs, and images to cards
│   ├── observers.R            # observers for reactive values
│   └── report_logic.R         # observers for creating lab notebook report and exporting updated sample list