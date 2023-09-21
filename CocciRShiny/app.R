### R shiny app showing location of origin for Cocci genomic resources

#### Load libraries and data frame
library(shiny)
library(leaflet)
library(dplyr)


df = read.csv("data/GenomicsSampleBank.csv")

#### Define user interface for application

ui <- fluidPage(
  titlePanel(p("Coccidioides genomic resources", style = "color:#3474A7")),
  sidebarLayout(
    sidebarPanel(
      helpText("Visualize location of origin of Cocci-positive soil samples 
               and/or prevoiusly published genomes"),
      # Create checkbox for sample site
      checkboxGroupInput("checkGroup", 
                         h3("Sample Site"), 
                         choices = list("Published genome" = "SRA",
                                        "Coalinga" = "JT_Coalinga", 
                                        "Bakersfield" = "JT_Bakersfield", 
                                        "Highway 33" = "JT_Highway33",
                                        "Carrizo" = "Carizzo"),
                         selected = c("SRA", "Carizzo", "JT_Bakersfield",
                                      "JT_Highway33", "JT_Coalinga")),
      # Create selection for type of sample (e.g., environmental/host)
      selectInput(inputId = "variableselected",
        label = "Select Collection Type",
        choices = c("Soil", "Burrow", "Host"))),
    # Display map
    mainPanel(leafletOutput("mymap",height = 1000))))

### Define server function (i.e. info about how to build the app)
server <- function(input,output, session){
  data <- reactive({
    x <- df})  
  
  output$mymap <- renderLeaflet({
    df <- data()
   df = df[df$Type == input$variableselected,]
   df = df[df$Source == input$checkGroup,]
    m <- leaflet(data = df) %>%
      addTiles() %>%
      addMarkers(lng = ~Longitude, 
                 lat = ~Latitude,
                 popup = paste("Source", df$Source, "<br>",
                               "Year", df$Year))
    m
  }) 
}

### Run the application 
shinyApp(ui = ui, server = server)
