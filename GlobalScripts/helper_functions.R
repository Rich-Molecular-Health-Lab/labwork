# /GlobalScripts/helper_functions.R

make_steps <- function(nested_steps) {
  imap(nested_steps, ~ {
    step_name    <- .y
    step_content <- .x
    main_step    <- step_content[[1]]
    substeps     <- step_content[-1]
    
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
          tags$h5(step_name),
          tagList(
            tags$h5(main_step),
            substep_list
          )
        ),
        layout_columns(
          col_widths = c(12),
          uiOutput(outputId = paste0("card_", step_name))
        )
      )
    )
  })
}

checklist_js <- JS("
  function(cellInfo) {
    return cellInfo.value === 'no' ? '\u2717' : '\u2713';
  }
")

certainty_js <- JS("function(cellInfo) {
    return cellInfo.value === 'no' ? '\u2753' : '\u2713'
  }")

checklist_r <- function(value) {if (value == 0) "\u2717" else "\u2713"}
certainty_r <- function(value) {if (value == "no") "\u2753" else "\u2713"}

format_select      <- reactableTheme(rowSelectedStyle = list(backgroundColor = "#eee", boxShadow = "inset 2px 0 0 0 #ffa62d"))
format_checklist   <- reactableTheme(rowSelectedStyle = list(backgroundColor = "darkgray"      , color = "#eee"),
                                     rowStyle         = list(backgroundColor = "darkgoldenrod1", borderColor = "black"))
ngul        <- " \u006E\u0067\u002F\u00B5\u004C"
ul          <- " \u00B5\u004C"

rxn_vols <- function(rxn, n_rxns) {
  rxn %>% mutate(N_rxns       = n_rxns,
                 Volume_total = Volume_rxn * n_rxns) %>%
    select(Reagent,
           Volume_rxn,
           N_rxns,
           Volume_total)
}

load_data <- function(path) {
  tibble <- read.table(path, sep = "\t", header = TRUE) %>% 
    mutate(CollectionDate = ymd(CollectionDate),
           steps_remaining = factor(steps_remaining, levels = c(
             "sample not extracted",
             "extract not sequenced",
             "sample extracted and sequenced"
           ))) %>%
    select(
      steps_remaining   ,
      ExtractID         ,
      Subject          ,
      Subj_Certainty  ,
      CollectionDate    , 
      ExtractConc      ,  
      ExtractBox       ) %>%
    arrange(steps_remaining, CollectionDate, Subject) %>% as_tibble() %>%
    mutate(steps_remaining = as.character(steps_remaining))
  
  return(tibble)
}


list_panel <- function(nested_list) {
  tags$dl(
    imap(nested_list, ~ {
      abbrev <- .y
      item   <- .x
      tagList(tags$dt(abbrev), tags$dd(item))
    })
  )
}


timestamp <- function(prefix, suffix) {
  paste0(prefix, paste(format(Sys.time(), "%Y-%m-%d %H:%M:%S")), suffix)
}

render_image <- function(output, outputId, filename, base_path, height = "75%") {
  full_path <- paste0(path$resources, "images/", filename)
  output[[outputId]] <- renderImage({
    list(src = full_path, height = height)
  }, deleteFile = FALSE)
}

render_illustration <- function(img) {
  page_fluid(
    accordion(
      open = FALSE, 
      accordion_panel(
        title = "Illustration", 
        card(imageOutput(img)))))
}

render_illustration_x2 <- function(img1, img2) {
  page_fluid(
    accordion(
      open = FALSE, 
      accordion_panel(
        title = "Illustration", 
        card(
          layout_columns(
            col_widths = 1/2, 
            imageOutput(img1), 
            imageOutput(img2))))))
}






