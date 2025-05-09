# /LibraryPrep/global.R

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

required_packages <- c(
  "knitr",
  "bookdown",
  "bsicons",
  "bslib",
  "config",
  "conflicted",
  "devtools",
  "downloadthis",
  "fontawesome",
  "glue",
  "ggtext",
  "gt",
  "gtExtras",
  "gtable",
  "here",
  "htmltools",
  "kableExtra",
  "MASS",
  "paletteer",
  "pander",
  "pandoc",
  "png",
  "rcompanion",
  "reactable",
  "reactablefmtr",
  "rmarkdown",
  "sass",
  "scales",
  "shinydashboard",
  "shinyjs",
  "shinyMatrix",
  "shinyTime",
  "showtext",
  "tidyverse",
  "usethis",
  "utf8",
  "rmdformats"
)

if (!exists("packages_checked")) {
  install_missing_packages(required_packages)
  packages_checked <- TRUE
}

library(knitr)
library(bookdown)
library(bsicons)
library(bslib)
library(conflicted)
library(devtools)
library(downloadthis)
library(fontawesome)
library(glue)
library(ggtext)
library(gt)
library(gtExtras)
library(gtable)
library(here)
library(htmltools)
library(kableExtra)
library(MASS)
library(paletteer)
library(pander)
library(pandoc)
library(png)
library(rcompanion)
library(reactable)
library(reactablefmtr)
library(rmarkdown)
library(sass)
library(scales)
library(shinydashboard)
library(shinyjs)
library(shinyMatrix)
library(shinyTime)
library(showtext)
library(tidyverse)
library(usethis)
library(utf8)
library(rmdformats)