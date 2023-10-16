# Week2 Project

### 1. User Repeat Rate
#### What is our user repeat rate? Repeat Rate = Users who purchased 2 or more times / users who purchased
We have a rate of 0.798.
```sql
SELECT
    CAST(SUM(CASE WHEN is_frequent_buyer THEN 1 ELSE 0 END) AS FLOAT) /
    NULLIF(SUM(CASE WHEN is_buyer THEN 1 ELSE 0 END), 0) AS repeat_rate
FROM
    fct_user_orders;
```

