-- Querying the top 20 three point shooters based on their percentage
-- from the past 25 years (minimum of 1000 career attempts)

SELECT 
	RANK() OVER (
  ORDER BY (SUM(fg3m)/SUM(fg3a)) DESC
  ),
	player_name, (SUM(fg3m)/SUM(fg3a)) as fg3_pct_career, SUM(fg3a) as total_fg3a
FROM player as pl JOIN player_game_log as plg
	ON pl.player_id = plg.player_id
GROUP BY 2
	HAVING SUM(plg.fg3a) >= 1000
ORDER BY 1 ASC
LIMIT 20;

-- Querying the quintiles of every player's 3 point shooting average (minimum 1000 attempts)
-- from the past 25 years, then getting the average of each quintile

WITH career_fg3_pct AS (
  SELECT player_name, (SUM(fg3m)/SUM(fg3a)) as fg3_pct_career, SUM(fg3a) as total_fg3a
	FROM player as pl JOIN player_game_log as plg
		ON pl.player_id = plg.player_id
	GROUP BY 1
		HAVING SUM(plg.fg3a) >= 1000
),
fg3_pct_quintile AS (
	SELECT NTILE(5) OVER (
  	ORDER BY fg3_pct_career DESC
  ) as quintile, fg3_pct_career, total_fg3a
	FROM career_fg3_pct
)
SELECT quintile, AVG(fg3_pct_career) as top20_pct
FROM fg3_pct_quintile
GROUP BY 1;