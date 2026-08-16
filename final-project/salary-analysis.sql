WITH ts AS (
	SELECT teamID, yearID, SUM(salary) AS total_spend
    FROM salaries
    GROUP BY teamID, yearID
),

sp AS (
	SELECT teamID, AVG(total_spend) AS avg_spend,
		NTILE(5) OVER(ORDER BY AVG(total_spend) DESC) AS spend_pct
	FROM ts
    GROUP BY teamID
)

SELECT teamID, ROUND(avg_spend/1000000, 1) AS avg_spend_millions
FROM sp
WHERE spend_pct = 1;

WITH ts AS (
	SELECT teamID, yearID, SUM(salary) AS total_spend
    FROM salaries
    GROUP BY teamID, yearID
),

cs AS (
	SELECT teamID, yearID,
		SUM(total_spend) OVER (PARTITION BY teamID ORDER BY yearID)
			AS cumulative_sum
	FROM ts
),

rn AS (
	SELECT teamID, yearID, cumulative_sum,
		ROW_NUMBER() OVER(PARTITION BY teamID ORDER BY cumulative_sum) AS rn
	FROM cs
	WHERE cumulative_sum > 1000000000
)

SELECT teamID, yearID, ROUND(cumulative_sum/1000000000, 2) AS cumulative_sum_billions
FROM rn
WHERE rn = 1;
