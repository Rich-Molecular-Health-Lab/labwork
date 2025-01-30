# /LibraryPrep/global.R

source("../GlobalScripts/global.R")
global            <- config::get(config = "default")
source(global$set_paths)
source(global$conflicts)
source(global$data_functions)
source(path$inputs)
source(path$steps)
source(path$helper_functions)
source(path$load_data)
source(path$tabs)

