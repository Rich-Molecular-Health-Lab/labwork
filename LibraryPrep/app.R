here::i_am("LibraryPrep/app.R")
source(here::here("GlobalScripts/global_setup.R"))
source(here::here("LibraryPrep/app_setup.R"))

ui <- page_fluid(
  theme = bs_theme(preset = "lumen"),
  setupUI("setup"),
  barcodeUI("barcode")
)

server <- function(input, output, session) {
  options(shiny.error = browser)
  setupServer("setup")
  barcodeServer("barcode", samples)
}

shinyApp(ui, server)