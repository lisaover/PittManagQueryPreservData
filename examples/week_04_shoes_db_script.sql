-- create a data base for our shoes example
CREATE DATABASE shoes_db;

USE shoes_db;

-- create the locations table with the data import wizard
-- the following assumes that we have created the locations table

-- select just the location_id PRIMARY KEY and the location symbol
SELECT location_id, location FROM locations; 

-- what if I wanted the infomration associated with dunkin donuts?
SELECT * FROM locations WHERE location = 'D';

SELECT location_id, location, location_name FROM locations WHERE location = 'D';

-- find the rows associated with Dunkin Donuts OR Panera Bread
SELECT location_id, location, location_name
FROM locations
WHERE location = 'D' OR location = 'P';

-- use the IN operator to simplify the OR condition
SELECT location_id, location, location_name
FROM locations
WHERE location IN ('D', 'P');

-- if we want rows associated with everything EXCEPT dunkin or panera
SELECT location_id, location, location_name
FROM locations
WHERE location NOT IN ('D', 'P');

-- create a table for the information about the shoes
CREATE TABLE shoe_info_table (
shoe_id int NOT NULL,
shoe text NOT NULL,
shoe_color text NOT NULL,
PRIMARY KEY (shoe_id)
);

-- populate or fill a table we must INSERT the rows or RECORDS
-- INSERT INTO fills in a SINGLE ROW or SINGLE RECORD
INSERT INTO shoe_info_table VALUES (1, 'B', 'Black');

-- explicitly state which columns we are INSERTING VALUES into
INSERT INTO shoe_info_table (shoe_id, shoe, shoe_color) 
VALUES (2, 'O', 'Other');

-- INSERT multiple rows at a time
INSERT INTO shoe_info_table (shoe_id, shoe, shoe_color)
VALUES (3, 'R', 'Red'), (4, 'W', 'White');

-- tell SQL to AUTO INCREMENT integers, so let's create a second shoes table

CREATE TABLE shoes (
shoe_id int NOT NULL AUTO_INCREMENT,
shoe text,
shoe_color text NOT NULL,
PRIMARY KEY (shoe_id)
);

-- insert a row into the shoes table
INSERT INTO shoes (shoe_id, shoe, shoe_color) VALUES (DEFAULT, 'B', 'Black');

-- insert a row where we do NOT set the unique ID
INSERT INTO shoes (shoe, shoe_color) VALUES ('O', 'Other');

-- and by definition shoe can be NULL or MISSING
INSERT INTO shoes (shoe, shoe_color) VALUES (NULL, 'Red');

INSERT INTO shoes (shoe_color) VALUES ('White');

-- UPDATE the shoes table so we set the correct shoe labels
UPDATE shoes SET shoe = 'R' WHERE shoe_color = 'Red';

-- we can still update we just must perform the update
-- based on the PRIMARY KEY
UPDATE shoes SET shoe = 'R' WHERE shoe_id = 3;

UPDATE shoes SET shoe = 'W' WHERE shoe_id = 4;

-- create the shoes per day table which stores the counts
-- for each type of shoe in a store on a day
CREATE TABLE shoes_per_day (
id int NOT NULL AUTO_INCREMENT,
day_id int NOT NULL,
location_id int NOT NULL,
shoe_id int NOT NULL,
count int,
PRIMARY KEY (id),
FOREIGN KEY (location_id) REFERENCES locations(location_id),
FOREIGN KEY (shoe_id) REFERENCES shoes(shoe_id)
);

-- populate or INSERT all rows from a CSV file using the import data wizard tool

-- execute a query by JOINING the 3 tables together

-- let's first JOIN 2 tables
SELECT * 
FROM shoes_per_day
LEFT JOIN shoes on shoes_per_day.shoe_id = shoes.shoe_id;

-- JOIN ALL 3 tables together
SELECT *
FROM shoes_per_day
LEFT JOIN shoes on shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations on shoes_per_day.location_id = locations.location_id;

-- check the distinct shoe colors are the same after the join
SELECT DISTINCT shoe_color
FROM shoes_per_day
LEFT JOIN shoes on shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations on shoes_per_day.location_id = locations.location_id;

-- check shoe color and locations
SELECT DISTINCT shoe_color, location_name
FROM shoes_per_day
LEFT JOIN shoes on shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations on shoes_per_day.location_id = locations.location_id;

-- we can ALIAS column or RENAME column names with AS
SELECT DISTINCT shoe_color AS 'Shoe Color', location_name AS 'Store Name'
FROM shoes_per_day
LEFT JOIN shoes on shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations on shoes_per_day.location_id = locations.location_id;