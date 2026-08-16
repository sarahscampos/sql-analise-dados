WITH fp AS (
	SELECT factory, product_id,
		REPLACE(REPLACE(factory, "'", ""), " ", "-") AS factory_clean
	FROM products
	ORDER BY factory, product_id
)

SELECT factory_clean, product_id,
	CONCAT(factory_clean, "-", product_id) AS factory_product_id
FROM fp;