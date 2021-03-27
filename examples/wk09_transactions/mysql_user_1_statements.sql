-- user 1

USE simple_shoes_db;

-- just select
SELECT * FROM shoes;

-- or wrap the select around transaction and commit
-- are the same thing
START TRANSACTION;

SELECT * FROM shoes;

COMMIT;

-- user 1 queries the shoes table while user 2 modifies it

-- the protection against CONCURRENCY PROBLEMS

-- lets have user 1 repeat the query, but this time user 2's modifcations
-- get rolled back

START TRANSACTION;

SELECT * FROM shoes;

COMMIT;

-- DIRTY READS -- simplest CONCURRENCY PROBLEM that can occur

-- USER 1 accesses a portion of the data BEFORE USER 2's changes 
-- have been committed represents that there is an ISOLATION between
-- user 2 and user 1

-- Isolution -- TRANSACTIONS do NOT compete with each other. multiple transactions
-- running at the same time do NOT intefer

-- A: atomicity
-- C: Consistenncy
-- I: Isolation
-- D: Durability

-- SQL (Relational data bases) follow ACID transactions

-- surprises in the data can occur when transactions compete from multiple users
-- there are multiple ISOLATION LEVELS

SHOW VARIABLES LIKE 'transaction_isolation';

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SHOW VARIABLES LIKE 'transaction_isolation';

-- query the data base as user 2 makes changes
START TRANSACTION;

SELECT * FROM shoes;

COMMIT;

-- prevent dirty reads by creating an isolation level between transactions

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SHOW VARIABLES LIKE 'transaction_isolation';

-- user 1 only reads data that has been committed

START TRANSACTION;

SELECT * FROM shoes;

SELECT * FROM shoes;

COMMIT;

-- the read committed isolation level prevents dirty reads
-- but does NOT prevent NON-REPEATABLE READS

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

SHOW VARIABLES LIKE 'transaction_isolation';

-- make the same two select statements within a transaction

START TRANSACTION;

SELECT * FROM shoes;

SELECT * FROM shoes;

COMMIT;

-- the highest isolation level converts the multi user environment
-- to an effective single user environment
-- by forcing every transaction to run sequentially or in serial

-- every transaction that comes in, is executed one after the other

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SHOW VARIABLES LIKE 'transaction_isolation';

-- user 2 starts a transaction and then user 1 queries the table

START TRANSACTION;

SELECT * FROM shoes;

COMMIT;

-- user 2 starts a transaction and then commits see what happens with
-- user 1's transaction

SHOW VARIABLES LIKE 'transaction_isolation';

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SHOW VARIABLES LIKE 'transaction_isolation';

--

START TRANSACTION;

SELECT * FROM shoes;

COMMIT;

-- reset to default isolation level

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;