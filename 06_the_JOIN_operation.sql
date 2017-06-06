-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT matchid, player FROM goal 
  WHERE teamid LIKE 'GER'

-- Show id, stadium, team1, team2 for just game 1012
SELECT id,stadium,team1,team2 FROM game
  WHERE id = 1012

-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
-- Modify it to show the player, teamid, stadium and mdate and for every German goal.
SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
  WHERE teamid = 'GER'

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
SELECT team1, team2, player 
  FROM game JOIN goal ON (game.id = goal.matchid)
  WHERE goal.player LIKE 'Mario%'

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (goal.teamid = eteam.id)
  WHERE gtime<=10

-- List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT mdate, teamname
  FROM game JOIN eteam ON (game.team1 = eteam.id)
  WHERE eteam.coach = 'Fernando Santos'

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
SELECT player
  FROM game JOIN goal ON (game.id = goal.matchid)
  WHERE stadium = 'National Stadium, Warsaw'

-- Instead show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
  FROM game JOIN goal ON (game.id = goal.matchid)
  WHERE (team1 = 'GER' OR team2 = 'GER')
  AND goal.teamid != 'GER'

-- Show teamname and the total number of goals scored.
SELECT teamname, COUNT(*)
  FROM goal JOIN eteam on (goal.teamid = eteam.id)
  GROUP BY teamname

-- Show the stadium and the number of goals scored in each stadium.
SELECT stadium, COUNT(*)
  FROM game JOIN goal ON (game.id = goal.matchid)
  GROUP BY stadium

-- For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT matchid, mdate, COUNT(gtime)
  FROM game JOIN goal ON (game.id = goal.matchid)
  WHERE (team1 = 'POL' OR team2 = 'POL')
  GROUP BY matchid, mdate

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON (game.id = goal.matchid)
  WHERE (team1 = 'GER' OR team2 = 'GER')
  AND teamid = 'GER'
  GROUP BY matchid, mdate

-- List every match with the goals scored by each team as shown.
-- mdate          team1   score1  team2 score2
-- 1 July 2012    ESP     4       ITA   0
-- 10 June 2012   ESP     1       ITA   1
-- 10 June 2012   IRL     1       CRO   3

SELECT mdate, team1, 
        SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) score1, team2, 
        SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON (game.id = goal.matchid)
  GROUP BY mdate, team1, team2