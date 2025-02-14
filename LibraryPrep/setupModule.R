setupUI <- function(id) {
  ns <- NS(id)
  tagList(
    accordion(
      id = ns("setup"),
      accordion_panel(
        title = "Setup Part 1",
        layout_column_wrap(
          dateInput(      ns("exp_date")           , "Start Date"                  , value = Sys.Date(), format = "yyyy-mm-dd"),
          selectInput(    ns("author")             , "Your Name"                   , lab.members),
          selectizeInput( ns("assist")             , "Others Assisting"            , lab.members      , multiple = T, selected = "NA")
          ),
          textAreaInput(  ns("start_note")         , "Notes/Comments (Optional)"),
          actionButton(   ns("submit_start_note"   )                     , label = "Enter setup note"),
          textOutput(     ns("start_note_submitted")),
          selectizeInput( ns("protocol")           , "Select Library Prep Protocol", protocols_select, multiple = F),
          actionButton(   ns("confirm_protocol")   , "Confirm Protocol Choice")
        ),
      accordion_panel(
        title = "Setup Part 2",
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
        protocol_name  = character(),
        protocol       = list(),
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
      setup$protocol_name <- input$protocol
    })

    observeEvent(input$submit_start_note, {
      req(input$start_note)
      setup$setup_note            <- input$start_note
      req(setup$setup_note)
      output$start_note_submitted <- setup$setup_note
    })
    
    observeEvent(input$confirm_protocol, {
      accordion_panel_set("setup", "Setup Part 2")
      req(setup$LibPrepDate, setup$protocol_name)
      ymd <- as.character(ymd(setup$LibPrepDate))
      setup$LibraryCode <- paste0(setup$protocol_name, ymd)
      
      setup$protocol <- keep_at(protocols, setup$protocol_name) %>%
        list_flatten(name_spec = "{inner}") %>% 
        compact()
      
    })
   
    
    observeEvent(input$confirm_sampleset, {
      req(input$select_sampleset)
      samples$source <- read.table(here(libprep$samples[[paste0(input$select_sampleset)]]), sep = "\t", header = TRUE) %>% 
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
            steps_remaining = colDefs$steps_remaining ,
            ExtractID       = colDefs$ExtractID       ,
            Subject         = colDefs$Subject         ,
            Subj_Certainty  = colDefs$Subj_Certainty  ,
            CollectionDate  = colDefs$CollectionDate  ,
            ExtractConc     = colDefs$ExtractConc     ,
            ExtractBox      = colDefs$ExtractBox      
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
      extracts <- as.character(as.numeric(length(selected)))
      controls <- as.character(as.numeric(input$controls))
      rxns     <- as.character(sum(as.numeric(length(selected)), as.numeric(input$controls)))
      output$sample_tally <- renderText({
        paste0(extracts, " samples + ", controls, " controls (", rxns, " rxns)")
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
      extracts <- as.numeric(length(selected))
      controls <- as.numeric(input$controls)
      rxns     <- sum(as.numeric(length(selected)), as.numeric(input$controls))
      
      setup$n_controls  <- controls
      setup$n_extracts  <- extracts
      setup$n_rxns      <- rxns
      
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
    
    return(samples)
    return(setup)
  
  })

}