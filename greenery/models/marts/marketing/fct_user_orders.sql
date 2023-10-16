with users as (
    select *
    from {{ ref('stg_postgres__users') }}
)
, user_orders as (
    select *
    from {{ ref('int_user_orders') }}
)
, products_purchased as (
    select 
        orders.user_id, 
        count(order_items.product_id) as num_purchased_products
    from {{ ref('stg_postgres__order_items') }} order_items
    left join {{ ref('stg_postgres__orders') }} orders
        on orders.order_id = order_items.order_id
    group by 1

)

select
    users.user_id,
    user_orders.orders is not null as is_buyer,
    coalesce(user_orders.orders, 0) >= 2 as is_frequent_buyer,
    user_orders.first_order_created_at,
    user_orders.last_order_created_at,
    user_orders.orders,
    coalesce(user_orders.total_spend, 0) as total_spend,
    coalesce(products_purchased.num_purchased_products, 0) as products_purchased
from users 
left join user_orders 
    on user_orders.user_id = users.user_id
left join products_purchased
    on products_purchased.user_id = users.user_id