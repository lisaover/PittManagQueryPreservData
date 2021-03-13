-- create a data base so we can practice working with data types

CREATE DATABASE dtypes_db;

USE dtypes_db;

-- create a table named states

-- integer datatypes: https://dev.mysql.com/doc/refman/8.0/en/integer-types.html

CREATE TABLE states (
	id INT NOT NULL AUTO_INCREMENT,
    symbol CHAR(2) NOT NULL,
    state_name_fixed CHAR(50),
    state_name VARCHAR(50),
    notes VARCHAR(255),
    long_notes TEXT,
    PRIMARY KEY (id)
);

-- add rows to our table
INSERT INTO states (symbol, state_name_fixed, state_name, notes) 
VALUES ('PA', 'Pennsylvania', 'Pennsylvania', 'I live in PA'), 
	   ('MA', 'Massachusetts', 'Massachusetts', 'I used to live in MA'), 
	   ('TX', 'Texas', 'Texas', 'I have never lived in TX');
       
-- add in another row for TEXAS where we include trailing spaces
INSERT INTO states (symbol, state_name_fixed, state_name, notes)
VALUES ('TX', 'Texas     ', 'Texas     ', 'Texas with extra spaces');

SELECT * FROM states;

SELECT id, state_name_fixed, state_name
FROM states
WHERE symbol = 'TX';

-- what are the lengths of the strings?
SELECT id, state_name_fixed, state_name,
	CHAR_LENGTH(state_name_fixed), CHAR_LENGTH(state_name)
FROM states
WHERE symbol = 'TX';

-- CHAR() data types have the trailing spaces TRIMMED upon retrieval
SELECT id, state_name_fixed, state_name, TRIM(state_name),
	CHAR_LENGTH(state_name_fixed), CHAR_LENGTH(state_name),
    CHAR_LENGTH( TRIM(state_name) )
FROM states
WHERE symbol = 'TX'; 

-- add in another row where the extra space is in between the characters
INSERT INTO states (symbol, state_name_fixed, state_name, notes) 
VALUES ('NM', 'New Mexico', 'New Mexico', 'I have not lived in New Mexico');

SELECT id, state_name_fixed, state_name, TRIM(state_name),
	CHAR_LENGTH(state_name_fixed), CHAR_LENGTH(state_name),
    CHAR_LENGTH( TRIM(state_name) )
FROM states
WHERE symbol IN ('TX', 'NM'); 

-- if we only want to TRIM BEFORE the first character thats LTRIM()
-- if we only want to TRIM AFTER the last character thats RTRIM()

SELECT id, state_name, REPLACE(state_name, ' ', '')
FROM states;

-- what happens if enter data where the number of characters exceeds the 
-- maximum allocated character length???

INSERT INTO states (symbol, state_name_fixed, state_name) 
VALUES ('UU', 'a fake very long state name with many characters that exceeds the max length of 50 we specified',
		'a fake very long state name with many characters that exceeds the max length of 50 we specified');

-- so lets remove the CHAR() variable and try again with just the VARCHAR()
INSERT INTO states (symbol, state_name) 
VALUES ('UU','a fake very long state name with many characters that exceeds the max length of 50 we specified');

-- interested in storing the year the state was admitted to the USA

ALTER TABLE `dtypes_db`.`states` 
ADD COLUMN `admit_year` INT NULL AFTER `long_notes`;

-- UPDATE the values or records in the column
UPDATE states SET admit_year = 1787 WHERE symbol = 'PA';

-- because of SAFE MODE where we need to specify the PRIMARY KEY associated
-- with the UPDATED record
UPDATE states SET admit_year = 1787 WHERE id = 1;

-- modify or update the admit_year for multiple rows
UPDATE states SET admit_year = 
	CASE WHEN id = 2 THEN 1788
		 WHEN id IN (3, 4) THEN 1845
	END
WHERE id IN (2, 3, 4);

-- if we query the states and when they were admitted to the union
-- maybe we would like to change teh NULL return
SELECT id, state_name, admit_year FROM states;

-- IFNULL() function to modify what gets displayed for MISSING or NULL values
SELECT id, state_name, IFNULL(admit_year, 'Not sure') FROM states;

-- DECIMAL(9, 2) -> 1234567.89

-- JSON 

ALTER TABLE `dtypes_db`.`states` 
ADD COLUMN `state_bird` JSON NULL AFTER `admit_year`;

-- specify the JSON object within {} with KEY : VALUE

UPDATE states
SET state_bird = '
	{
		"name": "Ruffed Grouse",
        "two_term_name": "Bonasa umbellus",
        "year": 1931
    }
' 
WHERE id = 1;

-- another way with the JSON_OBJECT() function

ALTER TABLE `dtypes_db`.`states` 
ADD COLUMN `state_bird_again` JSON NULL AFTER `state_bird`;

UPDATE states
SET state_bird_again = JSON_OBJECT(
	'name', 'Ruffed Grouse',
    'two_term_name', 'Bonasa umbellus',
    'year', 1931
) 
WHERE id = 1;

SELECT symbol, state_bird, state_bird_again FROM states WHERE symbol = 'PA';

-- extract a value from a KEY in a JSON object use the JSON_EXTRACT()
SELECT 
	symbol,
    JSON_EXTRACT(state_bird, '$.name')
FROM states
WHERE symbol = 'PA';

-- column path operator: -> instead of JSON_EXTRACT()
SELECT 
	symbol,
    state_bird -> '$.name'
FROM states
WHERE symbol = 'PA';

-- remove the double quotes with the ->>
SELECT 
	symbol,
    state_bird ->> '$.name'
FROM states
WHERE symbol = 'PA';

SELECT symbol, IFNULL(state_bird ->> '$.name', "Must look up")
FROM states;