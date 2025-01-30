install_missing_packages <- function(required_packages) {
  installed_packages <- rownames(installed.packages())
  missing_packages   <- setdiff(required_packages, installed_packages)
  
  if (length(missing_packages) > 0) {
    message("Installing missing packages: ", paste(missing_packages, collapse = ", "))
    install.packages(missing_packages)
  } else {
    message("All required packages are already installed.")
  }
}

fix.strings <-  function(df) {
  df <- df %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("'")))) %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("[")))) %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("]")))) %>%
    mutate(across(where(is.character), ~str_trim(.x, "both"))) %>%
    mutate(across(where(is.character), ~str_squish(.x)))
  return(df)
}

read.tables <- function(file) {
  data <- read.table(file, 
                     header = TRUE, 
                     sep = "\t", 
                     stringsAsFactors = FALSE) %>%
    tibble()
  return(data)
}

yes.no.aggregated <- function(col) {
  JS("
  function(cellInfo) {
        const values = cellInfo.subRows.map(function(row) { 
        return row['col'] === 'no' ? '\u274c No' : '\u2714\ufe0f Yes' 
        })
      
      // Count occurrences of each value
      const counts = values.reduce(function(acc, v) {
        acc[v] = (acc[v] || 0) + 1;
        return acc;
      }, {});
      
      // Format the counts as a string
      return Object.entries(counts)
        .map(([key, count]) => `${key}: ${count}`)
        .join(', ');
  }
  ")
}

name_substeps <- function(x) {
  if (!is.null(x)) {
    map_depth(x, 1, \(y) set_names(y, letters[seq_along(y)]))
  } else {
    return(x)
  }
}

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

timestamp <- function(prefix, suffix) {
  paste0(prefix, paste(format(Sys.time(), "%Y-%m-%d %H:%M:%S")), suffix)
}
