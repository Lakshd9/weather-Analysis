create database Indian_Weather_Repository;
use Indian_Weather_Repository;
# import file from Table Data Import Wizard

select * from iwr;

# Basic Queries

-- Display all columns from the table.
SELECT * FROM iwr;

-- Retrieve only the country, location_name, and temperature_celsius columns.
SELECT country, location_name, temperature_celsius FROM iwr;

-- Show the distinct regions available in the dataset.
SELECT DISTINCT region FROM iwr;

-- Filter rows for locations with temperatures above 30°C.
SELECT * FROM iwr WHERE temperature_celsius > 30 limit 10;

-- Find data for locations where wind speed exceeds 50 kph.
SELECT location_name, wind_kph FROM iwr WHERE wind_kph > 30 ;


# Aggregation and Grouping

-- Calculate the average temperature (°C) for each country.
SELECT country, AVG(temperature_celsius) AS avg_temperature
FROM iwr
GROUP BY country;

-- Find the total precipitation (precip_mm) for each region.
SELECT region, SUM(precip_mm) AS total_precipitation
FROM iwr
GROUP BY region;

-- Count the number of locations for each region.
SELECT region, COUNT(location_name) AS location_count
FROM iwr
GROUP BY region;

-- Identify the maximum wind speed (wind_kph) recorded in each region.
SELECT region, MAX(wind_kph) AS max_wind_speed
FROM iwr
GROUP BY region;

-- Find regions where the average humidity exceeds 70.
SELECT region, AVG(humidity) AS avg_humidity
FROM iwr
GROUP BY region
HAVING AVG(humidity) > 70;


# Sorting and Limiting Results

-- List the top 5 locations with the highest UV index.
SELECT location_name, uv_index
FROM iwr
ORDER BY uv_index DESC
LIMIT 5;

-- Retrieve the 10 coldest locations based on temperature_celsius.
SELECT location_name, temperature_celsius
FROM iwr
ORDER BY temperature_celsius ASC
LIMIT 10;


# Date and Time Functions

-- Find locations where the last update was made in December.
SELECT * FROM iwr
WHERE MONTH(last_updated) = 12;

-- Extract only the date part from the last_updated column.
SELECT location_name, DATE(last_updated) AS last_update_date
FROM iwr;


# Subqueries

-- Find the location with the highest wind speed.
SELECT location_name, wind_kph
FROM iwr
WHERE wind_kph = (SELECT MAX(wind_kph) FROM iwr);

-- List locations with temperatures above the average temperature of all locations.
SELECT location_name, temperature_celsius
FROM iwr
WHERE temperature_celsius > (SELECT AVG(temperature_celsius) FROM iwr);


# Filtering with Multiple Conditions

-- Find locations with high humidity (>80%) and low visibility (<10 km).
SELECT location_name, humidity, visibility_km
FROM iwr
WHERE humidity > 80 AND visibility_km < 10;

-- Filter data for locations where the condition includes "Rain".
SELECT * FROM iwr
WHERE condition_text LIKE '%Rain%';

-- Filter data where sunrise time is earlier than 6:00 AM.
SELECT * FROM iwr
WHERE TIME(sunrise) < '06:00:00';


# Case 
-- Create a column categorizing wind speeds as 'Low', 'Moderate', or 'High'.
SELECT location_name, wind_kph,
       CASE 
           WHEN wind_kph < 20 THEN 'Low'
           WHEN wind_kph BETWEEN 20 AND 50 THEN 'Moderate'
           ELSE 'High'
       END AS iwr
FROM iwr;

# Indexes and Rankings

-- Rank locations based on their UV index (highest first).
SELECT location_name, uv_index,
       RANK() OVER (ORDER BY uv_index DESC) AS rank_uv
FROM iwr;

-- Rank regions by their total precipitation.
SELECT region, SUM(precip_mm) AS total_precipitation,
       RANK() OVER (ORDER BY SUM(precip_mm) DESC) AS rank_precip
FROM iwr
GROUP BY region;


# Create a View for High Wind Speed Locations
-- Create a view named high_wind_locations that includes columns country, location_name, wind_kph, and wind_direction for all locations where wind_kph is greater than 50.
CREATE VIEW high_wind_locations AS
SELECT country, location_name, wind_kph, wind_direction
FROM iwr
WHERE wind_kph > 30;

SELECT * FROM high_wind_locations;



SELECT * FROM iwr;

























