-- CMPINF 2110 Spring 2021 Homework 03 Solutions --

-- this MySQL script provides the solutions to the SQL related 
-- portion of homework 03 for both applications

-- the databases are created, the tables defined, and the queries
-- are executed

-- the data import wizard is used to insert data into each table

-- Dr. Joseph P. Yurko

-- TB database --

CREATE DATABASE tb_db;

USE tb_db;

-- create the age_info table --
CREATE TABLE age_info (
age_id int NOT NULL AUTO_INCREMENT,
age_group text NOT NULL,
original_tb_word text NOT NULL,
PRIMARY KEY (age_id)
);

-- insert the age_info table data via the data import wizard --

-- create the year_info table --
CREATE TABLE year_info (
year_id int NOT NULL AUTO_INCREMENT,
year int NOT NULL,
PRIMARY KEY (year_id)
);

-- insert the year_info table data via the data import wizard --

-- create the gender_info table --
CREATE TABLE gender_info (
gender_id int NOT NULL AUTO_INCREMENT,
sex text NOT NULL,
gender_name text NOT NULL,
PRIMARY KEY (gender_id)
);

-- insert the gender_info table data via the data import wizard --

-- create the country info table --
CREATE TABLE country_info (
country_id int NOT NULL AUTO_INCREMENT,
country text NOT NULL,
PRIMARY KEY (country_id)
);

-- insert the country_info table data via the data import wizard --

-- create the cases_in_country table --
CREATE TABLE cases_in_country (
id int NOT NULL AUTO_INCREMENT,
country_id int NOT NULL,
year_id int NOT NULL,
gender_id int NOT NULL,
age_id int NOT NULL,
cases int,
PRIMARY KEY (id),
FOREIGN KEY (country_id) REFERENCES country_info(country_id),
FOREIGN KEY (year_id) REFERENCES year_info(year_id),
FOREIGN KEY (gender_id) REFERENCES gender_info(gender_id),
FOREIGN KEY (age_id) REFERENCES age_info(age_id)
);

-- insert the cases_in_country table data via the data import wizard --

-- all tables are now created and populated with data !! --

-- required queries in the assignment for tb_db --

-- JOIN all tables together to recreate the tidy long-format data set

SELECT *
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id);

-- select just a few columns that way we do not include the IDs
-- use alias to make the column names look the way we want
SELECT country, year, sex, age_group AS age, cases
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id);

-- query all columns for all age gruops and genders in the country AO
-- we need to use a WHERE clause
SELECT country, year, sex, age_group AS age, cases
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id)
WHERE country = 'AO';

-- query all columns for all age groups and genders for country 
-- AO or AR
-- we will use a WHERE clause with the IN operator
SELECT country, year, sex, age_group AS age, cases
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id)
WHERE country IN ('AO', 'AR');

-- query all columns for females in all age groups for country AF
-- use a WHERE clause and the AND operator
SELECT country, year, sex, age_group AS age, cases
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id)
WHERE sex = 'f' AND country = 'AF';

-- we can catch our query is correct by examining the DISTINCT values
-- of the country and sex
SELECT DISTINCT(country)
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id)
WHERE sex = 'f' AND country = 'AF';

SELECT DISTINCT(sex)
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id)
WHERE sex = 'f' AND country = 'AF';

-- note that if we wanted to we could have also created a VIEW or 
-- virtual table for the tidy long-format data set
-- this way we would not have had to keep using the same left joins
-- over and over again.
--
-- VIEWS are useful when we need to perform the same query again and again
-- although not required for the assignment here is how to create a view for the
-- tidy long-format table
CREATE VIEW tidy_tb_table AS
SELECT country, year, sex, age_group AS age, cases
FROM cases_in_country
LEFT JOIN age_info USING (age_id)
LEFT JOIN country_info USING (country_id)
LEFT JOIN gender_info USING (gender_id)
LEFT JOIN year_info USING (year_id);

-- the virtual table (VIEW) can be queired to answer the previous questions
-- for example the check on the distinct countries in the query with
-- sex = 'f' and country = 'AF'
SELECT DISTINCT(country) 
FROM tidy_tb_table 
WHERE sex = 'f' AND country = 'AF';

-- STOCKS database --

-- create the data base, create each table in the data base,
-- then populate each table in the data base

CREATE DATABASE stocks_db;

USE stocks_db;

-- create exchange info table

CREATE TABLE exchange_info (
exchange_id int NOT NULL AUTO_INCREMENT,
exchange text NOT NULL,
PRIMARY KEY (exchange_id)
);

-- insert the exchange_info table data via the data import wizard --

-- create the sector_info table 

CREATE TABLE sector_info (
sector_id int NOT NULL AUTO_INCREMENT,
sector text NOT NULL,
PRIMARY KEY (sector_id)
);

-- insert the sector_info table data via the data import wizard --

-- create the company_info table

CREATE TABLE company_info (
company_id int NOT NULL AUTO_INCREMENT,
symbol text NOT NULL,
company text NOT NULL,
PRIMARY KEY (company_id)
);

-- insert the company_info table data via the data import wizard --

-- create the company_sector_exchange link table --

CREATE TABLE company_sector_exchange (
link_id int NOT NULL AUTO_INCREMENT,
company_id int NOT NULL,
sector_id int NOT NULL,
exchange_id int NOT NULL,
PRIMARY KEY (link_id),
FOREIGN KEY (company_id) REFERENCES company_info(company_id),
FOREIGN KEY (sector_id) REFERENCES sector_info(sector_id),
FOREIGN KEY (exchange_id) REFERENCES exchange_info(exchange_id)
);

-- insert the company_sector_exchange table data via the data import wizard --

-- create the price_type_info table

CREATE TABLE price_type_info (
price_type_id int NOT NULL AUTO_INCREMENT,
price_at text NOT NULL,
PRIMARY KEY (price_type_id)
);

-- create the stock_value_per_day table --

CREATE TABLE stock_value_per_day (
id int NOT NULL AUTO_INCREMENT,
company_id INT NOT NULL,
price_type_id INT NOT NULL,
date_dt DATE NOT NULL,
value DOUBLE,
PRIMARY KEY (id),
FOREIGN KEY (company_id) REFERENCES company_info(company_id),
FOREIGN KEY (price_type_id) REFERENCES price_type_info(price_type_id)
);

-- insert the stock_value_per_day table data via the data import wizard --

-- required queries for the stocks data --

-- query the close price for tesla for all trading days
-- use a regular expression to find tesla by finding all company names
-- that start with Tesla
-- there are multiple ways to identify Tesla, this is just one way
-- include the AND operator to find the closing price

SELECT * 
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
WHERE company REGEXP '^Tesla' AND price_at = 'close';

-- select just a few of the columns
SELECT date_dt AS date, symbol, company, price_at, value
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
WHERE company REGEXP '^Tesla' AND price_at = 'close';

-- another approach is to use the LIKE operator to find all
-- rows with symbol starting with T, though this works just for
-- our specific application
SELECT date_dt AS date, symbol, company, price_at, value
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
WHERE symbol LIKE 'T%' AND price_at = 'close';

-- we can confirm we are querying just Tesla with the DISTINCT function
SELECT DISTINCT(company)
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
WHERE symbol LIKE 'T%' AND price_at = 'close';

-- query the low and high prices for Gamestop for all trading days
-- again we need to use a WHERE clause to identify the company and
-- the type of price
-- the IN operator is used to select low OR high prices
-- and the regular expression is used to identify the company

SELECT date_dt AS date, symbol, company, price_at, value
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
WHERE company REGEXP '^GameStop' AND price_at IN ('low', 'high');

-- again we can check the type of prices are correct with DISTINCT()
SELECT DISTINCT(price_at)
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
WHERE company REGEXP '^GameStop' AND price_at IN ('low', 'high');

-- query the maximum close price for all companies --
-- for this we need to apply the MAX() function in the SELECT clause
-- and GROUP BY company and price_at, however to identify the close price
-- we must use the HAVING clause instead of the WHERE clause
--
-- we MUST group by both company and price_at because we want to identify
-- the maximum value of a specific type of price
SELECT company, price_at, value
FROM stock_value_per_day
LEFT JOIN company_info USING (company_id)
LEFT JOIN price_type_info USING (price_type_id)
GROUP BY company, price_at
HAVING price_at = 'close';

-- query the average closing price for all companies in each month --
-- this question requies applying the YEAR() and MONTH() functions to the
-- date_dt column

-- the functions work by passing in the DATETIME column as an argument
-- for example to extract the YEAR and MONTH from date_dt
SELECT date_dt, YEAR(date_dt), MONTH(date_dt) FROM stock_value_per_day;

-- let's use a subquery to first query the datetime attributes
-- and then groupby company and year and month
SELECT company, the_year, the_month, price_at, AVG(value)
FROM ( 
	SELECT company,
		   date_dt, 
		   YEAR(date_dt) AS the_year, 
           MONTH(date_dt) AS the_month, 
           price_at, 
           value
    FROM stock_value_per_day
    LEFT JOIN price_type_info USING (price_type_id)
    LEFT JOIN company_info USING (company_id)
) AS my_table
GROUP BY company, the_year, the_month, price_at
HAVING price_at = 'close';

-- there are several ways to structure the above query
-- for example the closing price WHERE clause could be included
-- in the subquery, if you did that then you DO NOT need the 
-- HAVING clause after the GROUP BY
SELECT company, the_year, the_month, price_at, AVG(value)
FROM ( 
	SELECT company,
		   date_dt, 
		   YEAR(date_dt) AS the_year, 
           MONTH(date_dt) AS the_month, 
           price_at, 
           value
    FROM stock_value_per_day
    LEFT JOIN price_type_info USING (price_type_id)
    LEFT JOIN company_info USING (company_id)
    WHERE price_at = 'close'
) AS my_table
GROUP BY company, the_year, the_month, price_at;

-- also if you would use the WHERE clause in the subquery
-- then you could leave out the price_at variable from the GROUP BY
-- operation, the downside of this is we lose which specific price
-- we are working with, as shown below
SELECT company, the_year, the_month, AVG(value)
FROM ( 
	SELECT company,
		   date_dt, 
		   YEAR(date_dt) AS the_year, 
           MONTH(date_dt) AS the_month, 
           price_at, 
           value
    FROM stock_value_per_day
    LEFT JOIN price_type_info USING (price_type_id)
    LEFT JOIN company_info USING (company_id)
    WHERE price_at = 'close'
) AS my_table
GROUP BY company, the_year, the_month;

-- It is safer and easier to read if we keep the price_at column
-- to be returnable