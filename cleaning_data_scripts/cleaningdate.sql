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
select count(*), date_trunc, city from cleanedFireData
group by date_trunc, city;
