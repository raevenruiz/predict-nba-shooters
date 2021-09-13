-- Query players from the 2018-2019 NBA season who played in at least 41
-- games and averaged at least 2.5 three-pointers made, and order them
-- by three-point percentage

SELECT player_name, SUM(fg3m), SUM(fg3a), (SUM(fg3m)/SUM(fg3a)) as fg3_pct
FROM player as pl JOIN player_game_log as pgl
 	ON pl.player_id = pgl.player_id
WHERE season_id = 2018
	AND fg3a > 0
  AND college != 'None'
	AND pgl.player_id IN (
    SELECT player_id
    FROM player_game_log
    GROUP BY 1
    	HAVING COUNT(player_id) >= 41
	)
GROUP BY 1
	HAVING SUM(fg3m) >= 160
ORDER BY 4 DESC;