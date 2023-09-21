### Cocci R shiny deployment ####

library(shiny)
setwd("~/Documents/Current Projects/GenomicsSampleBank")
runApp("CocciRShiny", display.mode = "showcase")

# to deploy after editing app
library(rsconnect)
rsconnect::deployApp('CocciRShiny')
