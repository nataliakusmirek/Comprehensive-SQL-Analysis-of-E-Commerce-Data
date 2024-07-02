--- Write a query that categorizes unit_price into three categories: 'Low' (unit_price <= 3), 'Medium' (unit_price > 3 and <= 5), and 'High' (unit_price > 5). Include these categories in your output along with the order_id and item_description.

WITH price_categories AS (
    SELECT
        order_id,
        item_description,
        unit_price,
        CASE
            WHEN unit_price <= 3 THEN 'Low'
            WHEN unit_price > 3 AND unit_price <= 5 THEN 'Medium'
            ELSE 'High'
        END AS price_category
    FROM
        online_orders
)
SELECT
    *
FROM
    price_categories
ORDER BY
    order_id;
    