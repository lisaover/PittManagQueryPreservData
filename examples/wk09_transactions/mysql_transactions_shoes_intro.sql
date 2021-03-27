-- CMPINF 2110 Spring 2021 - Week 09

CREATE DATABASE simple_shoes_db;

USE simple_shoes_db;

-- create the shoes table which stores information associated with
-- unique shoe colors

CREATE TABLE shoes (
shoe_id INT NOT NULL AUTO_INCREMENT,
shoe_label TEXT,
shoe_color TEXT,
PRIMARY KEY (shoe_id)
);

-- populate information about shoe colors
INSERT INTO shoes (shoe_color) VALUES
('black'), ('red'), ('blue'), ('white');

-- look at the shoes table
SELECT * FROM shoes;

-- update the shoes table so the shoe_lable for the red shoe is R 
UPDATE shoes SET shoe_label = 'R' WHERE shoe_id = 2;

SELECT * FROM shoes;

-- TRANSACTION -> a unit of work or set of MySQL commands that
-- modify/update/insert/select rows/columns from tables in the database

SHOW VARIABLES LIKE 'autocommit';

-- the formal transaction that occurs is : start, steps, commit
START TRANSACTION;

UPDATE shoes SET shoe_label = 'r' WHERE shoe_id = 2;

COMMIT;

-- why does this matter?

-- what if the transaction fails?

-- if a transaction fails, the modifications/updates/insertions/deletions
-- are NOT committed. the changes are ROLLBACKED or UNDO the changes
-- a LOG FILE is created that documents the changes to the database.

-- if the transaction fails, the LOG-FILE is used to UNDO the changes.

-- create a transaction where we change the shoe_label for red shoes
-- back to capital R AND set the shoe_label for white shoes to capital W 

START TRANSACTION;

UPDATE shoes SET shoe_label = 'R' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'W' WHERE shoe_id = 4;

-- UNDO the changes or ROLLBACK the transaction
ROLLBACK;

SELECT * FROM shoes;

-- A transaction is a complete entity 
-- A transaction either SUCCEEDS completely OR FAILS completely

-- we cannot ROLLBACK one or partial statements within a transaction
-- we can only ROLLBACK the entire transaction

START TRANSACTION;

UPDATE shoes SET shoe_label = 'R' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'W' WHERE shoe_id = 4;

-- let's now commit the modifications
COMMIT;

-- once a transaction is COMMITTED the changes are permanent
-- they last forever!!!!!!!!!!!!!!!!

-- the transaction is a complete unit -- ATOMIC

-- changes are committed and last forever -- the changes are DURABLE

-- the database is CONSISTENT -- we want the underlying data to be consistent
-- for all users