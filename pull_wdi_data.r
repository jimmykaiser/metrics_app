## Prep WDI data for app

# Libraries
library(dplyr)
library(tidyr)
repo_dir <- "/Users/admin/git-repos/metrics_app/"

# Raw WDI data
wdi_data_raw <- read.csv(paste0(repo_dir, "data/WDIData.csv"), stringsAsFactors = FALSE)

# Indicator data
wdi_series <- read.csv(paste0(repo_dir, "data/WDISeries.csv"), stringsAsFactors = FALSE) %>% 
  select_("Indicator.Code" = "Series.Code", "Topic") %>% 
  # Use general category instead of detail 
  mutate(Topic = sapply(strsplit(Topic, split = ":"), `[`, 1))

# Country data
wdi_country <- read.csv(paste0(repo_dir, "data/WDICountry.csv"), stringsAsFactors = FALSE) %>% 
  select_("Country.Code", "Region", "Income" = "Income.Group") %>% 
  # Remove non-country rows
  filter(Region != "")

# Filter to recent years and make long
wdi_data <- wdi_data_raw %>% select_("Country" = "Country.Name", "Country.Code",
                           "Indicator" = "Indicator.Name",
                          "Indicator.Code", "X2015", "X2016") %>% 
  # join topics for indicators
  left_join(wdi_series, by = "Indicator.Code") %>% 
  # join region and income level for countries
  inner_join(wdi_country, by = "Country.Code") %>% 
  select(-Country.Code, -Indicator.Code) %>% 
  # make table long
  gather(key = "Year", value = "Value", -Country, -Indicator, -Topic, -Region, -Income) %>% 
  mutate(Year = substr(Year, 2, 5))

# Export as csv for app
write.csv(wdi_data, paste0(repo_dir, "data/wdi_data.csv"), na = "", row.names = FALSE)
