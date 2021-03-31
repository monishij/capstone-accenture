import cdsapi
import xarray as xr

import pandas as pd

cds = cdsapi.Client()


cds.retrieve('reanalysis-era5-single-levels-monthly-means', {
           "variable": ["Total precipitation", "2m_temperature",
           "10m_wind_speed", "volumetric_soil_water_layer_1",
           "High vegetation cover",
           "Total cloud cover", "Low vegetation cover"],
           "product_type": "monthly_averaged_reanalysis",
           "year": [2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020],
           "month": [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
           "time": "00:00",
           "area": [42, -124, 33, -116],
           "format": "netcdf"}, 
           'climateData.nc')

ds_era5 = xr.open_dataset('climateData.nc')
df = ds_era5.to_dataframe()
df.columns = ["2m_temperature", "total_precipitation",
"low_vegetation_cover", "high_vegetation_cover",
"10m_wind_speed", "volumetric_soil_water_layer_1",
"total_cloud_cover"]
print(df.head(500))

df.to_csv(r'climateData.csv', header=True)

