# /LibraryPrep/server/helper_functions.R

source(global$global_helpers)
source(global$data_functions)

calculate_length <- function(fragment_type) {
  case_when(
    fragment_type == 1 ~ 10000,
    fragment_type == 2 ~ 900,
    fragment_type == 3 ~ 2000,
    fragment_type == 4 ~ 7000,
    fragment_type == 5 ~ 10000,
    TRUE ~ 10000
  )
}

calculate_mass_start <- function(fragment_type, Length, strands) {
  case_when(
    fragment_type == 1 ~ 1000,
    fragment_type == 2 ~ (200 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 3 ~ (150 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 4 ~ (100 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 5 ~ 1000,
    TRUE ~ 1000
  )
}

calculate_mass_final <- function(fragment_type, Length, strands) {
  case_when(
    fragment_type == 1 ~ 300,
    fragment_type == 2 ~ (50 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 3 ~ (45 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 4 ~ (35 * ((Length * (307.97 * strands)) + (18.02 * strands)) * 10^-6),
    fragment_type == 5 ~ 300,
    TRUE ~ 300
  )
}

# Helper function to create numeric inputs
create_numeric_inputs <- function(concentrations, prefix, label_prefix) {
  imap(concentrations, ~ {
    numericInput(
      inputId = paste0(prefix      , "_", .y),
      label   = paste0(label_prefix, " ", .y),
      min     = 0,
      max     = 1000
    )
  })
}

# Helper Function: Update samples after QC1
update_samples_after_qc1 <- function(input, setup, samples) {
  qc1_result <- isolate({
    list_rbind(setup$concentrations, names_to = "LibraryTube") %>%
      select(LibraryTube, Conc_QC1 = setup$concentrations)
  })
  req(qc1_result, samples$calculations)
  
  samples$calculations <- samples$calculations %>%
    select(-Conc_QC1) %>%
    left_join(qc1_result, by = join_by(LibraryTube)) %>%
    mutate(TemplateVolLoading = setup$TemplateVolLoading)
  
  req(setup$workflow)
  if (setup$workflow == "rapid16s") {
    req(samples$calculations)
    pool_results <- pooling_calculations(
      Conc_QC1 = samples$calculations$Conc_QC1,
      LibraryTube = samples$calculations$LibraryTube
    )
    
    req(pool_results$TotalPoolVol)
    setup$TotalPoolVol <- as.numeric(pool_results$TotalPoolVol)
    setup$beadvol <- setup$TotalPoolVol * 6
    
    req(pool_results$SampVolPool)
    pool_vols <- list_rbind(pool_results$SampVolPool, names_to = "LibraryTube")
    
    req(pool_vols, samples$calculations, setup$beadvol, setup$TotalPoolVol)
    samples$calculations <- samples$calculations %>%
      select(-SampVolPool) %>%
      left_join(pool_vols, by = join_by(LibraryTube)) %>%
      mutate(TotalPoolVol = setup$TotalPoolVol, BeadVol = setup$beadvol)
  } else if (setup$workflow == "lsk") {
    req(samples$calculations, setup$beadvol, setup$TotalPoolVol)
    samples$calculations <- samples$calculations %>%
      mutate(TotalPoolVol = setup$TotalPoolVol, BeadVol = setup$beadvol)
  }
}

# Helper Function: Update samples after QC2
update_samples_after_qc2 <- function(input, setup, samples) {
  req(setup$workflow, input$Conc_QC2)
  if (setup$workflow == "rapid16s") {
    req(setup$Conc_QC2, setup$InputMassFinal)
    setup$LibraryLoadingVol <- setup$InputMassFinal / setup$Conc_QC2
    setup$LibraryWaterVol <- setup$TemplateVolLoading - setup$LibraryLoadingVol
    
    samples$calculations <- samples$calculations %>%
      mutate(Conc_QC2 = setup$Conc_QC2,
             InputMassFinal = setup$InputMassFinal,
             LibraryLoadingVol = setup$LibraryLoadingVol,
             TemplateVolLoading = setup$TemplateVolLoading,
             LibraryWaterVol = setup$LibraryWaterVol)
  } else if (setup$workflow == "lsk") {
    qc2_result <- isolate({
      list_rbind(setup$concentrations, names_to = "LibraryTube") %>%
        select(LibraryTube, Conc_QC2 = setup$concentrations)
    })
    req(samples$calculations, qc2_result, setup$InputMassFinal, setup$TemplateVolLoading)
    samples$calculations <- samples$calculations %>%
      select(-Conc_QC2) %>%
      left_join(qc2_result, by = join_by(LibraryTube)) %>%
      mutate(InputMassFinal = setup$InputMassFinal,
             TemplateVolLoading = setup$TemplateVolLoading,
             LibraryLoadingVol = InputMassFinal / Conc_QC2,
             LibraryWaterVol = TemplateVolLoading - LibraryLoadingVol)
  }
}


pooling_calculations <- function(Conc_QC1, 
                                 LibraryTube, 
                                 max_pool_volume   = 600, 
                                 min_pool_volume   = 37.5, 
                                 per_sample_volume = 44) {
  if (length(Conc_QC1) == 0) {
    stop("Concentrations vector is empty.")
  }
  if (any(Conc_QC1 <= 0)) {
    stop("All concentrations must be positive.")
  }
  
  # Function to calculate scaled volumes
  scale_volumes <- function(pool_volume) {
    relative_volumes <- (1 / Conc_QC1) / sum(1 / Conc_QC1)
    volumes          <- relative_volumes * pool_volume
    return(volumes)
  }
  
  # Start with max pool volume and calculate initial volumes
  pool_volume <- max_pool_volume
  volumes <- scale_volumes(pool_volume)
  
  # Adjust pool volume if any sample exceeds per_sample_volume
  while (any(volumes > per_sample_volume) && pool_volume > min_pool_volume) {
    pool_volume <- pool_volume - 1
    volumes <- scale_volumes(pool_volume)
  }
  
  # If volumes still exceed per_sample_volume, scale down proportionally
  if (any(volumes > per_sample_volume)) {
    warning("Some samples exceed the available volume even at the minimum pool volume.")
    scale_factor <- per_sample_volume / max(volumes)
    volumes <- volumes * scale_factor
  }
  
  # Return named list of sample volumes and total pool volume
  result <- list(
    SampVolPool = set_names(volumes, LibraryTube),
    TotalPoolVol = pool_volume
  )
  
  return(result)
}