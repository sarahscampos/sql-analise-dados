USE maven_advanced_sql;

SELECT factory, product_name
FROM products;

SELECT factory, COUNT(product_id) AS num_products
FROM products
GROUP BY factory;

SELECT prod_fac.factory, prod_fac.product_name, prod_qtd.num_products 
FROM
(
	(SELECT factory, product_name
	FROM products) AS prod_fac
    LEFT JOIN
    (SELECT factory, COUNT(product_id) AS num_products
	FROM products
	GROUP BY factory) AS prod_qtd
	ON prod_fac.factory = prod_qtd.factory
)
ORDER BY prod_fac.factory, prod_fac.product_name;