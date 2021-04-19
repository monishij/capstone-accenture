create table newClimateData (latitude float, longitude float, time date, "2m_temperature" float,
						 	total_precipitation float, low_vegetation_cover float, high_vegetation_cover float,
							"10m_wind_speed" float, volumetric_soil_water_layer_1 float, total_cloud_cover float,
							city varchar, county varchar);
							
create table newFireData (incident_name varchar, incident_dateonly_extinguished date,
						 incident_dateonly_created date, incident_acres_burned float,
						 incident_latitude float, incident_longitude float, city varchar,
						 incident_county varchar, incident_id varchar, incident_url varchar);
						 
CREATE TABLE housingDensityCountyCleaned(
	county VARCHAR,
	Year int,
	Density float
);

CREATE TABLE cityPopulationCleaned(
	city VARCHAR,
	Year int,
	Population float
);

--\COPY newClimateData from '/Users/saadiakarim 1/Documents/Stats 170a/Final Project Spring/capstone-accenture/clean_data/newClimateData.csv' delimiter ',' csv header;
--\COPY newFireData from '/Users/saadiakarim 1/Documents/Stats 170a/Final Project Spring/capstone-accenture/clean_data/newFireData.csv' delimiter ',' csv header;

--\COPY housingDensityCountyCleaned from '/Users/saadiakarim 1/Documents/Stats 170a/Final Project Spring/capstone-accenture/clean_data/housingPopulationCountyCleaned.csv' delimiter ',' csv header;
--\COPY cityPopulationCleaned from '/Users/saadiakarim 1/Documents/Stats 170a/Final Project Spring/capstone-accenture/clean_data/cityPopulationCleaned.csv' delimiter ',' csv header;

