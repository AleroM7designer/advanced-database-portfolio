EXPLAIN SELECT oi.order_item_id, p.product_name, oi.quantity, oi.unit_price, (oi.quantity * oi.unit_price) AS subtotal
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
WHERE oi.order_id = 101;