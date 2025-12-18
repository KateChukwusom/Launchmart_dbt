select
    c.customer_id,
    c.full_name,
    c.email,
    c.customer_join_date,

    coalesce(b.total_orders, 0) as total_orders,
    coalesce(b.total_items_purchased, 0) as total_items_purchased,
    b.first_order_date,
    b.most_recent_order_date,

    coalesce(l.total_points_earned, 0) as total_loyalty_points,
    coalesce(l.promo_points, 0) as promo_points,
    coalesce(l.standard_points, 0) as standard_points
from {{ ref('stg_customers') }} c
left join {{ ref('int_customer_behavior') }} b
    on c.customer_id = b.customer_id
left join {{ ref('int_loyalty_engagement') }} l
    on c.customer_id = l.customer_id
