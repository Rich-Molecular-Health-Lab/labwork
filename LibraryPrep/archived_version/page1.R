
make_steps <- function(nested_steps) {
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]
    display_name <- str_c(str_replace_all(step_name, "_", "\\."), ".")    
    
    substep_list <- if (length(substeps) > 0) {
      tags$ol(
        map(names(substeps), ~ tags$li(substeps[[.x]])),
        style = "list-style-type: lower-alpha;"
      )
    } else {
      NULL
    }
    
    card(
      id = paste0("step_", step_name),
      class = "bg-primary",
      card_header(textOutput(outputId = paste0("stamp_", step_name))),
      layout_sidebar(
        fillable = TRUE,
        sidebar = sidebar(
          open = FALSE,
          textAreaInput(inputId = paste0("text_", step_name), label = "Add note"),
          actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
          textOutput(outputId = paste0("note_", step_name))
        ),
        layout_columns(
          col_widths = c(1, 2, 9),
          checkboxInput(inputId = paste0("check_", step_name), label = ""),
          tags$h5(display_name),
          tagList(
            tags$h5(main_step),
            substep_list
          )
        ),
        layout_column_wrap(
          uiOutput(outputId = paste0("card_", step_name))
        )
      )
    )
  })
}



stepCards <- function(id) {
  
  
  
    imap(nested_steps, ~ {
      step_name    <- .y
      step_content <- .x
      main_step    <- step_content[[1]]
      substeps     <- step_content[-1]
      display_name <- str_c(str_replace_all(step_name, "_", "\\."), ".")    
      
      substep_list <- if (length(substeps) > 0) {
        tags$ol(
          map(names(substeps), ~ tags$li(substeps[[.x]])),
          style = "list-style-type: lower-alpha;"
        )
      } else {
        NULL
      }
      
      card(
        id = paste0("step_", step_name),
        class = "bg-primary",
        card_header(textOutput(outputId = paste0("stamp_", step_name))),
        card_title(
          layout_columns(
            col_widths = c(1, 2, 9),
            checkboxInput(inputId = paste0("check_", step_name), label = ""), display_name, main_step)
        ),
        card_body(substep_list),
        card_body(layout_column_wrap(uiOutput(outputId = paste0("card_", step_name)))),
        card_footer(accordion(open = F,accordion_panel("Add Note",
                                                       textAreaInput(inputId = paste0("text_", step_name), label = "Add note"),
                                                       actionButton(inputId = paste0("submit_", step_name), label = "Enter note"),
                                                       textOutput(outputId = paste0("note_", step_name))
        )))
      )
    )
    )
)
    })
}


initializeUI <- function(id) {
  tagList(
    dateInput(NS(id, "exp_date"), "Start Date", value = Sys.Date(), format = "yyyy-mm-dd"),
    selectInput(NS(id, "author"), "Your Name", lab.members),
    selectizeInput(NS(id, "assist"), "Others Assisting", lab.members, multiple = T, selected = "NA"),
    selectizeInput(NS(id, "select_workflow"), "Select a Library Prep workflow:", protocol_options),
    selectizeInput(NS(id, "select_set"), "Select the sample set:", samplesets),
    textAreaInput(NS(id, "library_code"), "Enter a Shorthand Code for this Sequencing Run"),
    selectInput(NS(id, "flowcell_type"), "Flow Cell Type", choices = c("Flongle", "MinION", "PromethION")),
    textInput(NS(id, "flowcell_num"), "Flow Cell Serial Num", value = "SERIAL"),
    selectInput(NS(id, "minion"), "Device Name", choices = c("Angel", "Spike")),
    actionButton(NS(id, "basics_done"), "Next: Select Samples/Extracts")
  )
}

samplesetUI <- function(id) {
  tagList(
  numericInput(NS(id, "add_controls"), "N Controls to Include", value = 0, min = 0, max = 10),
  reactableOutput(NS(id, "samples")),
  textOutput(NS(id, "samples_count"), inline = TRUE),
  actionButton(NS(id, "reset_samples")  , "Click to reset selections"),
  actionButton(NS(id, "confirm_samples"), "Click to confirm selection"),
  reactableOutput(NS(id, "selected")),
  actionButton(NS(id, "samples_done"), "Click to proceed")
  )
}