-- ============================================================
-- FASHION PASSION: TABLES & SAMPLE DATA (FIXED)
-- ============================================================

CREATE DATABASE IF NOT EXISTS fashion_passion_db;
USE fashion_passion_db;

-- 1. Categories
CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO categories (category_id, category_name) VALUES 
(1, 'Apparel'), 
(2, 'Footwear'), 
(3, 'Accessories');

-- 2. Products
CREATE TABLE IF NOT EXISTS products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);

INSERT INTO products (product_id, category_id, product_name, description, price, stock_quantity) VALUES 
(101, 1, 'Silk Evening Gown', 'Elegant long dress', 250.00, 3),
(102, 2, 'Canvas Sneakers', 'Casual everyday shoes', 65.00, 40),
(104, 2, 'Leather Boots', 'Womens winter boots', 120.00, 15),
(108, 2, 'Running Shoes', 'Athletic trainers', 85.00, 25);

-- 3. Users
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    shipping_address TEXT
);

INSERT INTO users (user_id, full_name, email, shipping_address) VALUES 
(1, 'Jane Doe', 'jane@example.com', '123 Main St');

-- 4. Orders (NOW INCLUDES order_date)
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO orders (order_id, user_id, total_amount, status) VALUES 
(101, 1, 185.00, 'Delivered');

-- 5. Order Items
CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES 
(101, 104, 1, 120.00),
(101, 102, 1, 65.00);
