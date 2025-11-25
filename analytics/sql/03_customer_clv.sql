-- 03_customer_clv.sql
-- Business: Customer Lifetime Value with full segmentation

CREATE OR REPLACE VIEW `gulf-retail-30days.gulf_retail.customer_clv_view` AS
WITH customer_orders AS (
  SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    o.order_date,
    ol.qty,
    ol.net_line_amount
  FROM `gulf-retail-30days.gulf_retail.customers` c
  INNER JOIN `gulf-retail-30days.gulf_retail.orders` o ON c.customer_id = o.customer_id
  INNER JOIN `gulf-retail-30days.gulf_retail.order_lines` ol ON o.order_id = ol.order_id
),
customer_metrics AS (
  SELECT
    customer_id,
    first_name,

    COUNT(DISTINCT order_id) AS lifetime_orders,
    SUM(net_line_amount) AS lifetime_net_revenue,
    SUM(qty) AS lifetime_items,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATE_DIFF(MAX(order_date), MIN(order_date), DAY) + 1 AS days_between,
    SAFE_DIVIDE(SUM(net_line_amount), COUNT(DISTINCT order_id)) AS avg_order_value
  FROM customer_orders
  GROUP BY customer_id, first_name
)
SELECT
  *,
  -- Primary ranking by lifetime value
  ROW_NUMBER() OVER (ORDER BY lifetime_net_revenue DESC) AS clv_rank,
  
  -- Customer segmentation tiers
  CASE 
    WHEN lifetime_net_revenue >= 5000 THEN 'Platinum'
    WHEN lifetime_net_revenue >= 2000 THEN 'Gold' 
    WHEN lifetime_net_revenue >= 1000 THEN 'Silver'
    ELSE 'Bronze'
  END AS customer_tier,
  
  -- Purchase frequency analysis
  CASE 
    WHEN lifetime_orders >= 10 THEN 'Frequent'
    WHEN lifetime_orders >= 5 THEN 'Regular'
    ELSE 'Occasional'
  END AS frequency_segment,
  
  -- Recency analysis (days since last order)
  DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) AS days_since_last_order,
  
  -- Customer health score
  CASE 
    WHEN DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) <= 30 AND lifetime_net_revenue >= 2000 THEN 'Active High-Value'
    WHEN DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) <= 30 THEN 'Active Regular'
    WHEN DATE_DIFF(CURRENT_DATE(), last_order_date, DAY) <= 90 THEN 'At Risk'
    ELSE 'Dormant'
  END AS customer_health
  
FROM customer_metrics;