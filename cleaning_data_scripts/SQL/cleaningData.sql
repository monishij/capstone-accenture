--- cleaning firedata

create view year_only_fire_view 
as select extract(year from incident_dateonly_extinguished) as year_only, 
date_trunc('month',incident_dateonly_extinguished)::date, * from newfiredata;

create table FireFreq
as (select count(*), date_trunc, city from year_only_fire_view
group by date_trunc, city);

DELETE FROM FireFreq WHERE date_trunc IS NULL; --82 rows
ALTER TABLE FireFreq ADD PRIMARY KEY(date_trunc,city);

--- cleaning climate
create view year_only_climate_view
as select extract(year from time) as year_onlyclimate, * from newclimatedata;

create table distinctClimateData as
(select time, city, max(county) as county, max(year_onlyclimate) as yearonlyclimate, avg("2m_temperature") as "2m_temperature", 
avg(total_precipitation) as total_precipitation, avg(low_vegetation_cover) as low_vegetation_cover, 
avg(high_vegetation_cover) as high_vegetation_cover, avg("10m_wind_speed") as "10m_wind_speed", 
avg("volumetric_soil_water_layer_1") as "volumetric_soil_water_layer_1", avg(total_cloud_cover) as total_cloud_cover
from year_only_climate_view
group by time, city);

--- joining climate and fire data

CREATE VIEW climateAndFireView as 
select c.time, c.city, c.county, c.yearonlyclimate as Year, coalesce(f.count, 0) as frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover
from distinctClimateData c
left join FireFreq f on c.time = f.date_trunc and c.city = f.city
order by c.time;

--- City population
UPDATE cityPopulationCleaned
SET city= replace(city, ' city', '');

-- joining housing density data with climate+fire data
CREATE VIEW housingClimateFireView as
select c.time, c.city, c.county, c.year, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, hp.density
from climateAndFireView c
right join housingDensityCountyCleaned hp on c.year = hp.year and c.county = hp.county
WHERE c.year != 2020
order by c.time;

-- joining population data with climate+fire+housing data
-- STILL NEEDS WORK
select c.time, c.city, c.county, c.year, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, cp.population
from housingClimateFireView c
right join cityPopulationCleaned cp on c.year = cp.year and c.city = cp.city
order by c.time

---moving to csv
CREATE table housingClimateFireTable as
select c.time, c.city, c.county, c.year, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, hp.density
from climateAndFireView c
right join housingDensityCountyCleaned hp on c.year = hp.year and c.county = hp.county
WHERE c.year != 2020
order by c.time;

create table densityHousingClimateFireTable as
select c.time, c.city, c.county, c.year, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, cp.population
from housingClimateFireView c
right join cityPopulationCleaned cp on c.year = cp.year and c.city = cp.city
order by c.time