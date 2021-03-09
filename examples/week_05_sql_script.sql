-- week 05 : continue working with SQL

USE shoes_db;

-- query all columns from the shoes table
SELECT * FROM shoes;

-- query all columns from the shoes_per_day table MERGED with
-- the shoes table
SELECT * 
FROM shoes_per_day
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id;

-- check the DISTINCT values for shoe_id
SELECT DISTINCT shoe_id FROM shoes;

SELECT DISTINCT shoe_id FROM shoes_per_day;

-- query all columns from the MERGED data sets between shoes_per_day
-- and shoes and locations
SELECT * 
FROM shoes_per_day
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations ON shoes_per_day.location_id = locations.location_id;

-- query the tidy data, but select the day_id, location_name, shoe_color, and the count
SELECT day_id, location_name, shoe_color, count
FROM shoes_per_day
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations ON shoes_per_day.location_id = locations.location_id;

-- use Aliases to have nicer looking variable names
SELECT day_id AS 'Day Number',
	location_name AS 'Store Name', 
    shoe_color AS 'Shoe Color', 
    count AS 'Number of shoes'
FROM shoes_per_day
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations ON shoes_per_day.location_id = locations.location_id;

-- new lines and commas
SELECT day_id AS 'Day Number'
	, location_name AS 'Store Name'
    , shoe_color AS 'Shoe Color'
	, count AS 'Number of shoes'
FROM shoes_per_day
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id
LEFT JOIN locations ON shoes_per_day.location_id = locations.location_id;

-- how many red shoes were counted per day per store?
SELECT * 
FROM shoes_per_day
WHERE shoe_id = 3;

-- query the rows associated with shoe_id = 3 and count < 7
SELECT *
FROM shoes_per_day
WHERE shoe_id = 3 AND count < 7;

-- query red shoes
SELECT *
FROM shoes_per_day
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id
WHERE shoe_color = 'Red';

-- query red shoes starting from the shoes table
-- this produced an error if the WHERE clause is uncommented
SELECT *
FROM shoes
-- WHERE shoe_color = 'Red'
RIGHT JOIN shoes_per_day ON shoes.shoe_id = shoes_per_day.shoe_id;

SELECT *
FROM shoes
RIGHT JOIN shoes_per_day ON shoes.shoe_id = shoes_per_day.shoe_id
WHERE shoe_color = 'Red';

-- if it's too tedious to type out the table names when specifying the columns
-- or the keys we can create an alias for the table
SELECT day_id, 
	location_id, 
	shoes.shoe_id, 
    count
FROM shoes_per_day 
LEFT JOIN shoes ON shoes_per_day.shoe_id = shoes.shoe_id;

-- use an alias for the table
SELECT day_id, 
	location_id, 
	s.shoe_id, 
    count
FROM shoes_per_day spd
LEFT JOIN shoes s ON spd.shoe_id = s.shoe_id;

-- get back to our tidy data using the table aliases
SELECT day_id, l.location_id, s.shoe_id,
	shoe_color, location_name,
    count
FROM shoes_per_day spd
LEFT JOIN shoes s ON spd.shoe_id = s.shoe_id
LEFT JOIN locations l ON spd.location_id = l.location_id;

-- implicit joins, to streamline syntax, I DON'T LIKE THIS
SELECT day_id, s.shoe_id, shoe_color, count
FROM shoes_per_day spd, shoes s
WHERE spd.shoe_id = s.shoe_id;

-- implicit joins works with more than 2 tables as well
SELECT day_id, s.shoe_id, l.location_id, 
	shoe_color, location_name,
	count
FROM shoes_per_day spd, shoes s, locations l 
WHERE spd.shoe_id = s.shoe_id AND spd.location_id = l.location_id;

-- an even more dangerous join is the NATURAL JOIN
SELECT *
FROM shoes_per_day
NATURAL JOIN shoes;

-- USING clause: only works if the KEY has the SAME name in both tables
SELECT *
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id);

SELECT *
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id);

-- find all days, locations, and shoe colors where the count is between 5 and 9
SELECT *
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE count >= 5 AND count <= 9;

-- BETWEEN Operator streamlines INCLUSIVE ranges
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE count BETWEEN 5 AND 9;

-- all rows associated with Noodles & Company
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE location_name = 'Noodles & Company';

-- last we saw a shorter way to the location
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE location = 'N';

-- find all rows where location_name is LIKE starting with N
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE location_name LIKE 'N%';

-- but instead I could find all rows LIKE ending with y
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE location_name LIKE '%y';

-- or contains e anywhere in the name
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE location_name LIKE '%e%';

-- underscore considers a SPECIFIC number of characters
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE shoe_color LIKE '_l___';

SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE shoe_color LIKE '_t___';

-- REGULAR EXPRESSIONS 
-- find all rows where shoe_color starts with the letter b 
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE shoe_color REGEXP '^b';

-- end a character string it's with $
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE shoe_color REGEXP 'e$';

-- two condtions as OR, for example shoe_color ends with e or k
SELECT * 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
WHERE shoe_color REGEXP 'e$|k$';

-- SORT the rows of our JOINED table based on the number of shoes
SELECT day_id, location_name, shoe_color, count
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
ORDER BY count;

-- for DECREASING order
SELECT day_id, location_name, shoe_color, count 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
ORDER BY count DESC;

SELECT day_id, location_name, shoe_color, count 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
ORDER BY day_id, count DESC;

-- the top 5 highest counts
SELECT day_id, location_name, shoe_color, count 
FROM shoes_per_day spd
LEFT JOIN shoes s USING (shoe_id)
LEFT JOIN locations l USING (location_id)
ORDER BY count DESC
LIMIT 5;

-- what's the highest count?
SELECT MAX(count) FROM shoes_per_day;

-- max, min, average
SELECT MAX(count), MIN(count), AVG(count) FROM shoes_per_day;

-- calculate the SUM and the number of rows
SELECT 
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day;

-- what if I wanted to know the summary counts for shoe_id = 2?
SELECT shoe_id,
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day
WHERE shoe_id = 2;

-- to check
SELECT shoe_id, count FROM shoes_per_day WHERE shoe_id = 2;

-- combine aggregation functions with groupings
SELECT shoe_id,
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day
GROUP BY shoe_id;

-- what if we wanted the summary stats for the combination of 
-- location and shoe ID?
SELECT shoe_id, location_id,
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day
GROUP BY shoe_id, location_id;

-- if I want the shoe color and the location name, we need to JOIN
-- AFTER the grouping
SELECT shoe_id, location_id, shoe_color, location_name,
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day
LEFT JOIN shoes USING (shoe_id)
LEFT JOIN locations USING (location_id)
GROUP BY shoe_id, location_id;

-- order by the IDs
SELECT shoe_id, location_id, shoe_color, location_name,
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day
LEFT JOIN shoes USING (shoe_id)
LEFT JOIN locations USING (location_id)
GROUP BY shoe_id, location_id
ORDER BY location_id, shoe_id;

-- WHERE to filter or subset rows by conditions
-- we CANNOT use WHERE to filter GROUPED data sets!!!!!!
-- HAVING clause for subsetting rows of GROUPED data
SELECT shoe_id, location_id, shoe_color, location_name,
	MAX(count) AS highest
    , MIN(count) AS lowest
    , AVG(count) AS average
    , SUM(count) AS total
    , COUNT(id) AS num_rows
FROM shoes_per_day
LEFT JOIN shoes USING (shoe_id)
LEFT JOIN locations USING (location_id)
GROUP BY shoe_id, location_id
HAVING average > 8
ORDER BY location_id, shoe_id;

-- what if we are interested in the total number of SUMMED count of shoes
SELECT shoe_id, SUM(count) as total
FROM shoes_per_day
GROUP BY shoe_id;

-- the ROLLUP function 
SELECT shoe_id, SUM(count) as total
FROM shoes_per_day
GROUP BY shoe_id WITH ROLLUP;

-- ROLLUP sums across all groups
SELECT SUM(count) FROM shoes_per_day;

-- grouping by multiple variables the ROLLUP lets us see breakdowns per group
SELECT shoe_id, location_id, SUM(count) as total
FROM shoes_per_day
GROUP BY shoe_id, location_id WITH ROLLUP;

-- change the variable ROLLUP is applied to
SELECT shoe_id, location_id, SUM(count) as total
FROM shoes_per_day
GROUP BY location_id, shoe_id WITH ROLLUP;

-- double check
SELECT location_id, SUM(count) AS TOTAL
FROM shoes_per_day
GROUP BY location_id
ORDER BY location_id;

-- SUBQUERIES

-- find all rows where count is greater than the average count

-- first consider how we query the average value for count
SELECT AVG(count) FROM shoes_per_day;

SELECT *
FROM shoes_per_day
WHERE count > (SELECT AVG(count) FROM shoes_per_day);

-- check with the manual value
SELECT *
FROM shoes_per_day
WHERE count > 8;

-- subqueries can perform filter or subsetting actions
-- find all rows in shoes_per_day with count greater than the 
-- average countf for shoe_id = 2
SELECT AVG(count) FROM shoes_per_day WHERE shoe_id = 2;

SELECT *
FROM shoes_per_day
WHERE count > (SELECT AVG(count) FROM shoes_per_day WHERE shoe_id =2);

-- as a check
SELECT *
FROM shoes_per_day
WHERE count > 12.3;

-- what's the average number of shoes per day in a location?

-- we must first SUM all shoes in a location on a day.

SELECT day_id, location_id, SUM(count) AS sum_count
FROM shoes_per_day
GROUP BY day_id, location_id;

-- query from the store_day grouped table the average of the sum_count
-- require a SUBQUERY in a FROM statement and so we must give the table
-- an ALIAS

SELECT location_id, AVG(sum_count) AS avg_count, COUNT(day_id) AS num_days
FROM (
	SELECT day_id, location_id, SUM(count) AS sum_count
	FROM shoes_per_day
	GROUP BY day_id, location_id
) AS store_per_day
GROUP BY location_id;

-- ACCESS or QUERY a virtual table just as I would a regular, real, or BASE table
-- can do that by CREATING VIEWS

CREATE VIEW store_per_day_view AS
SELECT day_id, location_id, SUM(count) AS sum_count
FROM shoes_per_day
GROUP BY day_id, location_id;

SELECT * FROM store_per_day_view;

SELECT MAX(sum_count) FROM store_per_day_view;

SELECT SUM(sum_count) as total_count FROM store_per_day_view GROUP BY location_id;

-- summarize each location and store that query as a VIEW
CREATE VIEW location_summary_view AS
SELECT location_id, AVG(sum_count) AS avg_count, COUNT(day_id) AS num_days
FROM store_per_day
GROUP BY location_id
ORDER BY location_id;

-- which days for each store have sum_counts greater than the store average?
SELECT day_id, location_id, sum_count, avg_count
FROM store_per_day_view
LEFT JOIN location_summary_view USING (location_id);

-- filter the rows based on sum_count > avg_count
SELECT day_id, location_id, sum_count, avg_count
FROM store_per_day_view
LEFT JOIN location_summary_view USING (location_id)
WHERE (sum_count - avg_count) > 0;

-- YEAR(), MONTH()




