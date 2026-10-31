# Portfolio 4: NoSQL Document Model & Implementation (*Fashion Passion*)

## Overview
This folder contains the NoSQL document model and implementation evidence for the **Fashion Passion** product catalog system. The design demonstrates a flexible, document-oriented schema tailored for e-commerce product attributes and embedded customer reviews.

---

## Files in this Folder
* **`nosql-model.json`**: The pure, valid JSON product catalog document model.
* **`nosql-evidence.png`**: Screenshot showing successful execution and querying of the document within a MongoDB environment (`OneCompiler`).

---

## Database Architecture & Design Rationale
Unlike relational databases that normalize data across multiple tables, this NoSQL document model utilizes **denormalization** to encapsulate related information into a single self-contained document:
* **Dynamic Attributes (`dynamic_attributes`):** Allows varied product specifications (sizes, colors, and materials) to expand flexibly without requiring schema alterations.
* **Embedded Sub-documents (`reviews`):** Stores customer ratings, user IDs, and comments directly inside the product document for high-performance read operations.

---

## Execution & Verification Guide
To test and verify this model in a MongoDB shell or browser-based environment (such as MongoDB Playground or OneCompiler):

1. **Insert Operation:**
   ```javascript
   db.products.insertOne({
     "organisation": "Fashion Passion",
     "document_type": "Product Catalog Model",
     "product_id": "FP-PROD-001",
     "product_name": "Designer Leather Jacket",
     "category": "Apparel",
     "price": 129.99,
     "stock_quantity": 45,
     "dynamic_attributes": {
       "sizes_available": ["S", "M", "L", "XL"],
       "colors": ["Black", "Brown"],
       "material": "100% Genuine Leather"
     },
     "reviews": [
       {
         "user_id": "USER-102",
         "rating": 5,
         "comment": "Exceptional quality and fits perfectly!",
         "date": "2026-10-30"
       }
     ]
   });
   ```
   2. **Query Operation:**
   ```javascript
   db.products.find({ "product_id": "FP-PROD-001" });
   ```
   *(See nosql-evidence.pngfor visual verification of the successful execution output showingacknowledged: true).*