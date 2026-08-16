SELECT COUNT(*) FROM players;

SELECT nameGiven,
	TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), debut)  AS starting_age,
    TIMESTAMPDIFF(YEAR, CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE), finalGame)  AS end_age,
    TIMESTAMPDIFF(YEAR, debut, finalGame) AS career_length
FROM players
ORDER BY career_length DESC;
    
SELECT p.nameGiven,
	s.yearID AS starting_year, s.teamID AS starting_team,
    e.yearID AS ending_year, e.teamID AS ending_team
FROM players p 
INNER JOIN salaries s
	ON p.playerID = s.playerID
    AND YEAR(p.debut) = s.yearID
INNER JOIN salaries e
	ON p.playerID = e.playerID
    AND YEAR(p.finalGame) = e.yearID
WHERE s.teamID = e.teamID AND e.yearID - s.yearID > 10;