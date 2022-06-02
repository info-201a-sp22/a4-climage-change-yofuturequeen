library(bslib)
library(shiny)
library(plotly)

climate_df <- read.csv("owid-co2-data.csv")

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

sidebar_widgets <- sidebarPanel(
  selectInput(inputId = "country_select",
              label = h3("Choose Country"),
              choices = climate_df$country,
  multiple = TRUE
  ),
  
  sliderInput(
    inputId = "years",
    label = "Years Selected:",
    min = 1980,
    max = 2020,
    value = c(1980, 2020), sep = ""
  )
)


main_plot <- mainPanel(
  plotlyOutput(outputId = "climate_plot")
)

chart_tab <- tabPanel(
  "Climate Change Over Time",
  sidebarLayout(
    sidebar_widgets,
    main_plot),
    p("The purpose of this chart is to be able to visualize and compare different countries' carbon dioxide emissions per capita for whichever time period they choose between 1980-2020. Because the chart gives the option to change the time period, it allows users to discover trends within the same country as well and see how it matches up against countries from the same time period.", align = "center")
  )


ui <- navbarPage(
  theme = shiny_theme,
  "Climate Change",
  intro_tab,
  chart_tab
)