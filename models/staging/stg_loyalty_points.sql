select
    customer_id,
    points_earned,
    transaction_date,
    source as points_source
from {{ source('raw', 'loyalty_points') }}