SELECT product_name,
	CASE WHEN INSTR(product_name, '-') = 0 THEN product_name
		ELSE SUBSTR(product_name, INSTR(product_name, '-') + 2)
        END AS new_product_name
FROM products
ORDER BY product_name;