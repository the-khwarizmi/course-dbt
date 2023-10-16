# Week3 Project

### 1. Overall Conversion Rate
#### What is our overall conversion rate?
We have a rate of %62.46
```sql
SELECT 
    COUNT(DISTINCT CASE WHEN checkouts > 0 then session_id END) / COUNT(DISTINCT session_id) AS conversion_rate
FROM fct_page_views;
```

### 2. Conversion Rate By Product
#### What is our conversion rate by product?
| PRODUCT_ID | PRODUCT_NAME | CONVERSION_RATE |
|  --- | --- | --- |
| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 | String of pearls | 0.609375 |
| 74aeb414-e3dd-4e8a-beef-0fa45225214d | Arrow Head | 0.555556 |
| 5b50b820-1d0a-4231-9422-75e7f6b0cecf | Pilea Peperomioides | 0.474576 |
| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 | Philodendron | 0.483871 |
| 579f4cd0-1f45-49d2-af55-9ab2b72c3b35 | Rubber Plant | 0.518519 |
| a88a23ef-679c-4743-b151-dc7722040d8c | Jade Plant | 0.478261 |
| c7050c3b-a898-424d-8d98-ab0aaad7bef4 | Orchid | 0.453333 |
| 615695d3-8ffd-4850-bcf7-944cf6d3685b | Aloe Vera | 0.492308 |
| 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d | Bird of Paradise | 0.45 |
| 58b575f2-2192-4a53-9d21-df9a0c14fc25 | Angel Wings Begonia | 0.393443 |
| bb19d194-e1bd-4358-819e-cd1f1b401c0c | Birds Nest Fern | 0.423077 |
| 80eda933-749d-4fc6-91d5-613d29eb126f | Pink Anthurium | 0.418919 |
| c17e63f7-0d28-4a95-8248-b01ea354840e | Cactus | 0.545455 |
| e8b6528e-a830-4d03-a027-473b411c7f02 | Snake Plant | 0.39726 |
| 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af | Alocasia Polly | 0.411765 |
| e2e78dfc-f25c-4fec-a002-8e280d61a2f2 | Boston Fern | 0.412698 |
| 5ceddd13-cf00-481f-9285-8340ab95d06d | Majesty Palm | 0.492537 |
| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 | Pothos | 0.344262 |
| 35550082-a52d-4301-8f06-05b30f6f3616 | Devil's Ivy | 0.488889 |
| e18f33a6-b89a-4fbc-82ad-ccba5bb261cc | Ponytail Palm | 0.4 |
| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 | ZZ Plant | 0.539683 |
| 843b6553-dc6a-4fc4-bceb-02cd39af0168 | Ficus | 0.426471 |
| be49171b-9f72-4fc9-bf7a-9a52e259836b | Monstera | 0.510204 |
| 689fb64e-a4a2-45c5-b9f2-480c2155624d | Bamboo | 0.537313 |
| 64d39754-03e4-4fa0-b1ea-5f4293315f67 | Spider Plant | 0.474576 |
| d3e228db-8ca5-42ad-bb0a-2148e876cc59 | Money Tree | 0.464286 |
| e5ee99b6-519f-4218-8b41-62f48f59f700 | Peace Lily | 0.409091 |
| 37e0062f-bd15-4c3e-b272-558a86d90598 | Dragon Tree | 0.467742 |
| e706ab70-b396-4d30-a6b2-a1ccf3625b52 | Fiddle Leaf Fig | 0.5 |
| b86ae24b-6f59-47e8-8adc-b17d88cbd367 | Calathea Makoyana | 0.509434 |
```sql
SELECT 
    products.product_id,
    products.name,
    COUNT(DISTINCT CASE WHEN checkouts > 0 then session_id END) / COUNT(DISTINCT session_id) AS conversion_rate
FROM fct_page_views
LEFT JOIN dim_products AS products ON products.product_id = fct_page_views.product_id
GROUP BY 1,2;
```