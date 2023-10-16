with products_in_orders as (
    select
        order_id,
        count(product_id) as num_products_in_order
    from {{ ref('stg_postgres__order_items') }}
    group by 1
)

select
    orders.order_id,
    orders.user_id,
    orders.promo_id,
    orders.address_id,
    addresses.country,
    addresses.state,
    orders.created_at,
    orders.order_cost,
    orders.shipping_cost,
    orders.order_total,
    orders.tracking_id,
    orders.shipping_service,
    orders.estimated_delivery_at,
    orders.delivered_at,
    orders.status,
    orders_products.num_products_in_order
from {{ ref('stg_postgres__orders') }} orders
left join {{ ref('stg_postgres__addresses') }} addresses
    on addresses.address_id = orders.address_id
left join products_in_orders orders_products 
    on orders_products.order_id = orders.order_id