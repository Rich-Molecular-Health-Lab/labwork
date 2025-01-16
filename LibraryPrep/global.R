# /LibraryPrep/global.R

source("../GlobalScripts/global.R")

global            <- config::get(config = "default")
path              <- config::get(config = "libprep")
loris             <- config::get(config = "loris")
bats              <- config::get(config = "bats")
marmoset          <- config::get(config = "marmoset")
isolates          <- config::get(config = "isolates")
envir             <- config::get(config = "envir")
sample_sheets     <- config::get(config = "sample_sheets")
barcode_alignments<- config::get(config = "barcode_alignments")
methods_16s       <- config::get(config = "methods_16s")

source(global$conflicts)
source(paste0(path$inputs))
source(paste0(path$steps))
source(paste0(path$helper_functions))
source(paste0(path$load_data))
source(paste0(path$tabs))

