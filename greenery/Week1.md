# Week1 Project

### 1. Total Number of Users
#### How many users do we have?
We have a total of 130 users.
```sql
SELECT COUNT(DISTINCT user_id) as total_users
FROM STG_POSTGRES__USERS;
```

### 2. Average Orders Per Hour
#### On average, how many orders do we receive per hour?
We receive 7.5 orders per hour on average
```sql
SELECT AVG(order_count) as avg_orders_per_hour
FROM (
    SELECT DATE_TRUNC('hour', created_at) as order_hour, COUNT(order_id) as order_count
    FROM STG_POSTGRES__ORDERS
    GROUP BY order_hour
);
```

### 3. Average Order Delivery Time
#### On average, how long does an order take from being placed to being delivered?
It takes around 93.4 hours to deliver an order.
```sql
SELECT AVG(DATEDIFF('hour', created_at, delivered_at)) as avg_delivery_time_hours
FROM STG_POSTGRES__ORDERS
WHERE status = 'delivered';
```

### 4. User Purchase Frequency
#### How many users have only made one purchase? Two purchases? Three+ purchases?
We have:
- 25 Users with 1 purchase
- 28 Users with 2 purchases
- 71 Users with 3 or more purchases
```sql
WITH purchase_counts AS (
    SELECT user_id, COUNT(order_id) as purchase_count
    FROM STG_POSTGRES__ORDERS
    GROUP BY user_id
)
SELECT 
    SUM(CASE WHEN purchase_count = 1 THEN 1 ELSE 0 END) as one_purchase_users,
    SUM(CASE WHEN purchase_count = 2 THEN 1 ELSE 0 END) as two_purchase_users,
    SUM(CASE WHEN purchase_count >= 3 THEN 1 ELSE 0 END) as three_plus_purchase_users
FROM purchase_counts;
```

### 5. Average Unique Sessions Per Hour
#### On average, how many unique sessions do we have per hour?
We have around 16.3 sessions per hour
```sql
WITH hourly_sessions AS (
    SELECT DATE_TRUNC('hour', created_at) as session_hour, COUNT(DISTINCT session_id) as session_count
    FROM STG_POSTGRES__EVENTS
    GROUP BY session_hour
)
SELECT AVG(session_count) as avg_sessions_per_hour
FROM hourly_sessions;
```