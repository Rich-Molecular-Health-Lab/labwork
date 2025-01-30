setupUI <- function(id) {
  ns <- NS(id)
  tagList(
    accordion(
      id = ns("setup"),
      accordion_panel(
        ns("setup_1"),
        layout_column_wrap(
          dateInput(      ns("exp_date")           , "Start Date"                  , value = Sys.Date(), format = "yyyy-mm-dd"),
          selectInput(    ns("author")             , "Your Name"                   , lab.members),
          selectizeInput( ns("assist")             , "Others Assisting"            , lab.members      , multiple = T, selected = "NA")
          ),
          textAreaInput(  ns("start_note")         , "Notes/Comments (Optional)"),
          actionButton(   ns("submit_start_note"   )                     , label = "Enter setup note"),
          textOutput(     ns("start_note_submitted")),
          selectizeInput( ns("protocol")           , "Select Library Prep Protocol", protocols_select, multiple = F),
        card(
          id = ns("selected_protocol"),
          card_header("Selected Protocol"),
          card_title(textOutput(ns("protocol_title"))),
          card_body(htmlOutput(ns("protocol_outline"))),
          card_footer(actionButton(ns("confirm_protocol"), "Confirm and Proceed"))
          )
        ),
      accordion_panel(
        ns("setup_2"),
        layout_column_wrap(
          selectInput(    ns("select_sampleset")   , "Select Sample Set:", choices = samplesets),
          actionButton(   ns("confirm_sampleset")  , "Confirm Selection")
          ),
        card(
          id = ns("reactable_card"),
          card_header(numericInput(ns("controls") , "N Controls to Include", value = 0, min = 0, max = 10)),
          card_title("Select Samples to Include"),
          card_body(reactableOutput(ns("samples"))),
          card_footer(
            layout_column_wrap(
              textOutput(ns("sample_tally")), 
              actionButton(   ns("reset_samples")      , "Click to reset selections"),
              actionButton(   ns("confirm_samples")    , "Confirm Samples and Controls"))
            )
        ),
        actionButton(   ns("samples_done")       , "Click to proceed")
      )
    )
  )
}

setupServer <- function(id, state) {
  moduleServer(
    id, 
    function(input, output, session) {
      
      setup <- reactiveValues(
        LibPrepDate    = as.Date(character()),
        LibPrepBy      = character(),
        LibPrepAssist  = character(),
        protocol       = character(),
        setup_note     = character(),
        sampleset      = character(),
        n_controls     = numeric(),
        n_extracts     = numeric(),
        n_rxns         = numeric()
      )
      
      samples <- reactiveValues(
        source    = tibble(),
        libraries = tibble()
      )
      
    observeEvent(input$exp_date, {
      req(input$exp_date)
      setup$LibPrepDate <- as.Date(as.character(input$exp_date))
    })
    
    observeEvent(input$author, {
      req(input$author)
      setup$LibPrepBy <- input$author
    })
    
    observeEvent(input$assist, {
      req(input$assist)
      setup$LibPrepAssist <- input$assist
    })

    observeEvent(input$protocol, {
      req(input$protocol)
      setup$protocol <- input$protocol
    })

    observeEvent(input$submit_start_note, {
      req(input$start_note)
      setup$setup_note            <- input$start_note
      req(setup$setup_note)
      output$start_note_submitted <- setup$setup_note
    })

    observeEvent(input$protocol, {
      req(input$protocol)
      setup$protocol <- input$protocol
    })
    
    observeEvent(input$confirm_protocol, {
      accordion_panel_set(ns("setup"), ns("setup_2"))
      req(setup$LibPrepDate, setup$protocol)
      ymd <- as.character(ymd(setup$LibPrepDate))
      setup$LibraryCode <- paste0(setup$protocol, ymd)
    })
   
    
    observeEvent(input$confirm_sampleset, {
      req(input$select_sampleset)
      samples$source <- read.table(compilation[[paste0(sampleset())]], sep = "\t", header = TRUE) %>% 
        mutate(CollectionDate = as.Date(CollectionDate)) %>%
        select(
          steps_remaining   ,
          ExtractID         ,
          Subject          ,
          Subj_Certainty   ,
          CollectionDate    , 
          ExtractConc      ,  
          ExtractBox       ) %>%
        arrange(CollectionDate, Subject) %>% as_tibble()
      
      output$samples <- renderReactable({
        req(samples$source)
        reactable(
          isolate(samples$source),
          height              = 600,
          sortable            = TRUE,
          filterable          = TRUE,
          columns             = list(
            steps_remaining = cDef_steps_remaining ,
            ExtractID       = cDef_ExtractID       ,
            Subject         = cDef_Subject         ,
            Subj_Certainty  = cDef_Subj_Certainty  ,
            CollectionDate  = cDef_CollectionDate  ,
            ExtractConc     = cDef_ExtractConc     ,
            ExtractBox      = cDef_ExtractBox      
          ),
          theme               = format_select,
          selection           = "multiple", 
          onClick             = "select",
          showPageSizeOptions = TRUE, 
          highlight           = TRUE, 
          compact             = TRUE
        )
      })
    })
    
    observe({
      selected <- getReactableState("samples", "selected")
      req(selected, input$controls)
      rxns <- sum(as.numeric(length(selected)), as.numeric(input$controls))
      output$samples_tally <- renderText({
        paste0(length(selected), " samples + ", input$controls, " controls (", rxns, " rxns)")
      })
    })
    
    observeEvent(input$reset_samples, {
      req(input$reset_samples)
      updateReactable("samples"    , selected = NA)
      updateNumericInput("controls", value = 0)
    })

    observeEvent(input$confirm_samples, {
      selected <- getReactableState("samples", "selected")
      req(selected, input$controls)
      setup$n_controls  <- as.numeric(isolate(input$controls))
      req(setup$n_controls)
      output$n_controls <- setup$n_controls
      setup$n_extracts  <- as.numeric(isolate(length(selected)))
      req(setup$n_extracts)
      output$n_extracts <- setup$n_extracts
      setup$n_rxns      <- sum(setup$n_extracts, setup$n_controls)
      req(setup$n_rxns)
      output$n_rxns     <- setup$n_rxns
      
      req(setup$n_controls)
      controls <- tibble( 
        ExtractID           = "Control_LibPrep",
        ExtractBox          = NULL,
        ExtractConc         = 0
      ) %>% slice(setup$n_controls)
      
      working_samples <- samples$source[selected,]
      req(working_samples)
      updateReactable("samples", data = working_samples)
      
      req(working_samples,
          controls,
          setup$LibPrepDate  ,
          setup$LibPrepBy    ,
          setup$LibPrepAssist,
          setup$LibraryCode,
          setup$protocol)
      samples$libraries <- working_samples %>%
        select(ExtractID, ExtractBox, ExtractConc) %>%
        bind_rows(controls) %>%
        mutate(LibraryTube  = row_number(),
               LibPrepDate  = setup$LibPrepDate,
               LibPrepBy    = setup$LibPrepBy,
               LibPrepProto = setup$protocol,
               LibraryCode  = setup$LibraryCode)
      
    })
    
    return(samples, setup)
  
  })
}