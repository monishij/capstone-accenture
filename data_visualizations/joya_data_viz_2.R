library(ggplot2)
library(ggforce)
library(tidyverse)

# need to run install.packages('ggforce') if you dont have it

data = read.csv("~/Documents/GitHub/capstone-accenture/clean_data/fireClimateHumanTable.csv")

ggplot(data, aes(y=total_precipitation, x=as.factor(count))) +
  geom_violin(color = 'transparent', fill = 'gray10') +
  geom_sina(size = 0.75, alpha=0.1) +
  xlab('Number of Fires') + ylab('Total Precipitation (m)') +
  ggtitle('Distribution of Total Precipitation for Each Count') +
  theme_minimal()

temperature_F <- (data$X2m_temperature - 273.15)*(9/5) + 32

ggplot(data, aes(y=temperature_F, x=as.factor(count))) +
  geom_violin(color = 'transparent', fill = 'gray90') +
  geom_sina(size = 0.75, alpha = 0.5) +
  xlab('Number of Fires') + ylab('2m Temperature (Fahrenheit)') +
  ggtitle('Distribution of 2m Temperature for Each Count') +
  theme_minimal()

ggplot(data, aes(y=volumetric_soil_water_layer_1, x=as.factor(count))) +
  geom_violin(color = 'transparent', fill = 'gray90') +
  geom_sina(size = 0.75, alpha = 0.5) +
  xlab('Number of Fires') + ylab('Volumetric Soil Water Layer') +
  ggtitle('Distribution of Volumetric Soil Water Layer for Each Count') +
  theme_minimal()


ggplot(data, aes(y=housingdensity, x=as.factor(count))) +
  geom_violin(color = 'transparent', fill = 'gray90') +
  geom_sina(size = 0.75, alpha = 0.5) +
  xlab('Number of Fires') + ylab('County Housing Density') +
  ggtitle('Distribution of County Housing Density for Each Count') +
  theme_minimal()


ggplot(data, aes(y=population, x=as.factor(count))) +
  geom_violin(color = 'transparent', fill = 'gray90') +
  geom_sina(size = 0.75, alpha = 0.5) +
  xlab('Number of Fires') + ylab('County Population') +
  ggtitle('Distribution of County Population for Each Count') +
  theme_minimal()
