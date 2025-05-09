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

## Personnel

### Lab Manager or Technician

My graduate student Shayda Azadmanesh has been managing my lab under a graduate research stipend at 20 hours per week. After she secures a permanent position I would like to pay someone to act as a lab technician at minimum wage for 20 hours per week.

```{r, include = FALSE}
lab.manager <- tibble(
  Category = "Personnel",
  Title    = "Lab Technican",
  Each     = 15,
  Per      = "hours",
  N_month  = 80
) %>% make_total()
```


### Work Study Undergraduates

Trineca Segura-Palacio completed an undergraduate independent study with me and stayed in the lab as a work-study intern at 10 hours per week. I would like to offer her the same arrangement next year, as she is already fully trained and capable. I also want to maximize opportunities for students like her representing nontraditional and racial minority communities that are likely to face heightened barriers in the next several years.

After Trineca graduates, I would like to continue using work-study to compensate at least one student from an underrepresented community at all times.


```{r, include = FALSE}
work.study <- tibble(
  Category = "Personnel",
  Title    = "Work Study Undergrads",
  Each     = 3.75,
  Per      = "hour",
  N_month  = 40
) %>% make_total()
```


```{r}
personnel <- bind_rows(lab.manager, work.study) %>%
  rename(Price      = Each, 
         Cost_total = Cost_year,
         N          = N_month) %>%
  mutate(Project    = "All Projects",
         N_needed   = N * 12, 
         N_each     = 1,
         Link       = NA, 
         Cat        = NA,
         Supplies   = NA,
         Manuf      = NA) %>%
  select(all_of(budget_cols))
```
### ONT Sequencing Devices

The MinION Mk1b portable sequencing devices that I purchased with startup funds in 2022 have become the crux of all my lab's workflows and long-term projects. Oxford Nanopore just released the upgraded Mk1d and announced that all Mk1b devices would soon become obsolete. We currently have two Mk1b devices, so I would like to replace both and get one more flongle starter pack (includes one flongle adapter and 12 consumable flow cells) so that we can run the flongle flow cells on two devices simultaneously.

```{r, include = FALSE}
sequencers <- tibble(
  Category = "Equipment",
  Title    = c("MinION Mk1d Sequencers", "Flongle Starter Pack"),
  Manuf    = "ONT",
  Link     = c("https://store.nanoporetech.com/us/minion.html", "https://store.nanoporetech.com/us/flongle-intro-pack-2.html"),
  Cat      = c("MIN-101D", "FLGIntSP"),
  Each     = c(2999, 1995),
  Per      = c("device", "pack"),
  N_year   = c(2, 1)
) %>% equip_total()
```


### Computational Upgrades

Since diving further into the long-read sequencing realm, I have realized that computational power limits our pipelines more so than sequencing devices themselves. I purchased a Linux System76 laptop with the minimum computational requirements to perform more of our bioinformatic tasks locally and handle more complex sequencing runs on the MinION devices. If we also incorporate a high performance workstation, we will be able to sequence more complex genomes at a higher throughput and reserve the laptop for our mobile sequencing operations.

```{r}
computers <- tibble(
  Category = "Equipment",
  Title    = "Linux High Performance Workstation",
  Manuf    = "system76",
  Link     = "https://system76.com/desktops/thelio-major-r5-n3/configure",
  Cat      = "thelio-major-r5-n3",
  Each     = 4554,
  Per      = "device",
  N_year   = 1
) %>% equip_total()
```


