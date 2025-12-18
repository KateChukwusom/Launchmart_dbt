select
    o.customer_id,
    count(distinct o.order_id) as total_orders,
    sum(oi.quantity) as total_items_purchased,
    min(o.order_date) as first_order_date,
    max(o.order_date) as most_recent_order_date
from {{ ref('stg_orders') }} o
left join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
group by o.customer_id