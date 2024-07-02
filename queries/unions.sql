--- Write a query that combines high-value and low-value orders into a single result set using UNION ALL. Define high-value orders as those with a unit-price greater than 5 and low-value orders as those with a unit-price of 3 or less.
WITH high_value_orders AS (
    SELECT
        order_id,
        item_description,
        unit_price
    FROM
        online_orders
    WHERE
        unit_price > 5
),
WITH low_value_orders AS (
    SELECT
        order_id,
        item_description,
        unit_price
    FROM
        online_orders
    WHERE
        unit_price <= 3
)
SELECT
    *
FROM
    high_value_orders
UNION ALL
SELECT
    *
FROM
    low_value_orders;