USE maven_advanced_sql;

WITH 
	order_trc AS (
		SELECT customer_id, order_id, MIN(transaction_id) AS min_tid , SUM(units) AS total_units
		FROM orders
		GROUP BY customer_id, order_id
		ORDER BY customer_id, min_tid
	),
    
    dif_total AS (
		SELECT customer_id, order_id, total_units,
				LAG(total_units) OVER(PARTITION BY customer_id ORDER BY min_tid) AS prior_units
		FROM order_trc
     )
     
 SELECT customer_id, order_id, total_units, prior_units, 
		total_units - prior_units AS diff_units
FROM dif_total;