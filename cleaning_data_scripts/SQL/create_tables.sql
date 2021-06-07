create table newClimateData (latitude float, longitude float, time date, "2m_temperature" float,
						 	total_precipitation float, low_vegetation_cover float, high_vegetation_cover float,
							"10m_wind_speed" float, volumetric_soil_water_layer_1 float, total_cloud_cover float,
							city varchar, county varchar);
							
create table newFireData (incident_name varchar, incident_dateonly_extinguished date,
						 incident_dateonly_created date, incident_acres_burned float,
						 incident_latitude float, incident_longitude float, city varchar,
						 incident_county varchar, incident_id varchar, incident_url varchar);
						 
create table newHousingData(
	county VARCHAR,
	Year int,
	Density float
);

create table newPopulationData(
	county VARCHAR,
	Year int,
	Population int,
	LandArea double precision,
	PopulationDensity float
);

--- Commands to populate tables that were created >>> (insert your file location) <<<
--\COPY newClimateData from 'file location of newClimateData.csv' delimiter ',' csv header;
--\COPY newFireData from 'file location of newFireData.csv' delimiter ',' csv header;
--\COPY newHousingData from 'file location of newHousingData.csv' delimiter ',' csv header;
--\COPY newPopulationData from 'file location of newPopulationData.csv' delimiter ',' csv header;

--- Command to push final table to csv for modeling use >>> (insert your location) <<<
--\COPY fireClimateHumanTable to 'location for fireClimateHumanTable4.csv' delimiter ',' csv header;

