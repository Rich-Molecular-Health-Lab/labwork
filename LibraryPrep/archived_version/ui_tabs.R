# /LibraryPrep/ui/ui_tabs.R

workflow_tab <- function() {
     nav_panel("Basic Parameters", value = "basics",
               layout_column_wrap(
                            dateInput("exp_date", "Start Date", value = Sys.Date(), format = "yyyy-mm-dd"),
                            selectInput("author", "Your Name", lab.members),
                            selectizeInput("assist", "Others Assisting", lab.members, multiple = T, selected = "NA")),
                          layout_column_wrap(
                            selectizeInput("select_workflow", "Select a Library Prep workflow:", protocol_options),
                            selectizeInput("select_set", "Select the sample set:", samplesets),
                            textAreaInput("library_code", "Enter a Shorthand Code for this Sequencing Run")),
                layout_column_wrap(
                              selectInput("flowcell_type", "Flow Cell Type", choices = c("Flongle", "MinION", "PromethION")),
                              textInput("flowcell_num", "Flow Cell Serial Num", value = "SERIAL"),
                              selectInput("minion", "Device Name", choices = c("Angel", "Spike")),
                              value_box(title = paste0("Minimum Pores Needed for Flow Cell:"),
                                        value = textOutput("flowcell_check"),
                                        "Optional: Use this value to complete a flow cell check and assess the number of pores available before preparing the library."
                              )),
                   actionButton("basics_done", "Next: Select Samples/Extracts")
               )
     
}


samples_tab <- function() {
            nav_panel("Select Samples", value = "samples",
                  numericInput("add_controls", "N Controls to Include", value = 0, min = 0, max = 10),
                        card(
                          card_header("Select inputs to include"), 
                          reactableOutput("samples"),
                        card_footer(layout_column_wrap(
                          textOutput("samples_count", inline = TRUE)))),
                  layout_column_wrap(
                        actionButton("reset_samples"  , "Click to reset selections"),
                        actionButton("confirm_samples", "Click to confirm selection")
                        ),
                  accordion(
                    id = "samples_selected",
                    open = FALSE,
                    accordion_panel(
                      title = "Review Selected Samples",
                      value = "review_samples",
                      reactableOutput("selected")
                    )
                  ),
                    actionButton("samples_done", "Click to proceed")
                      ) 
}

barcodes <- function() {
  nav_panel("Select Barcodes",
    value = "barcodes",
    accordion(
      open = "barcodes_a",
      id = "barcode_tables",
      accordion_panel(
        value = "barcode_warning",
        layout_column_wrap(
          card(class = "bg-warning",
               card_header("Minimum DNA Input Amount"),
               card_body("For optimal output, you will need 10 ng high molecular weight genomic DNA per barcode.")),
          card(class = "bg-warning",
               card_header("Minimum 16S Barcode Primers use requirements"),
               card_body("For optimal output, ONT does not recommend using fewer than 4 barcodes. If you wish to multiplex less than 4 samples, please ensure you split your sample(s) across barcodes so a minimum of 4 barcodes are run.")
               )
            )
        ),
      accordion_panel(
        title = "Step 1: Select plate rows to break away.",
        value = "barcodes_a",
        card(
          card_header(tags$em("Note: The 96-well plates are designed to break in one direction only. Strips, or multiple strips, of eight wells/barcodes can be removed from the plate at any one time.")
                      ),
        reactableOutput("barcodes"),
        card_footer(actionButton("barcode_cols_confirm", "Next: Confirm individual barcodes"))
          )
        ),
      accordion_panel(
        title = "Step 2: Select individual wells to use.",
        value = "barcodes_b",
        card(
        reactableOutput("barcode_wells"),
        card_footer(
          layout_column_wrap(
            textOutput("barcode_footer"),
            actionButton("barcode_wells_confirm", "Click to confirm selection")))
        )),
      accordion_panel(
        title = "List of barcodes matched to each tube:",
        value = "barcodes_c",
        card(
          reactableOutput("barcodes_confirmed"),
          card_footer(actionButton("dynamic_done", "Confirm Barcoding Parameters"))
        )
      )
    )
  )
    
}
  
lsk_input_tab <- function() {
  nav_panel("Setup Continued", value = "lsk_input",
     card(
       card_header("Input DNA Specifications for Ligation Sequencing"),
       layout_column_wrap(
         radioButtons("strands", 
                      "DNA Type", 
                      choices = list("dsDNA (nuclear DNA)" = 2, 
                                     "ssDNA (mtDNA)"       = 1), 
                      selected = 2),
         radioButtons("fragments", 
                      "Input Length", 
                      choices = input_options, 
                      selected = 1)
       ),
       actionButton("input_submit", "Confirm Input Choices"),
       tags$h3("Adjust target length or input mass (optional):"),
       layout_column_wrap(
         uiOutput("adjust_length"), 
         uiOutput("adjust_input")),
       card_footer(
         actionButton("dynamic_done", "Confirm Input Parameters")
         )
     )
  )
}


setup_tab <- function() {
  nav_panel("Review Setup Parameters", value = "setup",
            reactableOutput("setup_summary"),
            textAreaInput("start_note", "Notes/Comments (Optional)"),
            actionButton("submit_start_note", label = "Enter note"),
            textOutput("start_note_submitted"),
            actionButton("setup_done", "Next: Begin Protocol")
            
  )
}


conclude_tab <- function() {
  nav_panel("Conclude", value = "conclude",
    tags$h2("Before you finish:"), tags$br(),
    tags$h4("Conclude your notebook entry and export report..."), tags$br(),
    textAreaInput("end_note", "Notes/Comments"),
    textOutput("end_note_render"),
    actionButton("generate_report", "Generate Report for Download"),
    layout_column_wrap(downloadButton("download_tsv", "Download Updated Table"), 
                       downloadButton("download_report", "Download Report")),
    uiOutput("step_report")
  )
}

part1_tab <- function() {
  nav_panel("Part 1 of 3", value = "part1",
      uiOutput("part1_steps"),
      actionButton("part1_done", "Next: Final Prep Steps"))
}

part2_tab <- function() {
  nav_panel("Part 2 of 3", value = "part2",
     uiOutput("part2_steps"),
     actionButton("part2_done", "Next: Prime/Load Flow Cell")
  )
}
  
part3_tab <- function() {
  nav_panel("Part 3 of 3", value = "part3",
            uiOutput("part3_steps"),
    actionButton("part3_done", "Next: Complete Experiment")
    )
}