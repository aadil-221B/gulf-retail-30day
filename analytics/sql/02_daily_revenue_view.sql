CREATE OR REPLACE VIEW `gulf-retail-30days.gulf_retail.daily_revenue_view`
AS (
    SELECT
        o.order_date,
        COUNT(DISTINCT o.order_id) AS order_cnt,
        COUNT(DISTINCT o.customer_id) AS customer_cnt,
        ROUND(SUM(ol.qty * p.unit_price), 2) AS gross_revenue,
        ROUND(SUM(ol.qty * p.unit_price) - SUM(ol.net_line_amount), 2)
            AS total_discount,
        ROUND(SUM(ol.net_line_amount), 2) AS net_revenue
    FROM `gulf-retail-30days.gulf_retail.orders` AS o
    INNER JOIN
        `gulf-retail-30days.gulf_retail.order_lines` AS ol
        ON o.order_id = ol.order_id
    INNER JOIN
        `gulf-retail-30days.gulf_retail.products` AS p
        ON ol.product_id = p.product_id
    GROUP BY o.order_date
);
