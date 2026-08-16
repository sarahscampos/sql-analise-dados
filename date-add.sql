SELECT order_id, order_date,
	DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_date
FROM orders
WHERE YEAR(order_date) = 2024 AND MONTH(order_date) BETWEEN 4 AND 6;