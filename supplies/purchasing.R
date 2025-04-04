source(here("supplies/consumables_byFY.R"))
source(here("supplies/equipment_byFY.R"))

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