## Server.r

## Load packages and data
library(shiny)
library(ggplot2)
library(dplyr)
library(tidyr)
this_year <- 2016
last_year <- (this_year - 1)

## Import functions for plots
source("plot_functions.r")

## Import data
wdi_data <- read.csv("./data/wdi_data.csv", stringsAsFactors = FALSE)

## Start server
shinyServer(

  function(input, output, session) {

    ## Take input from dropdown menus and listen for changes
    indicator_list <- reactive({
      indicator_list <- unique(wdi_data[wdi_data$Topic == input$topic, c("Indicator")])
    })
    
    observe({
      updateSelectInput(session, "indicator", choices = indicator_list())
    }) 
    
    comp_indicator_list <- reactive({
      indicator_list <- unique(wdi_data[wdi_data$Topic == input$comp_topic, c("Indicator")])
    })

    observe({
      updateSelectInput(session, "comp_indicator", choices = comp_indicator_list())
    })

    new_indicator <- reactive({
      input$indicator
    })

    new_topic <- reactive({
      input$topic
    })
    
    new_comp_indicator <- reactive({
      input$comp_indicator
    })
    
    new_comp_topic <- reactive({
      input$comp_topic
    })

    new_region <- reactive({
      input$region
    })

    new_income <- reactive({
      input$income
    })

    ## Produce plots
    
    output$scatter1 <- renderPlot({
      make_scatter_comp(wdi_data, met = new_indicator(), 
                        comp_met = new_comp_indicator(),
                        this_year = this_year,
                        reg = new_region(), inc = new_income())
    })
    
    output$scatter2 <- renderPlot({
      make_scatter_yoy(wdi_data, met = new_indicator(), this_year = this_year,
                       reg = new_region(), inc = new_income())
    })
    
    output$hist1 <- renderPlot({
      make_hist_metric(wdi_data, met = new_indicator(), 
                       yr = this_year, this_year_flag = 1,
                       reg = new_region(), inc = new_income())
    })

    output$hist2 <- renderPlot({
      make_hist_metric(wdi_data, met = new_indicator(), 
                       yr = last_year, this_year_flag = 0,
                       reg = new_region(), inc = new_income())
    })

})
