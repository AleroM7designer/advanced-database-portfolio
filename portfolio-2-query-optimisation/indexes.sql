-- Fashion Passion: Performance Indexes

-- Index for Query 1: Filtering products by category and sorting by price
CREATE INDEX idx_products_category_price ON products(category_id, price);

-- Index for Query 2: Filtering and sorting orders by user and date
CREATE INDEX idx_orders_user_date ON orders(user_id, order_date);

-- Index for Query 3: Fast lookup of order items by order ID
CREATE INDEX idx_order_items_order_id ON order_items(order_id);

-- Index for Query 4: Checking stock quantities for inventory management
CREATE INDEX idx_products_stock ON products(stock_quantity);