-- user 2

USE simple_shoes_db;

-- remind ourselves what the shoes table looks like

SELECT * FROM shoes;

-- user 2 wants to update by including lables for the black
-- and blue shoes

START TRANSACTION;

UPDATE shoes SET shoe_label = 'B' WHERE shoe_id = 1;
UPDATE shoes SET shoe_label = 'B' WHERE shoe_id = 3;

COMMIT;

-- this time user 2 makes modifications but those changes
-- are rolled back (for whatever reason)

START TRANSACTION;

UPDATE shoes SET shoe_label = 'r' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'w' WHERE shoe_id = 4;

ROLLBACK;

SHOW VARIABLES LIKE 'transaction_isolation';

-- repeat the transaction which sets the shoe labels to lower cases
-- and then we will rollback

START TRANSACTION;

UPDATE shoes SET shoe_label = 'r' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'w' WHERE shoe_id = 4;

ROLLBACK;

-- user 1 now only reads committed transactions, so update the shoe labels
-- again but this time commit!
START TRANSACTION;

UPDATE shoes SET shoe_label = 'r' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'w' WHERE shoe_id = 4;

COMMIT;

-- user 1 now has read committed isolation level

START TRANSACTION;

UPDATE shoes SET shoe_label = 'R' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'W' WHERE shoe_id = 4;

COMMIT;

-- user 1 now had read repeatable isolation level

START TRANSACTION;

UPDATE shoes SET shoe_label = 'r' WHERE shoe_id = 2;

UPDATE shoes SET shoe_label = 'w' WHERE shoe_id = 4;

COMMIT;

-- user 1 now has serializable isolation level

START TRANSACTION;

UPDATE shoes SET shoe_label = 'R' WHERE shoe_id = 2;

COMMIT;

-- update the white shoes label in series alter

START TRANSACTION;

UPDATE shoes SET shoe_label = 'R' WHERE shoe_id = 2;

COMMIT;
