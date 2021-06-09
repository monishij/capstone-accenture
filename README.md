# Capstone-Accenture
## Quick Start
* **ModelingAndForecasting.Rmd** - This is the main notebook that you would run for all the modeling and forecasting we do. It also has an html version called project.html. In order to run it, make sure you clone the whole project directory in order to load the data correctly from the csv. You need both the fireClimateHumanTable_editted.csv data file, as well as the neighborhoodMatrix.csv file. 
* **carbayes_modelling.Rmd** - This file contains all the carbayes modeling and visualization code. Some of its code is also in the main ModelingAndForecasting.Rmd file.
*  **random_effects_modelling.Rmd** - This file contains all the random effects modeling and visualization code. Some of its code is also in the main ModelingAndForecasting.Rmd file.

## Overview
Objective: _This project was given to us from Accenture and the goal was to predict the count of expected wildfire occurrences given a specific place and time within California, alongside a number of different climate and human trigger predictors._
###### [Final Presentation Slides](https://docs.google.com/presentation/d/1BaUYOd9fSTpOck-UvabJV88RA19hK-9buZca3cSzpWM/edit?usp=sharing)
###### [Final Report](https://docs.google.com/document/d/1GIkJEb_67aBy-VaFmIKQtdY-lIrFoGowJ3qIjdc_yOU/edit?usp=sharing) 

### /clean_data
* **fireClimateHumanTable.csv** - Contains information about fire, climate, population, and housing data on a monthly level from 2013-2019 for each county. (PostgreSQL final table output). 
* **fireClimateHumanTable_editted.csv** - MAIN FILE to use for QuickStart. Revised and editted version. Contains month_factor which is neccessary for our modeling inputs.
* **neighborhoodMatrix.csv** - Adjacency matrix that represents a finite graph on all the neighboring counties in California. 
### /cleaning_data_scripts
* /Python
  * **geoLocation-fire-climate.ipynb** - Grabs county information based on lat/long coordinates. Used for raw fire data and raw climate data.
  * **humantrigger-population-housing.ipynb** - Clean and formatting data to insert as a table in PostgreSQL. Used for raw population data and raw housing data.
* /SQL
  * **cleaningData.sql** - Further cleaning and combining of all tables created. Overall creates our final table and /COPY command for csv file.
  * **create_tables.sql** - Creates empty tables and commented /COPY commands for inserting our data.
### /data_visualizations. -------> add in joya -> the R title
* **EDA for Summer Months.ipynb** - Insights about the data collected, specifically for summer months.
* **Posterior Predictive Check.ipynb** - Visualization for our CARBayes model performance.
* **california.png** - PNG file used as background for spatial visualization.
* **pythonEDA(main).ipynb** - Insights about the data collected and further comments on what we learned from them. 
### /raw_data
* /forSQL
  * **newClimateData.csv** - Cleaned climate data, representing the average climate on a monthly basis from 2013-2019.
  * **newFireData.csv** - Cleaned fire data, representing the details of a fire incident from 2013-2019.
  * **newHousingData.csv** - Cleaned housing data, representing the housing density of a specific county for each year.
  * **newPopulationData.csv** - Cleaned population data, representing the population and population density of a specific county for each year. (Note: LandArea information and PopulationDensity were manually imported/calculated using Excel)
* **newPopulationData0.csv** - Cleaned population data, representing the population of a specific county for each year.
* **raw_CountyHousingData.csv** - True raw version of housing data. Information was pulled from US Census.
* **raw_CountyHousingData2.csv** - Manually edited version of raw housing data. Removed headers manually for easier file read in Python.
* **raw_CountyPopulationData.csv** - True raw version of population data. Information was pulled from US Census.
* **raw_CountyPopulationData2.csv** - Manually edited version of raw population data. Removed headers manually for easier file read in Python.
* **raw_climateData.csv** - True raw version of climate data using CDS API in Python.
* **raw_fireData.csv** - True raw version of fire data. Information was pulled from fire.ca.gov
### /retrieving_climate_data
* **retrieveCDSclimateData.py** - Python script to use Copernicus API and grab the neccessary climate features.
### /tableau
* /images
 * **/Line** - Data used for the Line Dashboard.
 * **/Map** - Data used for the Map Dashboard.
 * **/images** - Screenshot images of the dashboards used.
 * **workbook.twb** - Tableau workbook space. Contains all visuals and how it was created.
