# CowJacket dbt Project

## Project Overview

CowJacket is adopting dbt as its transformation tool to standardize data transformations, simplify testing, improve lineage visibility, and make it easier to manage transformation workflows.  

This dbt project uses the provided SQL module data as the source and follows a three-layer modeling approach:

1. **Staging**: Clean and standardize raw source data.
2. **Intermediate**: Aggregate and transform data for business metrics.
3. **Marts**: Business-facing fact and dimension tables for analytics and reporting.

The project is designed to support the loyalty program analytics and revenue analysis for CowJacket, allowing the team to understand customer behavior, revenue performance, and loyalty engagement.

## Project Structure
```
Launchmart_dbt/
│
├── models/
│   │
│   ├── staging/
│   │   ├── stg_customers.sql
│   │   ├── stg_products.sql
│   │   ├── stg_orders.sql
│   │   ├── stg_order_items.sql
│   │   └── stg_loyalty_points.sql
│   │
│   ├── intermediate/
│   │   ├── int_customer_behavior.sql
│   │   ├── int_order_revenue.sql
│   │   ├── int_category_revenue.sql
│   │   └── int_loyalty_engagement.sql
│   │
│   └── marts/
│       ├── dim_customers.sql
│       └── fct_orders.sql
│
├── sources/
│   └── sources.yml
│
├── dbt_project.yml
└── README.md

```

## Environments & Schemas

The project is deployed with **three dbt Cloud environments**:

| Environment | Snowflake Schema | Purpose |
|-------------|-----------------|---------|
| Development | `dbt_dev`       | Personal development, automatically created by dbt Cloud IDE. Safe for testing and experimentation. |
| CI (Staging) | `dbt_ci`        | Pull request validation. Automatically triggered for every PR to validate models and tests without affecting dev or prod. |
| Production  | `analytics` / `analytics_marts` | Final production tables. Marts are isolated in `analytics_marts` to prevent accidental writes from dev/CI. |
'
---

## Modeling Layers

### 1. Staging 
- Cleans and standardizes raw source tables: `customers`, `products`, `orders`, `order_items`, `loyalty_points`.
- All staging models are materialized as **views**.
- Includes generic tests like `not_null`, `unique`, and relationships to ensure data quality.

### 2. Intermediate 
- Aggregates metrics for:
  - **Customer behavior**: total orders, first/most recent orders, total items purchased.
  - **Revenue**: order revenue, category-level revenue.
  - **Loyalty engagement**: total points, promotional points.
- All intermediate models are materialized as **views**.
- Includes both **generic** and **custom business tests**.

### 3. Marts
- Production-facing **fact and dimension tables** for reporting:
  - `dim_customers`
  - `fct_orders`
- Materialized as **tables** in `analytics_marts` schema.
- **Guardrail**: Marts only materialize in **production** environment to prevent accidental builds in dev/CI.
- Includes tests for revenue validation and loyalty points constraints.

---
## Sources & Seeds

- **Sources** (`sources.yml`) define raw tables for lineage and testing..
- All columns are fully documented for clarity and maintainability.

---

## Testing
- **Generic tests**:
  - `not_null`
  - `unique`
  - `relationships`
- **Custom business tests**:
  - `revenue_not_negative`: ensures no negative revenue in orders
  - `loyalty_points_positive`: ensures loyalty points are never negative
  - `promo_points_not_exceed_total`: ensures promotional points do not exceed total points

- CI environment automatically runs all tests on **every pull request**.

---
## Materializations & Guardrails

- Staging & intermediate: **views**
- Marts: **tables**
- Guardrail implemented in `dbt_project.yml` ensures:
  ```yaml

  +enabled: "{{ target.name == 'production' }}"

