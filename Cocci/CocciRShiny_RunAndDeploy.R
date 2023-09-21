### Cocci R shiny deployment ####

library(shiny)
setwd("~/Documents/Current Projects/R Shiny")
runApp("Cocci", display.mode = "showcase")

# to deploy after editing app
library(rsconnect)
rsconnect::deployApp('Cocci')
