select
    o.order_id,
    o.customer_id,
    o.order_date,
    sum(oi.line_total) as order_revenue
from {{ ref('stg_orders') }} o
join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
group by o.order_id, o.customer_id, o.order_date