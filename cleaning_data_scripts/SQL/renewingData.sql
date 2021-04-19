-- renewing tables with latitude and latitude 
create table distinctClimateData2 as
(select max(latitude) as latitude, max(longitude) as longitude, time, city, max(county) as county, max(year_onlyclimate) as yearonlyclimate, avg("2m_temperature") as "2m_temperature", 
avg(total_precipitation) as total_precipitation, avg(low_vegetation_cover) as low_vegetation_cover, 
avg(high_vegetation_cover) as high_vegetation_cover, avg("10m_wind_speed") as "10m_wind_speed", 
avg("volumetric_soil_water_layer_1") as "volumetric_soil_water_layer_1", avg(total_cloud_cover) as total_cloud_cover
from year_only_climate_view
group by time, city);

---climate and fire only with latitude and longitude
CREATE table climateAndFireTable as 
select c.latitude, c.longitude, c.time, c.city, c.county, c.yearonlyclimate as Year, coalesce(f.count, 0) as frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover
from distinctClimateData2 c
left join FireFreq f on c.time = f.date_trunc and c.city = f.city
order by c.time;