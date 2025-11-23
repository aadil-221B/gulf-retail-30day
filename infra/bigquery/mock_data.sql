-- 1. customers
CREATE OR REPLACE TABLE gulf_retail.customers AS
SELECT 101+c AS customer_id,
       ['Ahmed','Fatima','Khalid','Sara','Omar'][OFFSET(MOD(c,5))] first_name,
       ['Dubai','Abu Dhabi','Sharjah','Riyadh','Doha'][OFFSET(MOD(c,5))] city,
       DATE_ADD('2019-01-01', INTERVAL MOD(c,1500) DAY) AS registration_date
FROM UNNEST(GENERATE_ARRAY(1,2000)) c;

-- 2. products
CREATE OR REPLACE TABLE gulf_retail.products AS
SELECT 1001+p AS product_id,
       ['Laptop','Phone','Headset','Tablet','Watch'][OFFSET(MOD(p,5))] product_name,
       CAST([899,599,149,399,299][OFFSET(MOD(p,5))] AS NUMERIC) unit_price,
       ['Electronics','Electronics','Accessories','Electronics','Accessories'][OFFSET(MOD(p,5))] category
FROM UNNEST(GENERATE_ARRAY(1,100)) p;

-- 3. orders
CREATE OR REPLACE TABLE gulf_retail.orders AS
SELECT 10001+o AS order_id,
       101 + MOD(o,2000) AS customer_id,
       DATE_ADD('2023-01-01', INTERVAL MOD(o,365) DAY) AS order_date,
       CAST(5 + RAND()*45 AS NUMERIC) AS discount_pct
FROM UNNEST(GENERATE_ARRAY(1,50000)) o;
-- 4. order_lines
CREATE OR REPLACE TABLE gulf_retail.order_lines AS
WITH expand AS (
    SELECT order_id,
           line
    FROM gulf_retail.orders
    CROSS JOIN UNNEST(GENERATE_ARRAY(0,MOD(order_id,4))) line
)
SELECT e.order_id,
       1001 + MOD(e.order_id + e.line,100)           AS product_id,
       e.line                                         AS line_no,
       CAST(1 + MOD(e.order_id,5) AS INT64)          AS qty,
       CAST(p.unit_price * (1 - o.discount_pct/100) AS NUMERIC) AS net_line_amount
FROM expand e
JOIN gulf_retail.orders o ON o.order_id = e.order_id
JOIN gulf_retail.products p ON p.product_id = 1001 + MOD(e.order_id + e.line,100);
