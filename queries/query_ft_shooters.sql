-- Querying the top 20 free throw shooters based on their percentage
-- from the past 25 years (minimum of 500 career attempts)

SELECT 
	RANK() OVER (
  ORDER BY (SUM(ftm)/SUM(fta)) DESC
  ),
	player_name, (SUM(ftm)/SUM(fta)) as ft_pct_career, SUM(fta) as total_fta
FROM player as pl JOIN player_game_log as plg
	ON pl.player_id = plg.player_id
GROUP BY 2
	HAVING SUM(plg.fta) >= 500
ORDER BY 1 ASC;

-- Querying the quintiles of every player's free throw shooting average (minimum 1000 attempts)
-- from the past 25 years, then getting the average of each quintile

WITH career_ft_pct AS (
  SELECT player_name, (SUM(ftm)/SUM(fta)) as ft_pct_career, SUM(fta) as total_fta
	FROM player as pl JOIN player_game_log as plg
		ON pl.player_id = plg.player_id
	GROUP BY 1
		HAVING SUM(plg.fta) >= 500
),
ft_pct_quintile AS (
	SELECT NTILE(5) OVER (
  	ORDER BY ft_pct_career DESC
  ) as quintile, ft_pct_career, total_fta
	FROM career_ft_pct
)
SELECT quintile, AVG(ft_pct_career) as top20_pct
FROM ft_pct_quintile
GROUP BY 1;
