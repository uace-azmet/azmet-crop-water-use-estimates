

# Shiny app to estimate crop water use from measurements at AZMet stations

# Add code for the following
# 
# 'azmet-shiny-template.html': <!-- Google tag (gtag.js) -->
# 'azmet-shiny-template.html': <!-- CSS specific to this AZMet Shiny app -->


# Libraries
library(azmetr)
library(dplyr)
library(htmltools)
library(lubridate)
library(shiny)
library(stringr)
library(vroom)

# Functions
#source("./R/fxnABC.R", local = TRUE)

# Scripts
#source("./R/scr##DEF.R", local = TRUE)


# UI --------------------

ui <- htmltools::htmlTemplate(
  
  "azmet-shiny-template.html",
  
  sidebarLayout = sidebarLayout(
    position = "left",
    
    sidebarPanel(
      id = "sidebarPanel",
      width = 4,
      
      verticalLayout(
        helpText(em(
          "Select an AZMet station, crop, and planting date. Then, click or tap 'Estimate Water Use'."
        )),
        
        br(),
        selectInput(
          inputId = "azmetStation", 
          label = "AZMet Station",
          choices = stationNames[order(stationNames$stationName), ]$stationName,
          selected = stationNames[order(stationNames$stationName), ]$stationName[1]
        ),
        
        selectInput(
          inputId = "annualCrop", 
          label = "Annual Crop",
          choices = cropGrowingSeasonLengths[order(cropGrowingSeasonLengths$crop), ]$crop,
          selected = cropGrowingSeasonLengths[order(cropGrowingSeasonLengths$crop), ]$crop[1]
        ),
        
        dateInput(
          inputId = "plantingDate",
          label = "Planting Date",
          value = Sys.Date() - 7,
          min = lubridate::today() - lubridate::years(1),
          max = Sys.Date() - 1,
          format = "MM d, yyyy",
          startview = "month",
          weekstart = 0, # Sunday
          width = "100%",
          autoclose = TRUE
        ),
        
        br(),
        actionButton(
          inputId = "estimateWaterUse", 
          label = "Estimate Water Use",
          class = "btn btn-block btn-blue"
        )
      )
    ), # sidebarPanel()
    
    mainPanel(
      id = "mainPanel",
      width = 8,
      
      fluidRow(
        column(width = 11, align = "left", offset = 1, htmlOutput(outputId = "tableTitle"))
      ),
      
      fluidRow(
        column(width = 11, align = "left", offset = 1, htmlOutput(outputId = "tableSubtitle"))
      ),
      
      br(),
      #fluidRow(
      #  column(width = 11, align = "left", offset = 1, tableOutput(outputId = "dataTablePreview"))
      #), 
      
      fluidRow(
        column(width = 11, align = "left", offset = 1, htmlOutput(outputId = "tableCaption"))
      ),
      
      #br(),
      #fluidRow(
      #  column(width = 11, align = "left", offset = 1, uiOutput(outputId = "downloadButtonTSV"))
      #),
      
      br(), br(),
      fluidRow(
        column(width = 11, align = "left", offset = 1, htmlOutput(outputId = "tableFooter"))
      ),
      br()
    ) # mainPanel()
  ) # sidebarLayout()
) # htmltools::htmlTemplate()


# Server --------------------

server <- function(input, output, session) {
  
  # Reactive events -----
  
  # Build table caption
  tableCaption <- eventReactive(input$estimateWaterUse, {
    tableCaption <- fxnTableCaption(
      azmetStation = input$azmetStation,
      annualCrop = input$annualCrop
    )
  })
  
  # Build table footer
  tableFooter <- eventReactive(input$estimateWaterUse, {
    tableFooter <- fxnTableFooter(
      annualCrop = input$annualCrop
    )
  })
  
  # Build table subtitle
  tableSubtitle <- eventReactive(input$estimateWaterUse, {
    tableSubtitle <- fxnTableSubtitle()
  })
  
  # Build table title
  tableTitle <- eventReactive(input$estimateWaterUse, {
    tableTitle <- fxnTableTitle(
      azmetStation = input$azmetStation,
      annualCrop = input$annualCrop
    )
  })
  
  # Outputs -----
  
  output$tableCaption <- renderUI({
    tableCaption()
  })
  
  output$tableFooter <- renderUI({
    tableFooter()
  })
  
  output$tableSubtitle <- renderUI({
    tableSubtitle()
  })
  
  output$tableTitle <- renderUI({
    tableTitle()
  })
}

# Run --------------------

shinyApp(ui = ui, server = server)