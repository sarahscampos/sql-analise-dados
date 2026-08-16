USE maven_advanced_sql;

SELECT FLOOR(yearID / 10)*10 AS decade, COUNT(DISTINCT schoolID) AS num_schools
FROM schools
GROUP BY decade
ORDER BY decade;


SELECT sd.name_full, COUNT(DISTINCT s.playerID) AS num_players
FROM schools s 
LEFT JOIN school_details sd 
	ON s.schoolID = sd.schoolID
GROUP BY s.schoolID
ORDER BY num_players DESC
LIMIT 5;

WITH top3 AS (
	SELECT FLOOR(yearID / 10)*10 AS decade, sd.name_full, COUNT(DISTINCT s.playerID) AS num_players
	FROM schools s 
	LEFT JOIN school_details sd 
		ON s.schoolID = sd.schoolID
	GROUP BY decade, s.schoolID
),
rn AS (
	SELECT decade, name_full, num_players,
	ROW_NUMBER() OVER(PARTITION BY decade ORDER BY num_players DESC) AS rn
FROM top3
)

SELECT decade, name_full, num_players 
FROM rn
WHERE rn <= 3
ORDER BY decade DESC, rn;