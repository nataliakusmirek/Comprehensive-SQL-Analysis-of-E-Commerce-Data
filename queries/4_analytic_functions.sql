--- Write a query that calculates the running total of the unit_price for each order_id. Use a window function to compute the cumulative sum of unit_price up to and including the current row, ordered by order_id.

WITH order_prices AS (
    SELECT
        order_id,
        unit_price
    FROM
        online_orders
)
SELECT
    order_id,
    unit_price,
    SUM(unit_price) OVER (
        PARTITION BY order_id
        ORDER BY unit_price
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM
    order_prices;