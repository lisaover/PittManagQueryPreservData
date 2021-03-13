-- create a simple database to practice reading in NULL values

CREATE DATABASE simple_db;

USE simple_db;

-- make a simple table with 3 variables

CREATE TABLE table_1 (
id int NOT NULL AUTO_INCREMENT,
x1 int,
x2 int,
x3 text,
PRIMARY KEY (id)
);

-- insert records into the table
INSERT INTO table_1 (x1, x2, x3) VALUES (1, 0, 'a');

INSERT INTO table_1 (x1, x2, x3) VALUES 
(NULL, 1, 'b'),
(3, NULL, 'c'),
(4, 2, NULL);

-- use the data import wizard tool to import in the file
-- 'simple_table_with_NULL_values.csv' and create the table
-- table_2 in the simple_db database

-- be sure to check the datatypes are what you think they should be!

-- select all columns in table_1

-- select all columns in table_2

-- the two tables should be the same!

