{{ config(
    materialized='table',
    schema='analytics_marts',
    enabled=(target.name == 'production')
) }}

select
    r.order_id,
    r.customer_id,
    r.order_date,
    r.order_revenue
from {{ ref('int_order_revenue') }} r
