USE maven_advanced_sql;

SELECT 
	p1.product_name,
    p1.unit_price,
    p2.product_name,
    p2.unit_price,
    p1.unit_price - p2.unit_price AS price_diff
FROM products p1
INNER JOIN products p2
	ON p1.product_id <> p2.product_id
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
AND p1.product_name < p2.product_name
ORDER BY price_diff DESC;