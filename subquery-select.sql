USE maven_advanced_sql;

SELECT 
product_id,
product_name,
unit_price,
(SELECT AVG(unit_price) FROM products) AS avg_unit_price,
unit_price - (SELECT AVG(unit_price) FROM products) AS diff_price
FROM products
ORDER BY unit_price DESC;