-- date time functions

-- get the current datetime
SELECT NOW();

-- query the current date
SELECT CURDATE();

SELECT CURRENT_DATE();

-- query the current time
SELECT CURTIME();

-- YEAR(), MONTH() to extract YEAR and MONTH
SELECT YEAR( NOW() );

SELECT MONTH( NOW() );

-- get the day, hour
SELECT YEAR( NOW() ), MONTH( NOW() ), DAY( NOW() ), HOUR( NOW() );

SELECT 
	YEAR( NOW() ),
    MONTH( NOW() ),
    DAY( NOW() ),
    HOUR( NOW() );

-- use ALIASES to modify the returned names of the variables
SELECT 
	YEAR( NOW() ) AS the_year,
    MONTH( NOW() ) AS the_month,
    DAY( NOW() ) AS the_day,
    HOUR( NOW() ) AS the_hour;

-- review SUBQUERIES: select or query the year, month, and day
-- of the current date time, but only call the NOW() function once

SELECT * FROM ( SELECT NOW() ) AS my_table;

SELECT * FROM ( SELECT NOW() AS my_datetime ) AS my_table;

SELECT 
	YEAR(my_datetime) AS the_year, 
    MONTH(my_datetime) AS the_month, 
    DAY(my_datetime) AS the_day
FROM (
	SELECT NOW() AS my_datetime
) AS my_table;

-- general SQL approach to extracting the year, month, or day
-- is with the EXTRACT() function

SELECT EXTRACT(YEAR FROM NOW());

SELECT EXTRACT(YEAR FROM NOW()) AS the_year;

SELECT 
	EXTRACT(YEAR FROM NOW()) AS the_year,
	EXTRACT(MONTH FROM NOW()) AS the_month,
    EXTRACT(DAY FROM NOW()) AS the_day;

-- we can work with MONTH NAMES directly using hte MONTHNAME() function
SELECT MONTHNAME(NOW());

-- the DAYNAME() function is a little confusing, because DAY() is the integer
-- for the day in the month, but DAYNAME() is the name of the day of the week
SELECT DAYNAME(NOW());

SELECT DAY(NOW()), DAYNAME(NOW()), DAYOFMONTH(NOW());

-- there are many different date and time functions in MySQL
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

SELECT MONTH(NOW()), QUARTER(NOW());

SELECT MONTHNAME(NOW());

-- what if we want just the first 3 letters in all caps for each month?

SELECT UPPER( MONTHNAME(NOW()) );

SELECT UPPER( MONTHNAME(NOW()) ), LOWER( MONTHNAME(NOW()) );

-- we can then extract a SUBSTRING where we specify the first INDEX
-- and how many characters to extract

SELECT SUBSTRING( UPPER( MONTHNAME(NOW()) ), 1, 3 );

SELECT SUBSTRING( UPPER( the_month ), 1, 3) 
FROM (
	SELECT MONTHNAME(NOW()) AS the_month
) AS my_table;

-- DATE FORMATS - many different ways of formatting a date label or string
-- YYYY-MM-DD; MM/DD/YYYY; DD MONTH YYYY; 02 Mar 2021; March 2, 2021

-- date formatting is handled by the DATE_FORMAT() function

SELECT DATE_FORMAT(NOW(), '%M %Y');

SELECT DATE_FORMAT(NOW(), '%M %y');

SELECT DATE_FORMAT(NOW(), '%M %d %Y');

SELECT DATE_FORMAT(NOW(), '%M %e %Y');

SELECT DATE_FORMAT(NOW(), '%b %e %Y');

SELECT DATE_FORMAT(NOW(), '%e %b %Y');

-- DATE ARITHMETIC - make use the date arthmetic functions

-- DATE_ADD(), DATE_SUB(), DATEDIFF()

-- Add 1 day to the current date
SELECT NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY);

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR);

SELECT NOW(), DATE_SUB(NOW(), INTERVAL 1 DAY);

SELECT NOW(), DATE_SUB(NOW(), INTERVAL 2 DAY);

SELECT NOW() AS order_date, DATE(DATE_ADD(NOW(), INTERVAL 2 DAY)) AS delivery_date;

-- DATEDIFF()

SELECT DATEDIFF('2021-03-02', '2021-02-28');

-- categorize results based on the difference in days
-- if the day difference is greater than 5, that's bad

SELECT IF( DATEDIFF('2021-03-02', '2021-02-28') > 5 , 'bad', 'good');

-- the CASE statement allows us to define multiple conditions 

-- first use a subquery to query the number of days
SELECT num_days
FROM ( SELECT DATEDIFF('2021-03-02', '2021-02-28') AS num_days ) AS my_table;

-- use CASE to define mutliple conditions
SELECT 
	CASE 
		WHEN num_days < 3 THEN 'good'
        WHEN num_days BETWEEN 3 AND 5 THEN 'ok'
        WHEN num_days > 5 THEN 'bad'
	END AS delivery_result
FROM ( SELECT DATEDIFF('2021-03-02', '2021-02-28') AS num_days ) AS my_table;

SELECT 
	CASE 
		WHEN num_days < 3 THEN 'good'
        WHEN num_days BETWEEN 3 AND 5 THEN 'ok'
        WHEN num_days > 5 THEN 'bad'
	END AS delivery_result
FROM ( SELECT DATEDIFF('2021-03-02', '2021-02-25') AS num_days ) AS my_table;

SELECT 
	CASE 
		WHEN num_days < 3 THEN 'good'
        WHEN num_days BETWEEN 3 AND 5 THEN 'ok'
        WHEN num_days > 5 THEN 'bad'
	END AS delivery_result
FROM ( SELECT DATEDIFF('2021-03-02', '2021-02-14') AS num_days ) AS my_table;