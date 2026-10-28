EXPLAIN SELECT product_id, product_name, stock_quantity
FROM products
WHERE stock_quantity < 15
ORDER BY stock_quantity ASC;