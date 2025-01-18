# /LibraryPrep/server/helper_functions.R

source(global$global_helpers)

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