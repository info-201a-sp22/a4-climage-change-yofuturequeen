
library(markdown)
library(plotly)
library(shiny)
library(ggplot2)
library(dplyr)

climate_df <- read.csv("owid-co2-data.csv")

server <- (function(input, output) {
  
  output$climate_plot <- renderPlotly({
    validate(
      need(input$country_select, "Select a country")
    )
    filtered_df <- climate_df %>% 
      filter(country %in% input$country_select) %>% 
      filter(year >= input$years[1] & year <= input$years[2])
    
    co2_plot <- ggplot(data = filtered_df) +
      geom_line(aes(x = year, y = co2_per_capita, color = country)) + labs(title = "CO2 Emissions per Capita Over Time", x = "Year", y = "CO2 Emissions per Capita")
    
    return(ggplotly(co2_plot))
  })
  
})
