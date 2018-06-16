## Import scatter and histogram functions
source("make_scatter.r")
source("make_hist.r")

## Function to produce year-over-year same metric comparison scatter
make_scatter_yoy <- function(df, met, this_year, reg = "World", inc = "All") {
  last_year = (this_year - 1)
  df <- df %>% filter(Indicator == met)
  if (reg != "World") {
    df <- df %>% filter(Region == reg)
  }
  if (inc != "All") {
    df <- df %>% filter(Income == inc)
  }
  df <- df %>% unite(Indicator, Indicator, Year, sep = " ") %>%
    select(Country, Indicator, Value)
  g <- make_scatter(df, paste(met, last_year, sep = " "),
                     paste(met, this_year, sep = " "),
                     "Indicator Versus Previous Year",
                     year_over_year = 1)
  g <- ggplotly(g, tooltip = "text")
  return(g)
}

## Function to produce scatter to compare metric to given variable
make_scatter_comp <- function(df, met, comp_met, this_year, reg = "World", inc = "All") {
  last_year = (this_year - 1)
  df <- df %>% filter(Indicator %in% c(met, comp_met), Year == this_year)
  if (reg != "World") {
    df <- df %>% filter(Region == reg)
  }
  if (inc != "All") {
    df <- df %>% filter(Income == inc)
  }
  df <- df %>% select(Country, Indicator, Value)
  g <- make_scatter(df, comp_met, met, "Indicator Comparison")
  g <- ggplotly(g, tooltip = "text")
  return(g)
}

## Function to make metric histograms on same scale for year-over-year comparisons
make_hist_metric <- function(df, met, yr, this_year_flag = 1, 
                             reg = "World", inc = "All") {
  df <- df %>% filter(Indicator == met)
  if (reg != "World") {
    df <- df %>% filter(Region == reg)
  }
  if (inc != "All") {
    df <- df %>% filter(Income == inc)
  }
  df <- df %>% unite(Indicator, Indicator, Year, sep = " ") %>%
    select(Country, Indicator, Value)
  if (this_year_flag == 1) {
    h <- make_hist(df, paste(met, yr, sep = " "),
                   paste(met, (yr - 1), sep = " "),
                   paste(yr, "Value", sep = " "))
    h <- ggplotly(h)
  } else {
    h <- make_hist(df, paste(met, yr, sep = " "),
                   paste(met, (yr + 1), sep = " "),
                   paste(yr, "Value", sep = " "))
    h <- ggplotly(h)
  }
  return(h)
}
