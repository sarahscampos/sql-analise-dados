USE maven_advanced_sql;

SELECT customer_id, order_id, order_date, transaction_id,
	ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY transaction_id) AS transaction_num
FROM orders
ORDER BY customer_id, transaction_id;