USE maven_advanced_sql;

WITH pf AS (
	SELECT factory, product_name
	FROM products
),

pq AS (
SELECT factory, COUNT(product_id) AS num_products
	FROM products
	GROUP BY factory
)

SELECT pf.factory, pf.product_name, pq.num_products 
FROM pf
LEFT JOIN pq 
    ON pf.factory = pq.factory
ORDER BY pf.factory, pf.product_name;