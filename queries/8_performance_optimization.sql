--- Write a query to find the total quantity and average unit_price for each item_description, but only include items with more than 10,000 total quantities sold. Optimize the query to handle large datasets efficiently.

WITH item_summary AS (
    SELECT
        item_description,
        SUM(quantity) AS total_quantity,
        AVG(unit_price) AS avg_unit_price
    FROM
        online_orders
    GROUP BY
        item_description
    HAVING
        SUM(quantity) > 10000
)
SELECT
    *
    FROM
        item_summary
    ORDER BY
        total_quantity DESC;

