travel <- list(
  "Conferences" = list(
    list(
      Funds          = "Startup",
      FY             = 26,
      Start          = "2025-11-26",
      End            = "2025-12-01",
      Project        = "BIAZA Nocturnal Mammal Workshop",
      Link           = "https://biaza.org.uk/",
      Location       = "London Zoo, UK",
      Distance       = "International",
      Costs          = list(
        Purchases      = list(
          "Flight (OMA to LHR)" = 900,
          "Registration"        = 150,
          "Airport Transfer"    = 80
          ),
        PerDiem        = list(
          "Meals"          = 80,
          "Lodging"        = 190,
          "Transportation" = 20
          )
        )
      )
    ),
  "Field Research" = list(
    list(
      Funds          = "URCA",
      FY             = 25,
      Start          = "2025-05-12",
      End            = "2025-06-01",
      Project        = "Pygmy Loris Molecular Health",
      Link           = "https://www.eprc.asia/",
      Location       = "Cúc Phương, Vietnam",
      Distance       = "International",
      Costs          = list(
        Purchases      = list(
          "Flight (OMA to HAN)" = 1800,
          "Visa"                = 100,
          "Airport Transfer"    = 50
        ),
        PerDiem        = list(
          "Meals"          = 50,
          "Lodging"        = 100,
          "Transportation" = 5
          )
        )
      )
    )
  )

travel.tbl <- enframe(travel, name = "Purpose") %>%
  unnest(value) %>%
  unnest_wider(value) %>%
  unnest_longer(Costs, indices_to = "Type") %>%
  mutate(N = if_else(Type == "Purchases", 1, as.integer(ymd(End) - ymd(Start))), .keep = "unused") %>%
  unnest_longer(Costs, values_to = "Price", indices_to = "Supply") %>%
  mutate(Category = "Travel")