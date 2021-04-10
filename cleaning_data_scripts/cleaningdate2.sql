-- firedata
select incident_dateonly_extinguished from newfiredata;
select extract(year from incident_dateonly_extinguished) as year_only from newfiredata;
select date_trunc('month',incident_dateonly_extinguished)::date from newfiredata;

create view year_only_table 
as select extract(year from incident_dateonly_extinguished) as year_only, 
date_trunc('month',incident_dateonly_extinguished)::date, * from newfiredata;

create table cleanedFireData 
as (select * from year_only_table);

--------------
-- climatedata
select * from newclimatedata;
select extract(year from time) as year_onlyclimate from newclimatedata;

create view year_only_table_climate 
as select extract(year from time) as year_onlyclimate, * from newclimatedata;
select * from year_only_table_climate; 

create table cleanedClimateData
as (select * from year_only_table_climate);
select * from cleanedClimateData;

----------
create table cleanedFireFreq
as (select count(*), date_trunc, city from cleanedFireData
group by date_trunc, city);

---------- creating final table
DELETE FROM cleanedFireFreq WHERE date_trunc IS NULL; --82 rows
ALTER TABLE cleanedFireFreq ADD PRIMARY KEY(date_trunc,city);
alter table distinctClimateData add primary key(time,city);

create table distinctClimateData as
(select time, city, max(county) as county, max(year_onlyclimate) as yearonlyclimate, avg("2m_temperature") as "2m_temperature", 
avg(total_precipitation) as total_precipitation, avg(low_vegetation_cover) as low_vegetation_cover, 
avg(high_vegetation_cover) as high_vegetation_cover, avg("10m_wind_speed") as "10m_wind_speed", 
avg("volumetric_soil_water_layer_1") as "volumetric_soil_water_layer_1", avg(total_cloud_cover) as total_cloud_cover
from cleanedClimateData
group by time, city);
-----
select c.time, c.city, coalesce(f.count, 0) as frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover
from distinctClimateData c
left join cleanedFireFreq f on c.time = f.date_trunc and c.city = f.city
order by c.time

----
CREATE TABLE housingPopulationCountyCleaned(
	county VARCHAR,
	Year int,
	Density float
);

CREATE TABLE cityPopulationCleaned(
	city VARCHAR,
	Year int,
	Population float
);
UPDATE cityPopulationCleaned
SET city= replace(city, ' city', '') as city;

UPDATE housingPopulationCountyCleaned
SET county= replace(county, ' County', '');

SELECT * FROM housingPopulationCountyCleaned


SELECT * FROM cityPopulationCleaned
WHERE city = 'Acton';

SELECT * FROM climateFireFreq

select c.time, c.city, c.county, c.yearonlyclimate, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, hp.density
from climateFireFreq c
left join housingPopulationCountyCleaned hp on c.yearonlyclimate = hp.year and c.county = hp.county
order by c.yearonlyclimate

CREATE VIEW temp as
select c.time, c.city, c.county, c.yearonlyclimate, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, cp.population
from climateFireFreq c
right join cityPopulationCleaned cp on c.yearonlyclimate = cp.year and c.city = cp.city
order by c.yearonlyclimate

select c.time, c.city, c.county, c.yearonlyclimate, c.frequency, c."2m_temperature", 
c.total_precipitation, c.low_vegetation_cover, c.high_vegetation_cover, c."10m_wind_speed",
c."volumetric_soil_water_layer_1", c.total_cloud_cover, c.population populationDensity, hp.density as housingDensitybyCounty
from temp c
right join housingPopulationCountyCleaned hp on c.yearonlyclimate = hp.year and c.county = hp.county
order by c.frequency



\COPY housingPopulationCountyCleaned from '/Users/saadiakarim 1/Documents/Stats 170a/Final Project Spring/capstone-accenture/clean_data/housingPopulationCountyCleaned.csv' delimiter ',' csv header;
\COPY cityPopulationCleaned from '/Users/saadiakarim 1/Documents/Stats 170a/Final Project Spring/capstone-accenture/clean_data/cityPopulationCleaned.csv' delimiter ',' csv header;



