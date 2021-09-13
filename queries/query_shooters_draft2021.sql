-- Exceptional Future 3-Point Shooters
SELECT player, pct_ft as 'FT%', fta as 'FTA', pct_3pt as '3P%', a3pt as '3PA'
FROM draft_stats
WHERE pct_ft >= 0.800 AND fta >= 1.0
	AND pct_3pt >= 0.400 AND a3pt > 3.0
ORDER BY 3 DESC;

-- Potentially Great 3-Point Shooters
SELECT player, pct_ft as 'FT%', fta as 'FTA', pct_3pt as '3P%', a3pt as '3PA'
FROM draft_stats
WHERE pct_ft >= 0.800 AND fta >= 2.0
	AND pct_3pt >= 0.300 AND a3pt >= 3.0
	AND player NOT IN (
		SELECT player
		FROM draft_stats
		WHERE pct_ft >= 0.800 AND fta >= 1.0
			AND pct_3pt >= 0.400 AND a3pt > 3.0
ORDER BY 3 DESC;

-- 'Dark Horse' Future NBA Three-Point Shooters
SELECT player, pct_ft as 'FT%', fta as 'FTA', pct_3pt as '3P%', a3pt as '3PA'
FROM draft_stats
WHERE pct_3pt >= 0.300 AND pct_ft <= 0.700
	AND player NOT IN (
		SELECT player
		FROM draft_stats
		WHERE pct_ft >= 0.800 AND fta >= 1.0
			AND pct_3pt >= 0.400 AND a3pt > 3.0
	)
	AND player NOT IN (
		SELECT player
		FROM draft_stats
		WHERE pct_ft >= 0.800 AND fta >= 2.0
			AND pct_3pt >= 0.300 AND a3pt >= 3.0
	)
ORDER BY 3 DESC;