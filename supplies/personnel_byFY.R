personnel <- list(
  "Lab Technician" = list(
    hourly   = 15,
    per_week = 20,
    Funds    = "Startup",
    weeks = list(
      N_25 = 16,
      N_26 = 40
    )
  ),
  "Work Study Undergrad" = list(
    hourly   = 4,
    per_week = 10,
    Funds    = "Startup",
    weeks = list(
      N_25 = 10,
      N_26 = 30
    )
  )
)


personnel.tbl <- enframe(personnel, name = "Supply") %>%
  unnest_wider(value) %>%
  unnest_longer(weeks) %>%
  mutate(FY    = as.integer(str_remove_all(weeks_id, "N_")), 
         N     = weeks*per_week,
         Price = hourly,
         Category = "Personnel",
         Purpose  = "General",
         Project  = "General",
         .keep = "unused")
