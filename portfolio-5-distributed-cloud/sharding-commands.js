// ==========================================
// Portfolio 5: Sharding & Distributed Architecture Script
// Project: Fashion Passion E-Commerce
// ==========================================

// 1. Database & Collection Setup
use fashion_passion;

// Insert sample product document
db.products.insertOne({
  product_id: "FP-SHIRT-8891",
  name: "Summer Floral Silk Dress",
  category: "Apparel",
  price: 120,
  sizes_available: ["S", "M", "L"]
});

// Insert matching inventory document
db.inventory.insertOne({
  product_id: "FP-SHIRT-8891",
  stock_count: 45,
  warehouse_location: "Region-East-Warehouse"
});

// 2. Enterprise Sharding Initialization (Production Syntax)
// Enable sharding on the database
sh.enableSharding("fashion_passion");

// Apply hashed sharding strategy on 'product_id' to ensure uniform data distribution
sh.shardCollection("fashion_passion.products", { "product_id": "hashed" });
sh.shardCollection("fashion_passion.inventory", { "product_id": "hashed" });

// 3. Cluster Status & Chunk Distribution Verification
// Verify sharding configuration and balancer status across shards
db.printShardingStatus();
