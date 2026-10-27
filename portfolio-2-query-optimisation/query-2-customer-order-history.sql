SELECT u.full_name, o.order_id, o.order_date, o.total_amount, o.status
FROM users u
JOIN orders o ON u.user_id = o.user_id
WHERE u.user_id = 1;