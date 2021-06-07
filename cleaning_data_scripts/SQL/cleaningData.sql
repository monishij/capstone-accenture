--- Cleaning newFireData Table
create view year_only_fire_view 
as select extract(year from incident_dateonly_created) as year_only, 
date_trunc('month',incident_dateonly_created)::date, * from newfiredata;

create table FireCount
as (select count(*), date_trunc, incident_county from year_only_fire_view
group by date_trunc, incident_county);

DELETE FROM FireCount WHERE incident_county IS NULL; --12 rows
--- End| Use FireCount Table


--- Cleaning newClimateData Table
update newclimatedata
set county= replace(county, ' County', '');

create view year_only_climate_view
as select extract(year from time) as year_onlyclimate, * from newclimatedata;

create table distinctClimateData as
(select time, max(latitude) as latitude, min(longitude) as longitude, county, 
max(year_onlyclimate) as yearonlyclimate, avg("2m_temperature") as "2m_temperature", 
avg(total_precipitation) as total_precipitation, avg(low_vegetation_cover) as low_vegetation_cover, 
avg(high_vegetation_cover) as high_vegetation_cover, avg("10m_wind_speed") as "10m_wind_speed", 
avg("volumetric_soil_water_layer_1") as "volumetric_soil_water_layer_1", avg(total_cloud_cover) as total_cloud_cover
from year_only_climate_view
group by time, county);
--- End| Use distinceClimateData Table

--- Joining climate and fire 
create view climateAndFireView as 
select c.time, c.latitude, c.longitude, c.county, c.yearonlyclimate as Year, coalesce(f.count, 0) as count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover
from distinctClimateData c
left join FireCount f on c.time = f.date_trunc and c.county = f.incident_county
order by c.time;
--- End| Use climateAndFireView

--- Joining housing and climate+fire
update newHousingData
set county= replace(county, ' County', '');

create view housingClimateFireView as
select c.time, c.latitude, c.longitude, c.county, c.year, c.count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, hp.density as housingDensity
from climateAndFireView c
right join newHousingData hp on c.year = hp.year and c.county = hp.county
WHERE c.year != 2020
order by c.time;
--- End| Use housingClimateFireView

--- Joining population and climate+fire+housing
update newPopulationData
set county= replace(county, ' County', '');

create table fireClimateHumanTable as
select c.time, c.latitude, c.longitude, c.county, c.year, c.count, 
round(cast((1.8*(c."2m_temperature" -273)+32) as numeric), 2) as "2m_temperature",  
round(cast(c.total_precipitation as numeric), 4) as total_precipitation, 
round(cast(c.low_vegetation_cover as numeric), 3) as low_vegetation_cover,
round(cast(c.high_vegetation_cover as numeric), 2) as high_vegetation_cover, 
round(cast(c."10m_wind_speed" as numeric), 2) as "10m_wind_speed",
round(cast(c."volumetric_soil_water_layer_1" as numeric), 2) as "volumetric_soil_water_layer_1",
round(cast(c.total_cloud_cover as numeric), 2) as total_cloud_cover, 
c.housingDensity, cp.population, cp.populationdensity
from housingClimateFireView c
left join newPopulationData cp on c.year = cp.year and c.county = cp.county
order by c.time, county
--- End| Use fireClimateHumanTable