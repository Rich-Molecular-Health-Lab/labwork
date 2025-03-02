projects <- list(
  "Pygmy Loris Molecular Health"           = list(
    "Sample Collection" = list(
      N_25   = 0, 
      N_26   = 150,
      Funds  = "Startup",
      Kit    = "DNA Stabilizer",
      Tubes  = list("Large Sample Collection Tubes")
    ),
    "DNA Extraction" = list(
      N_25   = 0, 
      N_26   = 150,
      Funds  = "Startup",
      Kit    = "Fecal/Soil Kit",
      Tubes  = list("Microfuge Tubes")
    ),
      "Quality Control" = list(
        N_25   = 0, 
        N_26   = 150,
        Funds  = "Startup",
        Kit    = "Qubit Assay Kit",
        Tubes  = list("Qubit Assay Tubes")
      ),
      "Library Prep" = list(
        N_25   =  0, 
        N_26   =  150,
        Funds  = "Startup",
        Kit    = "16S Barcoding Kit 24",
        Extras = "Taq Master Mix",
        Tubes  = list("PCR Tubes", "Microfuge Tubes")
      ),
    "DNA Sequencing" = list(
      N_25   = 0, 
      N_26   = 150,
      Funds  = "Startup",
      Kit    = "Flow Cells",
      Tubes  = list("Microfuge Tubes")
      )
    ),
  "Pygmy Loris Taxonomy/Phylogenetics"     = list(
    "Sample Collection" = list(
      N_25   = 0, 
      N_26   = 20,
      Funds  = "Startup",
      Kit    = "DNA Stabilizer",
      Tubes  = list("Large Sample Collection Tubes")
    ),
    "DNA Extraction" = list(
      N_25   = 0, 
      N_26   = 20,
      Funds  = "Startup",
      Kit    = "Fecal/Soil Kit",
      Extras = "Purification Kit",
      Tubes  = list("Microfuge Tubes")
    ),
    "Quality Control" = list(
      N_25   =  0, 
      N_26   =  20,
      Funds  = "Startup",
      Kit    = "Qubit Assay Kit",
      Tubes  = list("Qubit Assay Tubes")
    ),
    "Library Prep" = list(
      N_25   =  0, 
      N_26   =  20,
      Funds  = "Startup",
      Kit    = "Ligation Sequencing Kit",
      Extras = "Ligation Companion Module",
      Tubes  = list("PCR Tubes", "Microfuge Tubes")
    ),
    "DNA Sequencing" = list(
      N_25   = 0, 
      N_26   = 20,
      Funds  = "Startup",
      Kit    = "Flow Cells",
      Tubes  = list("Microfuge Tubes")
      )
    ),
  "Bat EcoHealth"                          = list(
    "Sample Collection" = list(
      N_25   =  10, 
      N_26   =  10,
      Funds  = "Startup",
      Kit    = "DNA Stabilizer",
      Tubes  = list("Small Sample Collection Tubes")
    ),
    "DNA Extraction" = list(
      N_25   =  10, 
      N_26   =  20,
      Funds  = "Startup",
      Kit    = "Fecal/Soil Kit",
      Tubes  = list("Microfuge Tubes")
    ),
    "Quality Control" = list(
      N_25   =  10, 
      N_26   =  20,
      Funds  = "Startup",
      Kit    = "Qubit Assay Kit",
      Tubes  = list("Qubit Assay Tubes")
    ),
    "Library Prep" = list(
      N_25   =  10, 
      N_26   =  20,
      Funds  = "Startup",
      Kit    = "16S Barcoding Kit 24",
      Extras = "Taq Master Mix",
      Tubes  = list("PCR Tubes", "Microfuge Tubes")
    ),
    "DNA Sequencing" = list(
      N_25   =  10, 
      N_26   =  20,
      Funds  = "Startup",
      Kit    = "Flow Cells",
      Tubes  = list("Microfuge Tubes")
    )
  ),
  "eDNA Endangered Bats"                   = list(
    "Sample Collection" = list(
      N_25   =  10, 
      N_26   =  10,
      Funds  = "Startup",
      Tubes  = list("Lysis Collection Tube")
    ),
    "DNA Extraction" = list(
      N_25   =  10, 
      N_26   =  10,
      Funds  = "Startup",
      Kit    = "Fecal/Soil Kit",
      Extras = "Purification Kit",
      Tubes  = list("Microfuge Tubes")
    ),
    "Quality Control" = list(
      N_25   =  10, 
      N_26   =  10,
      Funds  = "Startup",
      Kit    = "Qubit Assay Kit",
      Tubes  = list("Qubit Assay Tubes")
    ),
    "Library Prep" = list(
      N_25   =  5, 
      N_26   =  15,
      Funds  = "Startup",
      Kit    = "Rapid Barcoding Kit 24",
      Tubes  = list("PCR Tubes", "Microfuge Tubes")
    ),
    "DNA Sequencing" = list(
      N_25   =  5, 
      N_26   =  15,
      Funds  = "Startup",
      Kit    = "Flow Cells",
      Tubes  = list("Microfuge Tubes")
    )
    
  ),
  "Lithium Tolerant Microbial Communities" = list(
    "DNA Extraction" = list(
      N_25   =  10, 
      N_26   =  0,
      Funds  = "Startup",
      Kit    = "Fecal/Soil Kit",
      Tubes  = list("Microfuge Tubes")
    ),
    "Quality Control" = list(
      N_25   =  10, 
      N_26   =  0,
      Funds  = "Startup",
      Kit    = "Qubit Assay Kit",
      Tubes  = list("Qubit Assay Tubes")
    ),
    "Library Prep" = list(
      N_25   =  5, 
      N_26   =  5,
      Funds  = "Startup",
      Kit    = "Ligation Sequencing Kit",
      Extras = "Ligation Companion Module",
      Tubes  = list("PCR Tubes", "Microfuge Tubes")
    ),
    "DNA Sequencing" = list(
      N_25   =  5, 
      N_26   =  5,
      Funds  = "Startup",
      Kit    = "Flow Cells",
      Tubes  = list("Microfuge Tubes")
      )
    )
  )

projects.25 <- modify_at(projects, 
                         "Tubes", \(x) list_flatten(x, name_spec = "{inner}")) %>%
  enframe(., name = "Project") %>% 
  unnest_longer(value, indices_to = "Purpose") %>%
  unnest_wider(value)  %>%
  unnest_longer(Tubes) %>%
  pivot_longer(cols     = c("Kit", "Extras", "Tubes"),
               names_to  = "Type",
               values_to = "Supply") %>%
  filter(!is.na(Supply)) %>%
  mutate(FY = 25, N = N_25, .keep = "unused")

projects.total <- projects.25 %>%
  mutate(FY = 26, N = N_26) %>%
  bind_rows(projects.25) %>%
  select(-N_26) %>%
  filter(N > 0)



