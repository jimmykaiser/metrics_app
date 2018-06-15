# Metrics App

## The Data
This Shiny app displays [World Development Indicators](https://datacatalog.worldbank.org/dataset/world-development-indicators) from the World Bank. These indicators show how countries are performing in a variety of development areas, including the environment, health, education, and the economy.

## The Metrics App
The Metrics App can be used for descriptive analysis and quality control checks on large sets of metrics. It is particularly useful when the data set contains metrics calculated the same way from one year to the next. Visual representations of distributions can often uncover trends and problems that descriptive statistics miss. 

The plots include:

1. **Metric Comparison**: This scatter plot compares two metrics from the same year and can be used to explore relationships between the metrics and identify outliers. 
2. **Metric Versus Previous Year**: This scatter plot compares the selected metric to the previous year's values. If the metric is stable, most value should be close to the X = Y line. 
3. **Comparison Histograms**: These histograms compare the distribution of the selected metric to the previous year's distribution, enabling the user to identify trends or unexpected shifts in values. 