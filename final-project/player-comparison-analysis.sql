WITH bn AS (
	SELECT CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate,
		nameGiven
	FROM players
)

SELECT birthdate, GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players
FROM bn
WHERE YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate;

SELECT s.teamID,
	ROUND(SUM(CASE WHEN p.bats = 'R' THEN 1 ELSE 0 END) / COUNT(s.playerID)*100, 1) AS bats_right,
    ROUND(SUM(CASE WHEN p.bats = 'L' THEN 1 ELSE 0 END) / COUNT(s.playerID)*100, 1) AS bats_left,
    ROUND(SUM(CASE WHEN p.bats = 'B' THEN 1 ELSE 0 END) / COUNT(s.playerID)*100, 1) AS bats_both
FROM salaries s LEFT JOIN players p
	ON s.playerID = p.playerID
GROUP BY s.teamID;

WITH hw AS (
		SELECT FLOOR(YEAR(debut) / 10)*10 AS decade, AVG(height) AS avg_height, AVG(weight) AS avg_weight
		FROM players
		GROUP BY decade
    )

SELECT decade, 
	avg_height - LAG(avg_height) OVER(ORDER BY decade) AS height_diff,
    avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff
FROM hw
WHERE decade IS NOT NULL;