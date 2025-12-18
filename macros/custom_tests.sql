{% macro test_revenue_not_negative(model, column_name) %}
-- Ensure no revenue is negative in order-level aggregates
select *
from {{ model }}
where {{ column_name }} < 0
{% endmacro %}


{% macro test_loyalty_points_positive(model, column_name) %}
-- Ensure loyalty points are never negative
select *
from {{ model }}
where {{ column_name }} < 0
{% endmacro %}


{% macro test_promo_points_not_exceed_total(model, promo_column, total_column) %}
-- Ensure promotional points never exceed total points earned
select *
from {{ model }}
where {{ promo_column }} > {{ total_column }}
{% endmacro %}


{% macro test_order_quantity_positive(model, column_name) %}
-- Ensure order item quantities are always positive
select *
from {{ model }}
where {{ column_name }} <= 0
{% endmacro %}


{% macro test_category_revenue_not_negative(model, column_name) %}
-- Ensure category-level revenue is never negative
select *
from {{ model }}
where {{ column_name }} < 0
{% endmacro %}


{% macro test_customer_orders_positive(model, column_name) %}
-- Ensure customers have non-negative total orders
select *
from {{ model }}
where {{ column_name }} < 0
{% endmacro %}
