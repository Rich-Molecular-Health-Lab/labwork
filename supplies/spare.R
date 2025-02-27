```{r}
equipment <- bind_rows(sequencers, computers, portable.lab) %>%
  select(
    Category,
    Title,
    Each,
    Per,
    N_year,
    Cost_year,
    Manuf,
    Cat,
    Link
  ) %>%
  arrange(Manuf, Cat) %>%
  gt(groupname_col = "Category", rowname_col = "Title") %>%
  fmt_currency(columns = c("Each", "Cost_year")) %>%
  cols_hide(N_year) %>%
  cols_label(
    Each       = "Cost",
    Cost_year  = "Cost/Year",
    Link       = ""
  ) %>%
  fmt_url(columns = Link,
          label   = fontawesome::fa(
            name           = "link",
            height         = "0.75em",
            vertical_align = "0em"
          ),
          color = "gray65"
  ) %>%
  sub_missing(missing_text = "-") %>%
  summary_rows(
    columns = c("Each", "Cost_year"),
    fns = list(
      label = md("*Equipment Total*"),
      fn    = "sum"),
    fmt = ~ fmt_currency(.)
  ) %>%
  opt_stylize(style = 1, color = "cyan")
```

```{r, include = FALSE}
personnel <- bind_rows(lab.manager, work.study) %>%
  gt(groupname_col = "Category", rowname_col = "Title") %>%
  fmt_currency(columns = c("Each", "Cost_month", "Cost_year")) %>%
  cols_hide(N_month) %>%
  cols_label(
    Each       = "Cost",
    Cost_month = "Per Month",
    Cost_year  = "Per Year"
  ) %>%
  summary_rows(
    columns = c("Cost_month", "Cost_year"),
    fns = list(
      label = md("*Personnel Total*"),
      fn    = "sum"),
    fmt = ~ fmt_currency(.)
  ) %>%
  opt_stylize(style = 1, color = "cyan")
```




# Summary

```{r}
budget.summary <- tibble(
  
)
```





```{r, include = FALSE}
consumables <- bind_rows(
  consumables_tubes,
  consumables_extraction,
  consumables_gels,
  consumables_cleanup,
  consumables_collection,
  consumables_libprep,
  expansions_libprep,
  consumables_tips,
  consumables_flowcells
) %>%
  mutate(cost_N = cost/(samples_prep * preps),
         N_kit  = samples_prep * preps,
         Stage     = fct(Stage, levels = c(
           "General Use", 
           "Sample Collection", 
           "Extraction", 
           "Quality Control", 
           "Library Prep",
           "Sequencing"))) %>%
  select(
    Stage,
    Item         = name,
    Cost         = cost,
    N_kit,
    Cost_N       = cost_N,
    Manufacturer = manufacturer,
    Catalog      = catalog,
    Link         = link
  ) %>%
  arrange(Stage, Manufacturer)

write.table(consumables, here("supplies/consumables.tsv"), row.names = FALSE, sep = "\t")

download_consumables <- download_file(
  path           = here("supplies/consumables.tsv"),
  output_name    = "consumables",
  button_label   = "Download TSV Version of Table Below",
  button_type    = "danger",
  has_icon       = TRUE,
  icon           = "fa fa-save",
  self_contained = TRUE
)

```

```{r}
download_consumables
```


```{r, include = FALSE}
consumables_table <- reactable(consumables,
                               height          = 800,
                               theme           = flatly(),
                               groupBy         = "Stage",
                               defaultExpanded = TRUE,
                               columns = list(
                                 Stage    = colDef(maxWidth = 80),
                                 Item = colDef(cell = function(value, index) {
                                   tags$a(href = consumables$Link[index], target = "_blank", value)
                                 }, style = cell_style(font_size = 18, font_color = "black"), minWidth = 200),
                                 Cost          = colDef(name = "Cost/Item", 
                                                        cell = data_bars(
                                                          consumables, 
                                                          text_position = "outside-end", 
                                                          box_shadow    = TRUE, 
                                                          number_fmt    = label_currency()
                                                        )
                                 ),
                                 N_kit         = colDef(name = "Est. N/Item", format = colFormat(digits = 0), maxWidth = 50),
                                 Cost_N        = colDef(name = "Est. Cost/N",
                                                        cell = data_bars(
                                                          consumables, 
                                                          text_position = "outside-end", 
                                                          box_shadow    = TRUE, 
                                                          number_fmt    = label_currency()
                                                        )
                                 ),
                                 Manufacturer = colDef(cell = pill_buttons(opacity = 0.5, text_size = 9.5, box_shadow = TRUE),
                                                       style = cell_style(horizontal_align = "right"), maxWidth = 85),
                                 Catalog      = colDef(cell = function(value) {tags$small(tags$pre(value))}, maxWidth = 100),
                                 Link         = colDef(show = FALSE)
                               )
) %>%
  add_title("Consumables for Most Lab Workflows")

save_reactable_test(consumables_table, "consumables.html")
```

```{r}
consumables_table
```



### Kits

```{r}
dna_prep <- enframe(extraction[1], name = NULL) %>% unnest_wider(value)
```


### Reagents

### Other Basic Consumables