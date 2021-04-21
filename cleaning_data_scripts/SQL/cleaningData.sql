--- cleaning firedata

create view year_only_fire_view 
as select extract(year from incident_dateonly_created) as year_only, 
date_trunc('month',incident_dateonly_created)::date, * from newfiredata;

create table FireFreq
as (select count(*), date_trunc, incident_county from year_only_fire_view
group by date_trunc, incident_county);

DELETE FROM FireFreq WHERE incident_county IS NULL; --12 rows
--ALTER TABLE FireFreq ADD PRIMARY KEY(date_trunc,incident_county);

--- cleaning climate
UPDATE newclimatedata
SET county= replace(county, ' County', '');

create view year_only_climate_view
as select extract(year from time) as year_onlyclimate, * from newclimatedata;

create table distinctClimateData as
(select time, max(latitude) as latitude, min(longitude) as longitude, county, max(year_onlyclimate) as yearonlyclimate, avg("2m_temperature") as "2m_temperature", 
avg(total_precipitation) as total_precipitation, avg(low_vegetation_cover) as low_vegetation_cover, 
avg(high_vegetation_cover) as high_vegetation_cover, avg("10m_wind_speed") as "10m_wind_speed", 
avg("volumetric_soil_water_layer_1") as "volumetric_soil_water_layer_1", avg(total_cloud_cover) as total_cloud_cover
from year_only_climate_view
group by time, county);

--- joining climate and fire data

CREATE VIEW climateAndFireView as 
select c.time, c.latitude, c.longitude, c.county, c.yearonlyclimate as Year, coalesce(f.count, 0) as count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover
from distinctClimateData c
left join FireFreq f on c.time = f.date_trunc and c.county = f.incident_county
order by c.time;

-- joining housing density data with climate+fire data

UPDATE housingDensityCountyCleaned
SET county= replace(county, ' County', '');

CREATE VIEW housingClimateFireView as
select c.time, c.latitude, c.longitude, c.county, c.year, c.count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, hp.density as housingDensity
from climateAndFireView c
right join housingDensityCountyCleaned hp on c.year = hp.year and c.county = hp.county
WHERE c.year != 2020
order by c.time;

-- joining population data with climate+fire+housing data
-- STILL NEEDS WORK

UPDATE countyPopulationCleaned
SET county= replace(county, ' County', '');

CREATE TABLE fireClimateHumanTable as
select c.time, c.latitude, c.longitude, c.county, c.year, c.count, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, c.housingDensity, cp.population
from housingClimateFireView c
left join countyPopulationCleaned cp on c.year = cp.year and c.county = cp.county
order by c.time



SELECT * FROM fireClimateHumanTable
