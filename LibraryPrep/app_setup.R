here::i_am("LibraryPrep/app_setup.R")

path              <- config::get(config = "libprep")

source(here(libprep$colDefs))
source(here(libprep$materials))
source(here(libprep$list_protocols))
source(here(libprep$protocol_modules))
source(here(libprep$setupModule))
