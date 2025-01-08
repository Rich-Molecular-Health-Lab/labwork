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
  "fontawesome",
  "glue",
  "ggtext",
  "gt",
  "gtExtras",
  "gtable",
  "htmltools",
  "kableExtra",
  "MASS",
  "paletteer",
  "pander",
  "pandoc",
  "png",
  "rcompanion",
  "reactable",
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
library(fontawesome)
library(glue)
library(ggtext)
library(gt)
library(gtExtras)
library(gtable)
library(htmltools)
library(kableExtra)
library(MASS)
library(paletteer)
library(pander)
library(pandoc)
library(png)
library(rcompanion)
library(reactable)
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
conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::left_join)
conflicts_prefer(dplyr::inner_join)
conflicts_prefer(dplyr::full_join)
conflicts_prefer(dplyr::semi_join)
conflicts_prefer(dplyr::rename)
conflicts_prefer(ggplot2::margin)
conflicts_prefer(ggplot2::theme_classic)
conflicts_prefer(ggplot2::ggplot)
conflicts_prefer(ggplot2::theme_minimal)
conflicts_prefer(ggplot2::aes)
conflicts_prefer(dplyr::lag)
conflicts_prefer(RefManageR::cite)
conflicts_prefer(shinydashboard::box)
conflicts_prefer(rlang::set_names)
conflicts_prefer(purrr::flatten)
conflicts_prefer(purrr::discard_at)
conflicts_prefer(base::which.max)
conflicts_prefer(lubridate::month)
conflicts_prefer(lubridate::year)
conflicts_prefer(lubridate::day)
conflicts_prefer(base::as.data.frame)
conflicts_prefer(htmltools::p)
