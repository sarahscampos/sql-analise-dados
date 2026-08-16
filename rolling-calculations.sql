WITH ms AS (
	SELECT YEAR(o.order_date) AS yr, MONTH(o.order_date) AS mnth, 
		SUM(o.units * p.unit_price) AS total_sales
	FROM orders o 
    LEFT JOIN products p
		ON o.product_id = p.product_id
	GROUP BY YEAR(o.order_date), MONTH(o.order_date)
    ORDER BY YEAR(o.order_date), MONTH(o.order_date)
	)

SELECT *,
	ROW_NUMBER() OVER (ORDER BY yr, mnth) AS rn,
    SUM(total_sales) OVER (ORDER BY yr, mnth) AS cumulative_sum,
    AVG(total_sales) OVER (ORDER BY yr, mnth ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS six_month_ma
FROM ms;