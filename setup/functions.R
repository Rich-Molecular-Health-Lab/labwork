install_missing_packages <- function(required_packages) {
  installed_packages <- rownames(installed.packages())
  missing_packages   <- setdiff(required_packages, installed_packages)
  
  if (length(missing_packages) > 0) {
    message("Installing missing packages: ", paste(missing_packages, collapse = ", "))
    install.packages(missing_packages)
  } else {
    message("All required packages are already installed.")
  }
}

fix.strings <-  function(df) {
  df <- df %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("'")))) %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("[")))) %>%
    mutate(across(where(is.character), ~str_remove_all(.x, fixed("]")))) %>%
    mutate(across(where(is.character), ~str_trim(.x, "both"))) %>%
    mutate(across(where(is.character), ~str_squish(.x)))
  return(df)
}

export.list <- function(df, path) {
  write.table(df,
              paste0(path),
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE,
              col.names = FALSE)
}


backup.df  <- function(df, directory, prefix) {
  write.table(df,
              paste0(directory, prefix, "_", Sys.Date(), ".tsv"),
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}


since.start <- function(day1, date.col, units) {
  as.numeric(as.period(interval(ymd(day1), date.col), unit = units), units)
}


check.duplicates <- function(df2, df, group) {
  df2 <- df %>%
    group_by(group) %>%
    filter(n() > 1) %>%
    ungroup()
}


read.tables <- function(file) {
  data <- read.table(file, 
                     header = TRUE, 
                     sep = "\t", 
                     stringsAsFactors = FALSE) %>%
    tibble()
  return(data)
}


read.recent.version.csv <- function(directory, pattern) {
  files             <- list.files(path       = paste0(directory), 
                                  pattern    = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.csv"), 
                                  full.names = TRUE)
  dates             <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.csv", "\\1", files)
  dates             <- as.Date(dates, format = "%Y-%m-%d")
  most_recent_index <- which.max(dates)
  most_recent_file  <- files[most_recent_index]
  data              <- read.csv(most_recent_file, header = TRUE)
  
  return(data)
}


read.recent.version.tsv <- function(directory, pattern) {
  files             <- list.files(path       = paste0(directory), 
                                  pattern    = paste0(pattern, "\\d{4}-\\d{1,2}-\\d{1,2}\\.tsv"), 
                                  full.names = TRUE)
  dates             <- gsub(".*_(\\d{4}-\\d{1,2}-\\d{1,2})\\.tsv", "\\1", files)
  dates             <- as.Date(dates, format = "%Y-%m-%d")
  most_recent_index <- which.max(dates)
  most_recent_file  <- files[most_recent_index]
  data              <- read.table(most_recent_file, sep = "\t", header = T)
  
  return(data)
}

read_abundance_file  <- function(file) {
  read.table(file, 
             stringsAsFactors = FALSE, 
             header = T,
             sep = "\t")
}


read.tables <- function(file) {
  data <- read.table(file, 
                     header = TRUE, 
                     sep = "\t", 
                     stringsAsFactors = FALSE) %>%
    tibble()
  return(data)
}

read_alignment_file  <- function(file) {
  read.csv(file, stringsAsFactors = FALSE, fill = T, header = T, blank.lines.skip = T)
}


read.csvs <- function(file) {
  data <- read.table(file, 
                     header = TRUE, 
                     sep = ",", 
                     stringsAsFactors = FALSE) %>%
    tibble()
  return(data)
}

yes.no.aggregated <- function(col) {
  JS("
  function(cellInfo) {
        const values = cellInfo.subRows.map(function(row) { 
        return row['col'] === 'no' ? '\u274c No' : '\u2714\ufe0f Yes' 
        })
      
      // Count occurrences of each value
      const counts = values.reduce(function(acc, v) {
        acc[v] = (acc[v] || 0) + 1;
        return acc;
      }, {});
      
      // Format the counts as a string
      return Object.entries(counts)
        .map(([key, count]) => `${key}: ${count}`)
        .join(', ');
  }
  ")
}

open.job <- function(name, mem, hrs, cpus) {
  paste0("paste to terminal:\n\nsrun --partition=guest --nodes=1 --ntasks-per-node=1", paste0(" --job-name=", name, " --mem=", mem, "GB --time=", hrs, ":00:00 --cpus-per-task=", cpus), "--pty $SHELL\n\n")
}

conda.env <- function(env) {
  cat("paste to terminal:\n\ncd", params$work_dir, "\nmodule load anaconda\nconda activate", env, "\n\n")
}

load.pkg <- function(pkg, wd) {
  cat("paste to terminal:\n\ncd", paste0(params$work_dir, wd), "\nmodule load", pkg, "\n\n")
}

sbatch <- function(script) {
  cat("paste to terminal:\n\ncd", params$work_dir, "\n\nsbatch", paste0(script, ".sh"), "\n\nsqueue -u aliciarich\n\n")
}

name.subdir <- function(name, subdir) {
  cat("paste to terminal:\n\n", paste0(name, "=", params$work_dir, subdir), "\n\n", paste0("mkdir -p", " $", name), "\n\n")
}

out.dir <- function(name) {
  cat("paste to terminal:\n\n", paste0(name, "=", params$work_dir, "/", name, "/", params$seqrun, "/", params$date), "\n\n", paste0("mkdir -p", " $", name), "\n\n")
}

read_alignment_file  <- function(file) {
  read.csv(file, stringsAsFactors = FALSE, fill = TRUE)
}

export_table <- function(df, path) {
  write.table(df,
              path,
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}


export_extracts <- function(path) {
  write.table(blank.extracts,
              path,
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}

export_libraries <- function(path) {
  write.table(blank.libraries,
              path,
              sep       = "\t",
              quote     = FALSE,
              row.names = FALSE)
}



read_extracts <- function(path) {
  tibble <- read.table(path, sep = "\t", header = TRUE) %>% 
    mutate(CollectionDate = ymd(CollectionDate), 
           ExtractDate    = ymd(ExtractDate))
  
  return(tibble)
}


read_libraries <- function(path) {
  tibble <- read.table(path, sep = "\t", header = TRUE) %>% 
    mutate(LibPrepDate = ymd(LibPrepDate))
  
  return(tibble)
}
