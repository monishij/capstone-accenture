create table newClimateData (latitude float, longitude float, time date, "2m_temperature" float,
						 	total_precipitation float, low_vegetation_cover float, high_vegetation_cover float,
							"10m_wind_speed" float, volumetric_soil_water_layer_1 float, total_cloud_cover float,
							city varchar, county varchar);
							
create table newFireData (incident_name varchar, incident_dateonly_extinguished date,
						 incident_dateonly_created date, incident_acres_burned float,
						 incident_latitude float, incident_longitude float, city varchar,
						 incident_county varchar, incident_id varchar, incident_url varchar);
						 
create table populationEstimateCity (city varchar, "2013" float, "2014" float, "2015" float, "2016" float, "2017" float, "2018" float, "2019" float);

create table housingPopulationCounty (city varchar, "2013" float, "2014" float, "2015" float, "2016" float, "2017" float, "2018" float, "2019" float);


COPY newClimateData from '/tmp/newClimateData.csv' delimiter ',' csv header;
COPY populationEstimateCity from '/tmp/cityPopulationData.csv' delimiter ',' csv header;

COPY newFireData from '/tmp/newFireData.csv' delimiter "," csv header;
COPY housingPopulationCounty '/tmp/"countyHousingDensity".csv' delimiter "," csv header;