EXPLAIN SELECT o.order_id, o.order_date, o.status, o.total_amount, u.full_name
FROM orders o
JOIN users u ON o.user_id = u.user_id
WHERE o.user_id = 1
ORDER BY o.order_date DESC;