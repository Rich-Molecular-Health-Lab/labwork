library_loading <- list(
  list(
    step     = "Use the guidelines in the table below to prepare a final library in 12 µl of Elution Buffer (EB).",
    note     = "Note: If the library yields are below the input recommendations, load the entire library.",
    substeps = list(NULL),
    element  = tagList(reactableOutput("loading_concentration"))
  )
) %>% set_names(seq_len(length(.))) %>% 
  map_depth(1, \(x) lmap_at(x, "substeps", name_substeps))