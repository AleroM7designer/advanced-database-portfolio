-- ============================================================
-- PORTFOLIO 3: TRANSACTIONS AND CONCURRENCY
-- Case Study: Fashion Passion (Order Checkout & Inventory Safety)
-- ============================================================

-- 1. SETUP TABLES & SAMPLE DATA
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO categories (category_id, category_name) VALUES 
(1, 'Apparel'), (2, 'Footwear'), (3, 'Accessories');

CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products (product_id, category_id, product_name, price, stock_quantity) VALUES 
(104, 2, 'Leather Boots', 120.00, 15);

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO users (user_id, full_name, email) VALUES 
(1, 'Jane Doe', 'jane@example.com');

CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================================
-- 2. PART 1: TRANSACTION ATOMICITY (BEGIN, COMMIT)
-- ============================================================
BEGIN;

-- Insert a new customer order
INSERT INTO orders (order_id, user_id, total_amount, status) 
VALUES (102, 1, 120.00, 'Processing');

-- Add the line item to the order
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, unit_price) 
VALUES (201, 102, 104, 1, 120.00);

-- Deduct inventory stock safely (Leather Boots stock drops from 15 to 14)
UPDATE products 
SET stock_quantity = stock_quantity - 1 
WHERE product_id = 104;

-- Finalize the transaction permanently
COMMIT;


-- ============================================================
-- 3. PART 2: CONCURRENCY CONTROL (ROW-LEVEL LOCKING)
-- ============================================================
BEGIN;

-- Lock product 104 for update to prevent race conditions during concurrent checkouts
SELECT product_id, stock_quantity 
FROM products 
WHERE product_id = 104 
FOR UPDATE;

-- Update stock securely under the active lock
UPDATE products 
SET stock_quantity = stock_quantity - 1 
WHERE product_id = 104;

COMMIT;


-- ============================================================
-- 4. VISUAL PROOF & RESULTS
-- ============================================================
-- These select queries output the tables so you can see your results and take your screenshot
SELECT * FROM products WHERE product_id = 104;
SELECT * FROM orders WHERE order_id = 102;
