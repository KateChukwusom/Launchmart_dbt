select
    p.category,
    sum(oi.line_total) as category_revenue
from {{ ref('stg_order_items') }} oi
join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
group by p.category