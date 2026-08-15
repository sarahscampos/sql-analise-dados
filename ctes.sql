USE maven_advanced_sql;

WITH prod_order AS (
SELECT o.order_id, o.product_id, o.units, p.unit_price, 
	p.unit_price * o.units AS amount_spent
FROM orders o
LEFT JOIN products p
	ON o.product_id = p.product_id
),

orders_200 AS (
SELECT order_id,
	SUM(amount_spent) AS total_amount_spent 
FROM prod_order 
GROUP BY order_id
HAVING total_amount_spent > 200
)

SELECT COUNT(*) 
FROM orders_200