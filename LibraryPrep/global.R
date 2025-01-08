# /LibraryPrep/global.R

source("../GlobalScripts/global.R")

path        <- config::get(config = "libprep")
loris       <- config::get(config = "loris")
bats        <- config::get(config = "bats")
marmoset    <- config::get(config = "marmoset")
isolates    <- config::get(config = "isolates")
envir       <- config::get(config = "envir")

source(paste0(path$inputs))
source(paste0(path$steps))
source(paste0(path$helper_functions))
source(paste0(path$load_data))
source(paste0(path$tabs))

