# Portfolio 5: Distributed and Cloud Database Exercise
## Project Case Study: Fashion Passion E-Commerce

---

### Step 1: Distributed Architecture Topology
* **Platform:** MongoDB Atlas (Cloud-Managed Database Service).
* **Cluster Deployment:** Deployed as a 3-node replica set on MongoDB Atlas (AWS-backed) under the **Fashion Passion E-Commerce** project space (`Cluster0`).
* **Availability & Replication:** Configured with automated failover and continuous primary-to-secondary data replication for high availability.
* **Evidence:** Live cloud environment verified via MongoDB Atlas Dashboard showing active cluster metrics and organization workspace settings (`Alero's Org`).

---

### Step 2: Sharding Plan & Shard Key Selection
* **Architecture Strategy:** Designed for horizontal scaling (sharding) to support high-throughput e-commerce operations, handling massive concurrent catalog views and peak flash-sale transactions.
* **Shard Key Selection:** `{"product_id": "hashed"}` applied across both the `products` and `inventory` collections.
* **Rationale:** Applying a hashed index on `product_id` guarantees uniform data distribution across all distributed shard nodes, preventing write/read hot-spotting on popular inventory items.

---

### Step 3: Sharding Implementation & Request Routing

#### A. Database & Collection Setup Commands
```javascript
// Switch to project database
use fashion_passion

// Insert initial product document
db.products.insertOne({
  product_id: "FP-SHIRT-8891",
  name: "Summer Floral Silk Dress",
  category: "Apparel",
  price: 120,
  sizes_available: ["S", "M", "L"]
})

// Insert matching inventory document
db.inventory.insertOne({
  product_id: "FP-SHIRT-8891",
  stock_count: 45,
  warehouse_location: "Region-East-Warehouse"
})

```

#### B. Sharding Configuration Commands

```javascript
// Enable sharding at the database level
sh.enableSharding("fashion_passion");

// Shard the collections using a hashed shard key strategy
sh.shardCollection("fashion_passion.products", { "product_id": "hashed" });
sh.shardCollection("fashion_passion.inventory", { "product_id": "hashed" });

```

#### C. Backend Request Routing & Read Preference Code

```javascript
// MongoDB Atlas Backend Connection Driver Configuration (Node.js/Python Context)
const uri = "mongodb+srv://admin:<password>@cluster0.mongodb.net/fashion_passion?retryWrites=true&w=majority";

// Route catalog read traffic to secondaries while isolating checkout writes to primary
const client = new MongoClient(uri, { 
  readPreference: "secondaryPreferred",
  w: "majority"
});

```

---

### Step 4: CAP Theorem, Cloud Analysis, & Final Evidence

* **CAP Theorem Analysis:** MongoDB Atlas operates as a **CP (Consistency and Partition Tolerance)** system by default for critical write transactions (`w: "majority"`). For *Fashion Passion E-Commerce*, this guarantees strict consistency during order processing and stock deduction. High **Availability (AP)** is achieved for read operations by routing browsing traffic to secondary replica nodes (`secondaryPreferred`).
* **Tier Operational Note:** Live cloud verification was conducted on MongoDB Atlas M0 (Free Tier) replica set infrastructure. Complete enterprise sharding syntax (`mongos` routing) is fully documented for production scaling to M10+ tiers.
* **Database Schema Evidence:**
* **Database Name:** `fashion_passion`
* **Collections:** `products` (item metadata and pricing) and `inventory` (warehouse stock counts).
* **Relational Field:** Linked via `product_id` identifier (e.g., `"FP-SHIRT-8891"`).



```

```