# Portfolio 1: Database Design and Modelling — Fashion Passion

## 1. Case Study Description
* **Organisation Name:** Fashion Passion
* **Nature of Business:** An online e-commerce clothing boutique specialising in apparel, footwear, and accessories. It operates via a digital storefront where customers browse items, add them to carts, place orders, and track shipments.
* **Database Users:** 
  * **Customers/Users:** Browse products, manage profiles, and place orders.
  * **Store Administrators:** Manage product inventory, update categories, and monitor customer orders and statuses.
* **Major Data Stored:** Customer account profiles, product categories, inventory items, customer orders, and line-item order details.
* **Key Operations Supported:** User registration and authentication, product catalog filtering by category, cart and order placement, and tracking total order amounts and stock quantities.

---

## 2. ER Diagram Text Summary
The conceptual ER diagram visually maps out the architecture of the **Fashion Passion** database using 5 core entities and their cardinalities:
* **`users` to `orders` (1-to-Many):** A single user can place multiple orders over time, but each order belongs to one specific user.
* **`categories` to `products` (1-to-Many):** A single category (e.g., Footwear) can contain many products, but each individual product belongs to only one category.
* **`orders` to `order_items` (1-to-Many):** A single order can contain multiple line items, but each order item belongs to one specific order.
* **`products` to `order_items` (1-to-Many):** A product can appear across multiple order items in different customer baskets, but each order item references one specific product.

---

## 3. Relational Schema Table Breakdown (3NF)
The relational model maps the system into five normalized tables with detailed columns, primary keys (PK), and foreign keys (FK):

1. **`users`**
   * `user_id` (PK, INT)
   * `full_name` (VARCHAR)
   * `email` (VARCHAR, UNIQUE)
   * `password_hash` (VARCHAR)
   * `shipping_address` (TEXT)

2. **`categories`**
   * `category_id` (PK, INT)
   * `category_name` (VARCHAR)

3. **`products`**
   * `product_id` (PK, INT)
   * `category_id` (FK references `categories(category_id)`, INT)
   * `product_name` (VARCHAR)
   * `description` (TEXT)
   * `price` (DECIMAL)
   * `stock_quantity` (INT)

4. **`orders`**
   * `order_id` (PK, INT)
   * `user_id` (FK references `users(user_id)`, INT)
   * `order_date` (TIMESTAMP)
   * `total_amount` (DECIMAL)
   * `status` (VARCHAR)

5. **`order_items`**
   * `order_item_id` (PK, INT)
   * `order_id` (FK references `orders(order_id)`, INT)
   * `product_id` (FK references `products(product_id)`, INT)
   * `quantity` (INT)
   * `unit_price` (DECIMAL)

---

## 4. Keys, Constraints, and Normalisation

### A. Keys
* **Primary Keys (PK):** Uniquely identify each record in a table (e.g., `user_id` in `users`, `product_id` in `products`, `order_id` in `orders`).
* **Foreign Keys (FK):** Maintain referential integrity by linking child tables to parent tables (e.g., `category_id` in `products` references `categories(category_id)`; `user_id` in `orders` references `users(user_id)`).

### B. Constraints
* **`NOT NULL`:** Ensures mandatory attributes (e.g., `email`, `product_name`, `price`) cannot be left blank.
* **`UNIQUE`:** Prevents duplicate entries where applicable (e.g., user `email`).
* **`DEFAULT`:** Automatically assigns values where unspecified (e.g., order `status` defaults to `'Pending'`).
* **`CHECK`:** Validates data boundaries (e.g., ensuring `price >= 0` and `stock_quantity >= 0`).

### C. Normalisation Explanation (Up to 3NF)
* **First Normal Form (1NF):** All tables contain atomic (indivisible) values, eliminating repeating groups or arrays. Each column holds a single value, and every table has a defined Primary Key.
* **Second Normal Form (2NF):** The database is in 1NF, and all non-key attributes are fully functionally dependent on the entire primary key (no partial dependencies exist, especially managed via proper decomposition in junction tables like `order_items`).
* **Third Normal Form (3NF):** The database is in 2NF, and all transitive dependencies have been eliminated. Non-key columns depend *only* on the primary key, ensuring columns like `category_name` are isolated in a separate `categories` table rather than repeated inside `products`.
