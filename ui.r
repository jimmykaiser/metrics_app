## UI.r
library(shiny)
shinyUI(fluidPage(
  titlePanel("World Development Indicators"),
  sidebarLayout(
    sidebarPanel(
      selectInput("topic", "Select Topic",
                  c("Economic Policy & Debt", "Environment", "Financial Sector", 
                    "Social Protection & Labor", "Education", "Health", 
                    "Private Sector & Trade", "Infrastructure", "Poverty", 
                    "Public Sector", "Gender"),
                  selected = "Financial Sector"),
      selectInput("indicator", "Select Indicator", 
                  c("Access to electricity (% of population)"),
                  selected = "Access to electricity (% of population)"),
      selectInput("comp_topic", "Select Comparison Topic",
                  c("Economic Policy & Debt", "Environment", "Financial Sector", 
                    "Social Protection & Labor", "Education", "Health", 
                    "Private Sector & Trade", "Infrastructure", "Poverty", 
                    "Public Sector", "Gender"),
                  selected = "Economic Policy & Debt"),
      selectInput("comp_indicator", "Select Comparison Indicator", 
                  c("Access to electricity (% of population)"),
                  selected = "Fixed Broadband Subscriptions (per 100 people)"),
      selectInput("region", "Select Region", 
                  c("World", "South Asia", "Europe & Central Asia", 
                    "Middle East & North Africa", "East Asia & Pacific", 
                    "Sub-Saharan Africa", "Latin America & Caribbean", 
                    "North America"),
                  selected = "World"),
      selectInput("income", "Select Income Level", 
                  c("All", "Low income", "Lower middle income", 
                    "Upper middle income", "High income"),
                  selected = "All")
    ),
    mainPanel(
      plotOutput("scatter1", width = "100%", height = "600px"),
      plotOutput("scatter2", width = "100%", height = "600px"),
      plotOutput("hist1", width = "100%", height = "400px"),
      plotOutput("hist2", width = "100%", height = "400px"))
      
  )
))