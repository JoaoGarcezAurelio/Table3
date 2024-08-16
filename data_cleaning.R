# Key packages for the app

# install.packages("shiny") # For the shiny app
# install.packages("bslib") # For certain shiny app traits
# install.packages("readr") # For loading csv
# install.packages("shinythemes") # For shiny themes
# install.packages("thematic") # For consistence between layout and plots
# install.packages("reactable") # For table
# install.packages("reactablefmtr") # For table
# install.packages("here") # For file management
# install.packages("shinylive") # For github optimisation

# Loading the packages

library(shiny) 
library(bslib)
library(readr)
library(shinythemes)
library(thematic)
library(reactable)
library(reactablefmtr)
library(here)
library(shinylive)

# Uploading the table

Table3 <- read_csv(here("Data",
                        "Processed Data",
                        "Table3.csv"))

# Creating a tooltip option

# Creating a tooltip option that will be used in the headers.

with_tooltip <- function(value, tooltip) {
  tags$abbr(style = "text-decoration: underline; text-decoration-style: dotted; cursor: help",
            title = tooltip, value)
}
