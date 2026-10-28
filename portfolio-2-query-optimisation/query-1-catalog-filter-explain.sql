EXPLAIN SELECT product_id, product_name, price, stock_quantity
FROM products
WHERE category_id = 2
ORDER BY price DESC;