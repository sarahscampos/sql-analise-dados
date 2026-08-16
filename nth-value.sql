USE maven_advanced_sql;

SELECT * FROM
(SELECT order_id, product_id, units,
	NTH_VALUE(product_id, 2) OVER(PARTITION BY order_id ORDER BY units DESC) AS second_product
FROM orders
ORDER BY order_id, second_product) AS sp
WHERE product_id = second_product;