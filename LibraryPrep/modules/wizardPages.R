nextPage <- function(id, i) {
  actionButton(NS(id, paste0("go_", i, "_", i + 1)), "Next Step")
}
prevPage <- function(id, i) {
  actionButton(NS(id, paste0("go_", i, "_", i - 1)), "Go Back")
}

wrapPage <- function(title, page, button_left = NULL, button_right = NULL) {
    nav_panel(
      title = title, 
      p("First tab content."),
      layout_column_wrap(button_left, button_right)
              )

}

wizardUI <- function(id, pages, doneButton = NULL) {
  stopifnot(is.list(pages))
  n <- length(pages)
  
  wrapped <- vector("list", n)
  for (i in seq_along(pages)) {
    # First page only has next; last page only prev + done
    lhs <- if (i > 1) prevPage(id, i)
    rhs <- if (i < n) nextPage(id, i) else doneButton
    wrapped[[i]] <- wrapPage(paste0("page_", i), pages[[i]], lhs, rhs)
  }
  
  # Create tabsetPanel
  wrapped$id <- NS(id, "wizard")
  wrapped$placement <- "above"
  do.call("navset_card_pill", wrapped)
}

wizardServer <- function(id, n) {
  moduleServer(id, function(input, output, session) {
    changePage <- function(from, to) {
      observeEvent(input[[paste0("go_", from, "_", to)]], {
        nav_select(id = "wizard", selected = paste0("page_", to), session = session)
      })  
    }
    ids <- seq_len(n)
    lapply(ids[-1], function(i) changePage(i, i - 1))
    lapply(ids[-n], function(i) changePage(i, i + 1))
  })
}

wizardApp <- function(...) {
  pages <- list(...)
  
  ui <- fluidPage(
    wizardUI("whiz", pages)
  )
  server <- function(input, output, session) {
    wizardServer("whiz", length(pages))
  }
  shinyApp(ui, server)
}