stepUI <- function(id) {
  ns <- NS(id)
  card(
    card_header(layout_columns(
      col_widths = c(1, 11),
      checkboxInput(inputId = ns("step_done"), label = NULL),
      verbatimTextOutput(outputId = ns("timestamp")))
      ),
    card_title(textOutput(outputId = ns("step"))),
    tags$p(textOutput(outputId = ns("note"))),
    textOutput(outputId = ns("substeps")),
    uiOutput(outputId = ns("element")),
    actionButton(inputId = ns("open_note_box"), label = "Click to add note"),
    uiOutput(outputId = ns("note_box_render"))
  )
}

stepServer <- function(id, state) {
  moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns
      
      # Store user data in state (global across steps)
      if (is.null(state$steps)) state$steps <- reactiveValues()

      # Get step data from procedure_steps list
      step_data <- procedure_steps[[id]]
      
      state$steps[[id]] <- reactive({
        list(
          step_name    = step_data$step,  # Step title
          completed_at = format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
          note         = input$procedure_note_box,
          substeps     = step_data$substeps,
          element      = step_data$element
          )
        }) |> bindCache(step_data$step, 
                        input$procedure_note_box,
                        step_data$substeps,
                        step_data$element) |> 
        bindEvent(input$step_done, ignoreNull = TRUE, ignoreInit = TRUE)
      
      # Display completion timestamp
      output$timestamp <- renderPrint({
        if (!is.null(state$steps[[id]])) {
          paste0("Step completed at ", state$steps[[id]]$completed_at)
        } else {
          "Step not completed yet."
        }
      }) |> bindEvent(input$step_done, ignoreNULL = TRUE, ignoreInit = TRUE)
      
      
      # Display step details dynamically
      output$step     <- renderText({ step_data$step })
      output$note     <- renderText({ step_data$note })
      output$substeps <- renderText({ paste(step_data$substeps, collapse = "\n") })
      output$element  <- renderUI({ step_data$element })
      
      # Render note input box
      output$note_box_render <- renderUI({
        card(
          textAreaInput(inputId = ns("procedure_note_box"), "Enter note here"),
          card_footer(actionButton(inputId = ns("submit_procedure_note"), "Submit note for log"))
        )
      }) |> bindEvent(input$open_note_box, ignoreNULL = TRUE, ignoreInit = TRUE)
      
    }
  )
}