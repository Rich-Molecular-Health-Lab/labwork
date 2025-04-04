categories <- c(
  "Consumables",
  "Equipment",
  "Personnel",
  "Travel"
)

purposes <- c(
  "Sample Collection",
  "DNA Extraction",
  "Quality Control",
  "Library Prep",
  "DNA Sequencing",
  "Portable Lab",
  "General",
  "Field Research",
  "Conferences"
)

projects <- c(
  "General",
  "Pygmy Loris Molecular Health",
  "Pygmy Loris Taxonomy/Phylogenetics",
  "Bat EcoHealth",
  "eDNA Endangered Bats",
  "Lithium Tolerant Microbial Communities",
  "BIAZA Nocturnal Mammal Workshop"
)

purchasing <- list(
  "p_card" = list(
    "ONT"              = list("ONT"             ) , 
    "IVYX Scientific"  = list("IVYX Scientific" ) , 
    "Zymo Research"    = list("Zymo Research"   ) , 
    "miniPCR"          = list("miniPCR"         ) , 
    "pipette.com"      = list("Labnet", "MTC-Bio") 
  ),
  "eshop"  = list(
    "Thermofisher"          = list("Invitrogen"),
    "Fisher Scientific"     = list("Promega"),
    "Amazon"                = list("coospider-repta", "EcoFlow", "Sylvania" ), 
    "Benchmark Scientific"  = list("Benchmark Scientific"       ) , 
    "Heathrow Scientific"   = list("Heathrow Scientific"        ), 
    "Globe Scientific"      = list("Globe Scientific"           ) , 
    "NEB"                   = list("NEB"                        ) 
  )
) %>%
  enframe(name = "Purchase_with", value = "Vendor") %>%
  unnest_longer(Vendor, values_to = "Manufacturer", indices_to = "Vendor") %>%
  unnest_longer(Manufacturer, values_to = "Manufacturer", indices_include = FALSE) %>%
  select(Purchase_with, Vendor, Manufacturer) %>%
  arrange(Purchase_with, Vendor, Manufacturer)

budget <- projects.total %>%
  left_join(select(consumables.tbl, -Purpose)) %>%
  mutate(N = N/(N_units * N_per_prep)) %>%
  select(-Type) %>%
  bind_rows(equipment.total) %>%
  full_join(select(travel.tbl, -c(Location, Distance))) %>%
  full_join(personnel.tbl) %>%
  mutate(Project  = fct(Project , levels = projects),
         Purpose  = fct(Purpose , levels = purposes),
         Category = fct(Category, levels = categories),
         Cost     = round(Price * N, digits = 2)) %>%
  filter(Funds == "Startup") %>%
  select(FY,
         Category,
         Project,
         Purpose,
         Supply,
         Price,
         N,
         N_units,
         N_per_prep,
         Cost,
         Manuf,
         Cat,
         Name,
         Link
  ) %>%
  arrange(
    FY,
    Category,
    Project,
    Purpose,
    Supply
  ) %>% distinct() 

write.table(budget, here("supplies/budget_byFY.tsv"), sep = "\t", row.names = F)

download_budget <- download_file(
  path           = here("supplies/budget_byFY.tsv"),
  output_name    = "RichLab_budget_summary",
  button_label   = "Download TSV Version",
  button_type    = "danger",
  has_icon       = TRUE,
  icon           = "fa fa-save",
  self_contained = TRUE
)

supplies <- budget %>%
  ungroup() %>%
  mutate(ID   = str_glue("{FY}", "{Category}", "{Project}", .sep = "_"),
         Name = Supply) %>%
  select(ID,
         FY,
         Category,
         Project,
         Purpose,
         Name,
         Manuf,
         Total = Cost,
         Cat,
         Link,
         Each = Price
  )  %>%
  arrange(
    FY,
    Category,
    Project,
    Purpose,
    desc(Total)
  )  %>%
  group_by(Category, Project) %>%
  mutate(relative_cost = Total/max(Total)) %>%
  ungroup() %>% distinct()

data <- supplies %>%
  group_by(ID, FY, Category, Project) %>%
  summarize(Total = sum(Total)) %>%
  ungroup() %>%
  select(ID,
         FY,
         Category,
         Project,
         Total
  ) %>%
  group_by(Category) %>%
  mutate(relative_cost = Total/max(Total)) %>%
  ungroup() %>% distinct()
