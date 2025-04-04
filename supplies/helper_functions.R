purchase_order_consumables <- function(list) {
  enframe(list, name = "Supply", value = "N") %>%
    left_join(consumables.tbl, by = join_by(Supply)) %>%
    left_join(purchasing, by = join_by(Manuf == Manufacturer)) %>%
    rowwise() %>%
    mutate(Total = Price * N) %>%
    ungroup() %>%
    select(
      Purchase_with,
      Vendor,
      Manuf,
      Cat,
      Supply,
      Total,
      N,
      N_units,
      Price,
      Name,
      Link
    ) %>% arrange(Purchase_with, Vendor, Manuf, Price)
}

# Helper function to format aggregated currency values
currency_aggregated <- function() {
  JS("function(cellInfo) {
    return `${cellInfo.value.toLocaleString('en-US', { style: 'currency', currency: 'USD' })}`;
  }")
}

# Helper function to generate a JS style function that hides duplicate values based on a given field.
stub_style <- function(field) {
  js_code <- sprintf("
    function(rowInfo, column, state) {
      const firstSorted = state.sorted[0];
      if (!firstSorted || firstSorted.id === '%s') {
        const prevRow = state.pageRows[rowInfo.viewIndex - 1];
        if (prevRow && rowInfo.values['%s'] === prevRow['%s']) {
          return { visibility: 'hidden' };
        }
      }
    }
  ", field, field, field)
  
  JS(js_code)
}

linked_colDef <- function(df, display_name, minWidth) {
  colDef(
    name       = display_name,
    minWidth   = minWidth,
    cell = function(value, index) {
      link <- df$Link[index]
      tags$a(href = link, target = "_blank", value)
    }
  )
}

currency_colDef <- function(df, display_name, minWidth) {
  colDef(
    name       = display_name,
    minWidth   = minWidth,
    aggregate  = "sum",
    align      = "right",
    aggregated = currency_aggregated(),
    format     = colFormat(currency = "USD", separators = TRUE),
    footer     = function(values, name) {
      total <- sum(values, na.rm = TRUE)
      label_currency(prefix = "$", big.mark = ",")(total)
    }
  )
}

purchasing_cols <- function(df) {
  list(
    Purchase_with = colDef(name = "Purchase via", minWidth = 70 , style = stub_style("Purchase_with")),
    Vendor        = colDef(minWidth = 150, style = stub_style("Vendor")),
    Manuf         = colDef(name = "Manufacturer", minWidth = 150 , style = stub_style("Manuf")),
    Supply        = linked_colDef(df, "Item", 200),
    Price         = colDef(show = FALSE),
    N             = colDef(name = "N", minWidth = 20),
    Total         = currency_colDef(df, "Cost", 90),
    Name          = colDef(show = FALSE),
    Cat           = colDef(name  = "Catalog", minWidth   = 150, style = list(fontFamily = "Courier New, monospace")),
    N_units       = colDef(name = "Units Each", minWidth = 80),
    Link          = colDef(show = FALSE)
  )
}

purchase_order_tbl <- function(df, ...) {
  tbl <- reactable(
    df,
    groupBy       = c("Purchase_with", "Vendor"),
    fullWidth     = FALSE,
    theme         = nytimes(),
    defaultColDef = colDef(footerStyle = list(fontWeight = "bold")),
    defaultExpanded = TRUE,
    rowStyle      = JS("function(rowInfo) {
                     if (rowInfo.level == 0) {
                       return { background: '#E0E0E0FF', borderLeft: '2px solid #5E382EFF', fontWeight: 'bold' }
                     } else if (rowInfo.level == 1) {
                       return { background: '#F5F5F5FF', borderLeft: '2px solid #5E382EFF', fontWeight: 'bold' }
                     } else if (rowInfo.level > 1) {
                       return { borderLeft: '2px solid transparent' }
                     }
                   }"),
    columns       = purchasing_cols(df),
    ...
  )
  save_reactable_test(tbl, paste0("supplies/purchase_order_", year(today()), "_", month(today()), "_", day(today()), ".html"))
  return(tbl)
}