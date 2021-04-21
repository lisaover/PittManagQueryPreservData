-- CMPINF 2110 homework 04 MySQL script

USE hw04_bob_robss_db;

-- query the paintings table
SELECT * FROM paintings;

-- query the features in paintings table
SELECT * FROM features_in_paintings;

-- JOIN the tables together
SELECT * 
FROM features_in_paintings
LEFT JOIN paintings USING (painting_id);

-- include the artist table in the JOINS
SELECT * 
FROM features_in_paintings
LEFT JOIN paintings USING (painting_id)
LEFT JOIN artists USING (artist_id);

-- include the features table in the JOINS
SELECT * 
FROM features_in_paintings
LEFT JOIN paintings USING (painting_id)
LEFT JOIN artists USING (artist_id)
LEFT JOIN features USING (feature_id);

-- finding out which paintings have at least mountain can be done
-- several ways. we could perform the subset based on the above
-- joined table.

-- alternatively, we can use the features_in_paintings table
-- joined with the features table
SELECT * FROM features_in_paintings
LEFT JOIN features USING (feature_id);

-- we can find all rows with MOUNTAIN since that give us
-- at least one mountain of any kind
SELECT * FROM features_in_paintings
LEFT JOIN features USING (feature_id)
WHERE feature_name LIKE 'MOUNTAIN';

-- we can use the above query as a SUBQUERY!

SELECT * 
FROM 
	(SELECT * 
		FROM features_in_paintings 
        LEFT JOIN features USING (feature_id) 
        WHERE feature_name LIKE 'MOUNTAIN') AS my_table
LEFT JOIN paintings USING (painting_id);

-- which can be simplified by selecting just the distinct
-- IDs
SELECT DISTINCT painting_id, season_id, episode_id, title 
FROM 
	(SELECT * 
		FROM features_in_paintings 
        LEFT JOIN features USING (feature_id) 
        WHERE feature_name LIKE 'MOUNTAIN') AS my_table
LEFT JOIN paintings USING (painting_id);