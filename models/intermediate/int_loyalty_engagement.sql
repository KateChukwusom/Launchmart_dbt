select
    customer_id,
    count(*) as loyalty_events,
    sum(points_earned) as total_points_earned,
    sum(case when points_source = 'Promotion' then points_earned else 0 end) as promo_points,
    sum(case when points_source != 'Promotion' then points_earned else 0 end) as standard_points
from {{ ref('stg_loyalty_points') }}
group by customer_id