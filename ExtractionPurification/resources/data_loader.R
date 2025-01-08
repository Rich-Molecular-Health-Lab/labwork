# /ExtractionPurification/data_loader.R

samples.loris    <- read.table(path$samples_loris   , sep = "\t", header = TRUE) %>% mutate(CollectionDate = ymd(CollectionDate))
samples.marmoset <- read.table(path$samples_marmoset, sep = "\t", header = TRUE) %>% mutate(CollectionDate = ymd(CollectionDate))
samples.isolates <- read.table(path$samples_isolates, sep = "\t", header = TRUE) %>% mutate(CollectionDate = ymd(CollectionDate))
samples.bats     <- read.table(path$samples_bats    , sep = "\t", header = TRUE) %>% mutate(CollectionDate = ymd(CollectionDate))
samples.envir    <- read.table(path$samples_envir   , sep = "\t", header = TRUE) %>% mutate(CollectionDate = ymd(CollectionDate))

source(paste0(path$resources, "rxn_volumes.R"))
source(paste0(path$resources, "data_gt.R"))