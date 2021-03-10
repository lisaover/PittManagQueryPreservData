USE ross_db;

SELECT e.season_id, e.episode_id, e.painting_title
FROM features_in_paintings f
LEFT JOIN episodes e
ON e.season_id = f.season_id AND e.episode_id = f.episode_id
WHERE f.feature_id = (SELECT feature_id FROM features WHERE feature = 'MOUNTAIN');
