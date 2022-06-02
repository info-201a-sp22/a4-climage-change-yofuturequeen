library(plotly)
library(dplyr)

climate_df <- read.csv('owid-co2-data.csv')
min_year <- min(climate_df$year)
max_year <- max(climate_df$year)
rm(list = ls())
# Questions
# Which country has the highest average carbon dioxide emissions?
# Which country has the highest average carbon dioxide emissions per capita?
# Which country has the highest average growth in percentage of CO2 emissions from 1990-2020?
# What is the average annual consumption based emissions of CO2 per person in America? How does that compare to the rest of the world?
# What year did America have the highest total green house gas emissions?
# filtered = climate_df[climate_df$country != "World"]
highest_CO2 <- climate_df %>% 
  group_by(country) %>% 
  summarise(average = mean(co2, na.rm = TRUE)) %>% 
  arrange(desc(average))


highest_CO2_capita <- climate_df %>% 
  group_by(country) %>% 
  summarise(average = mean(co2_per_capita)) %>% 
  filter(average == max(average, na.rm = TRUE)) %>% 
  pull(country)

max_avg_growth <- climate_df %>% 
  group_by(country) %>% 
  filter(year >= 1990 & year <= 2020) %>% 
  summarise(avg_growth = mean(co2_growth_prct, na.rm = TRUE)) %>%
  filter(avg_growth == max(avg_growth, na.rm = TRUE)) %>% 
  pull(country)

avg_america <- climate_df %>% 
  filter(country == "United States") %>% 
  summarise(avg_consumption = mean(consumption_co2, na.rm = TRUE))
  
avg_world <- climate_df %>% 
  summarise(avg_consumption = mean(consumption_co2, na.rm = TRUE))

highest_ghg_year <- climate_df %>% 
  filter(country == "United States") %>% 
  filter(total_ghg == max(total_ghg, na.rm = TRUE)) %>% 
  pull(year)
