USE maven_advanced_sql;

WITH ts AS (
	SELECT o.customer_id, SUM(o.units * p.unit_price) AS total_spend
	FROM orders o 
	LEFT JOIN products p
		ON o.product_id = p.product_id
	GROUP BY o.customer_id
	ORDER BY total_spend DESC
),

sp AS (
	SELECT customer_id, total_spend,
		NTILE(100) OVER(ORDER BY total_spend DESC) AS spend_pct
	FROM ts
)

SELECT * 
FROM sp
WHERE spend_pct = 1;


