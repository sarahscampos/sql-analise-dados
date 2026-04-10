USE maven_advanced_sql;

-- Quantidade de produtos distintos em orders e products
SELECT COUNT(DISTINCT product_id) FROM orders;
SELECT COUNT(DISTINCT product_id) FROM products;

-- Produtos que existem em orders e não existem em products
SELECT 
	o.order_id, 
    o.product_id as product_id_order,
    p.product_id,
    p.product_name
FROM orders o
LEFT JOIN products p
	ON o.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Produtos que existem em products e não existem em orders
SELECT 
    p.product_id,
    p.product_name,
    o.order_id, 
    o.product_id as product_id_order
FROM products p
LEFT JOIN orders o
	ON p.product_id = o.product_id
WHERE o.product_id IS NULL;


