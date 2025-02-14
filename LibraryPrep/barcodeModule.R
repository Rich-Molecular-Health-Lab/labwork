barcodeUI <- function(id) {
  ns <- NS(id)
  tagList(
    accordion(
      id = ns("barcode"),
      open = "Step 1: Select Barcode Plate Rows to Break Away",
      accordion_panel(
        title = "Tips and Warnings",
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
        title = "Step 1: Select Barcode Plate Rows to Break Away",
          tags$em("Note: The 96-well plates are designed to break in one direction only. Strips, or multiple strips, of eight wells/barcodes can be removed from the plate at any one time."),
          reactableOutput(ns("barcodes")),
        layout_column_wrap(
          textOutput(ns("barcode_cols_tally")), actionButton(ns("barcode_cols_confirm"), "Next: Select individual barcodes from row")
          )
        ),
      accordion_panel(
        title = "Step 2: Select Individual Barcodes to Use",
        reactableOutput(ns("barcode_wells")),
        layout_column_wrap(
          textOutput(ns("barcode_wells_tally")), actionButton(ns("barcode_wells_confirm"), "Confirm Selected Barcodes")
          )
        ),
      accordion_panel(
        title = "Barcodes Matched to Samples",
        reactableOutput(ns("barcodes_matched")),
        actionButton(ns("barcodes_done"), "Proceed to Next Step")
        )
      )
    )
}

barcodeServer <- function(id, state, samples) {
  moduleServer(
    id, 
    function(input, output, session) {
      
      output$barcodes <- renderReactable({
        reactable(
          barcodes,
          height          = 600,
          columns         = list(
            column = colDefs$column ,
            row_A  = colDefs$row_A  ,
            row_B  = colDefs$row_B  ,
            row_C  = colDefs$row_C  ,
            row_D  = colDefs$row_D  ,
            row_E  = colDefs$row_E  ,
            row_F  = colDefs$row_F  ,
            row_G  = colDefs$row_G  ,
            row_H  = colDefs$row_H  
          ),
          columnGroups    = colGroups$barcodes,
          theme           = format_select,
          selection       = "multiple",
          onClick         = "select",
          highlight       = TRUE
          
        )
      })
      
      observe({
        selected <- getReactableState("barcodes", "selected")
        req(selected, setup$n_rxns)
        barcode_cols <- as.character(as.numeric(length(selected)))
        rxns         <- as.character(setup$n_rxns)
        output$barcode_cols_tally <- renderText({
          paste0(rxns, " total barcodes needed, ", barcode_cols, " plate rows selected")
        })
      })
      
      observeEvent(input$barcode_cols_confirm, {
        accordion_panel_set("barcode", "Step 2: Select Individual Barcodes to Use")
        selected      <- getReactableState("barcodes", "selected")
        req(selected)
        barcode_wells <- barcodes[selected,] %>%
          pivot_longer(
            cols      = !column,
            names_to  = "row",
            values_to = "Barcode"
          ) %>%
          mutate(BarcodePos = paste0(row, column))
          
        output$barcode_wells <- renderReactable({
          req(barcode_wells)
          reactable(
            barcode_wells,
            height          = 600,
            columns         = list(
              column     = colDef(show = FALSE)   ,  
              row        = colDef(show = FALSE)   ,  
              Barcode    = coldefs$Barcode        ,
              BarcodePos = coldefs$BarcodePos
            ),
            theme           = format_select,
            selection       = "multiple",
            onClick         = "select",
            highlight       = TRUE
          )
        })
        
      })
      
      observe({
        selected <- getReactableState("barcode_wells", "selected")
        req(selected, setup$n_rxns)
        barcode_wells <- as.character(as.numeric(length(selected)))
        rxns          <- as.character(setup$n_rxns)
        output$barcode_wells_tally <- renderText({
          paste0(barcode_wells, " barcodes selected (out of ", rxns, " needed)")
        })
      })
      observeEvent(input$barcode_wells_confirm, {
        accordion_panel_set("barcode", "Barcodes Matched to Samples")
        selected <- getReactableState("barcode_wells", "selected")
        barcodes_selected <- barcode_wells[selected,] %>%
          select(Barcode, BarcodePos) %>%
          mutate(LibraryTube = row_number())
        
        req(samples$libraries)
        samples$libraries <- samples$libraries %>%
          left_join(barcodes_selected, by = join_by(LibraryTube)) %>%
          select(LibraryTube ,
                 ExtractID   ,
                 Barcode     ,
                 BarcodePos  ,
                 ExtractBox  ,
                 ExtractConc ,
                 LibPrepDate ,
                 LibPrepBy   ,
                 LibPrepProto,
                 LibraryCode 
                 )
        
        output$barcodes_matched <- renderReactable({
          req(samples$libraries)
          reactable(
            isolate(samples$libraries),
            height              = 600,
            columns             = list(
              LibraryTube  = colDefs$LibraryTube ,
              ExtractID    = colDefs$ExtractID   ,
              Barcode      = colDefs$Barcode     ,
              BarcodePos   = colDefs$BarcodePos  ,
              ExtractBox   = colDefs$ExtractBox  ,
              ExtractConc  = colDefs$ExtractConc ,
              LibPrepDate  = colDefs$LibPrepDate ,
              LibPrepBy    = colDefs$LibPrepBy   ,
              LibPrepProto = colDefs$LibPrepProto,
              LibraryCode  = colDefs$LibraryCode 
            )
          )
        })
      })
      
      return(samples)
    }
  )
}



ui <- page_fluid(
  theme = bs_theme(preset = "lumen"),
  barcodeUI("barcode")
)

server <- function(input, output, session) {
  options(shiny.error = browser)
  barcodeServer("barcode", samples)
}

shinyApp(ui, server)



