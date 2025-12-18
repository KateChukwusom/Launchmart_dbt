select
    customer_id,
    full_name,
    email,
    join_date as customer_join_date
from {{ source('raw', 'customers') }}
