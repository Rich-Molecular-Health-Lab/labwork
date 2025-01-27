ui <- fluidPage(
  titlePanel("Library Prep Protocols"),
  sidebarLayout(
    sidebarPanel(
      selectInput("protocol", "Select Protocol", 
                  choices = names(protocols), 
                  selected = NULL)
    ),
    mainPanel(
      uiOutput("protocol_ui")
    )
  )
)

server <- function(input, output, session) {
  observeEvent(input$protocol, {
    req(input$protocol)
    protocol_data <- protocols[[input$protocol]]
    
    output$protocol_ui <- renderUI({
      protocolUI("selected_protocol", protocol_data)
    })
    
    protocolServer("selected_protocol", protocol_data)
  })
}