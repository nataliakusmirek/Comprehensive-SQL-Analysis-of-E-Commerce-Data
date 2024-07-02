--- Write a query to calculate the total revenue and average quantity for each item_description sold. The total revenue is calculated as the sum of unit_price multiplied by quantity.

WITH item_info AS (
    SELECT
        item_description,
        SUM(unit_price * quantity) AS total_revenue,
        AVG(quantity) AS avg_quantity
    FROM
        online_orders
    GROUP BY
        item_description
)
SELECT
    *
    FROM
        item_info
    ORDER BY
        total_revenue DESC;