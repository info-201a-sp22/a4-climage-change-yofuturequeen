#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)


shinyServer(function(input, output) {

    output$climate_plot <- renderPlotly({
      
      filtered_df <- climate_df %>% 
        filter(year >= 1980 & year <= 2020) %>% 
        select(year, country, co2_per_capita) %>% 
        filter(country %in% input_country_selection)
      
      co2_plot <- ggplot(data = filtered_df) +
        geom_line(aes(x = year, y = co2_per_capita, color = country))
    })

})
