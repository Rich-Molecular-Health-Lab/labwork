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

barcode_cols <- function() {
  nav_panel(
    value = "barcode_cols",
    card(
      card_header(textOutput("barcode_header")),
      tags$em("Note: The 96-well plates are designed to break in one direction only. Strips, or multiple strips, of eight wells/barcodes can be removed from the plate at any one time."),
      reactableOutput("barcodes"),
      card_footer(actionButton("barcode_cols_confirm", "Next: Confirm individual barcodes"))
    )
  )
}
barcode_wells <- function() {
  nav_panel(
    value = "barcode_wells",
    card(
      card_header(textOutput("barcode_header_2")),
      reactableOutput("barcode_wells"),
      card_footer(textOutput("barcode_footer", inline = TRUE),
                  actionButton("barcode_wells_confirm", "Click to confirm selection")
                  )
    ),
    accordion(
      id = "barcodes_selected",
      open = FALSE,
      accordion_panel(
        title = "List of barcodes matched to each tube:",
        value = "barcodes_confirmed",
        reactableOutput("barcodes_confirmed")
      )
    ),
    actionButton("dynamic_done", "Confirm Barcoding Parameters")
  )
}
  

lsk_input_tab <- function() {
  nav_panel(value = "lsk_input",
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
    uiOutput("step_progress")
  )
}

part1_tab <- function() {
  nav_panel(textOutput("part1_heading"), value = "part1",
      uiOutput("part1_accord"),
      uiOutput("part1_steps"),
      actionButton("part1_done", textOutput("part1_footer")))
}

part2_tab <- function() {
  nav_panel(textOutput("part2_heading"), value = "part2",
     uiOutput("part2_accord"),
     uiOutput("part2_steps"),
     actionButton("part2_done", "Next: Prime/Load Flow Cell")
  )
}
  
part3_tab <- function() {
  nav_panel("III. Prime and Load Flow Cell", value = "part3",
    accordion(open = F, 
              accordion_panel("Dynamic Summary Table", 
                              value = "summary_table",
                              uiOutput("part3_reactable")),
              part3.recs),
    make_steps(part3),
    actionButton("part3_done", "Next: Complete Experiment")
    )
}