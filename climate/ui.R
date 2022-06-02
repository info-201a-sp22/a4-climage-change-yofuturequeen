#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(bslib)
library(shiny)

shiny_theme <- bs_theme(bg = "black",
                        fg = "white",
                        primary = "white")
shiny_theme <- bs_theme_update(shiny_theme, bootswatch = "sandstone")

intro_tab <- tabPanel(
  "Introduction",
  fluidPage(
    includeMarkdown("summary.md")
  )
)

# Define UI for application that draws a histogram

sidebar_widget1 <- sidebarPanel(
  selectInput("select", label = h3("Choose Country"),
  choices = chart_df$country),
  size = 5,
  multiple = 3
)

sidebar_widget2 <- sliderInput("Year",
            "Years Selected:",
            min = 1980,
            max = 2020,
            value = c(1980, 2020)
)

main_plot <- mainPanel(
  plotlyOutput(outputId = "climate_plot")
)

chart_tab <- tabPanel(
  "Climate Change Over TIme",
  sidebarLayout(
    sidebar_widget1,
    sidebar_widget2,
    main_plot
  )
)
  
ui <- navbarPage(
  theme = shiny_theme,
  "climate Change",
  intro_tab,
  chart_tab
  )