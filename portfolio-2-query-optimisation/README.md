# Portfolio 2: Query Processing and Optimisation - Fashion Passion

## 1. Overview
This activity evaluates query performance, execution plans, and optimization strategies for the *Fashion Passion* e-commerce database.

## 2. Benchmark Queries
The performance of the following four core operations was analyzed before and after applying indexes:
1. **Catalog Filtering Query:** Searching products by `category_id` and sorting by `price`.
2. **Customer Order History Query:** Retrieving orders placed by a specific `user_id`.
3. **Order Line Items Query:** Fetching detailed item breakdowns for a specific `order_id`.
4. **Inventory Stock Check Query:** Filtering products with stock levels below critical thresholds.

## 3. Initial Performance (Pre-Optimization)
* **Execution Strategy:** Prior to indexing, the database optimizer relied on **Sequential Scans (Full Table Scans)** across the `products`, `orders`, and `order_items` tables.
* **Overhead:** Every row in the respective tables had to be read into memory to evaluate filter conditions, resulting in higher I/O costs and overall execution time.

## 4. Indexing Strategy
To optimize query performance, target indexes were created on foreign key relationships and frequently queried columns:
* Composite index on `products(category_id, price)`
* Foreign key index on `orders(user_id)`
* Foreign key index on `order_items(order_id)`

## 5. Optimized Performance Analysis (Post-Optimization)
* **Execution Strategy:** After creating the indexes, execution plans shifted from Sequential Scans to **Index Scans** and **Bitmap Index Scans**.
* **Impact:** Direct B-Tree index lookups replaced sequential row checks, significantly reducing query planning costs, disk I/O operations, and execution latency.