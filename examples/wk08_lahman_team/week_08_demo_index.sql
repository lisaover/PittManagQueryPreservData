USE lahman_batting;

-- query all players on the Pittsburgh Pirates from the players_on_teams table
SELECT playerID, teamID, H, HR FROM players_on_teams WHERE teamID = 'PIT';

EXPLAIN SELECT playerID, teamID, H, HR FROM players_on_teams WHERE teamID = 'PIT';

-- creating an INDEX on a column (field)

CREATE INDEX idx_team ON players_on_teams (teamID);

EXPLAIN SELECT playerID, teamID, H, HR FROM players_on_teams WHERE teamID = 'PIT';

SHOW INDEXES IN players_on_teams;

-- try with another team
EXPLAIN SELECT playerID, teamID, H, HR FROM players_on_teams WHERE teamID = 'LAA';