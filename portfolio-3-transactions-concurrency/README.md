# Portfolio 3: Transactions and Concurrency Control
**Case Study:** Fashion Passion Online Retail  
**Database System:** MySQL v9 (DB Fiddle Environment)

---

## 1. Executive Summary
This project demonstrates the implementation of **ACID-compliant transactions** and **concurrency control mechanisms** for the *Fashion Passion* e-commerce database. In high-volume online shopping, atomic transactions ensure that order creation and inventory updates succeed or fail as a single unit. Row-level locking prevents race conditions, overselling, and data corruption during concurrent customer checkouts.

---

## 2. Technical Implementation

### Part 1: Transaction Atomicity & Consistency
To process a customer checkout, three database operations must occur together:
1. Creating a record in the `orders` table.
2. Adding line items to the `order_items` table.
3. Decrementing stock quantity in the `products` table.

Using `BEGIN` and `COMMIT`, the script guarantees **Atomicity**—if any step fails, the entire transaction rolls back (`ROLLBACK`), preserving data integrity.

### Part 2: Concurrency Control (Row-Level Locking)
To safeguard inventory when multiple users attempt to purchase the same product simultaneously, explicit row-level locking was applied:
```sql
SELECT product_id, stock_quantity 
FROM products 
WHERE product_id = 104 
FOR UPDATE;