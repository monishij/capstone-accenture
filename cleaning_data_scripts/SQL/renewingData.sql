CREATE VIEW climateAndFireView3 as 
select c.time, c.latitude, c.longitude, c.county, c.yearonlyclimate as Year, coalesce(f.count, 0) as count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover
from distinctClimateData3 c
left join FireFreq f on c.time = f.date_trunc and c.county = f.incident_county
order by c.time;


CREATE VIEW housingClimateFireView3 as
select c.time, c.latitude, c.longitude, c.county, c.year, c.count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, hp.density as housingDensity
from climateAndFireView3 c
right join housingDensityCountyCleaned hp on c.year = hp.year and c.county = hp.county
WHERE c.year != 2020
order by c.time;


CREATE TABLE fireClimateHumanTable3 as
select c.time, c.latitude, c.longitude, c.county, c.year, c.count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, c.housingDensity, cp.population
from housingClimateFireView3 c
left join countyPopulationCleaned cp on c.year = cp.year and c.county = cp.county
order by c.time;



SELECT * FROM fireClimateHumanTable3;
