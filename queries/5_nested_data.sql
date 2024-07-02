--- Write a query to find the top 3 most expensive items in each order_id based on unit_price. Use nested queries to first rank the items within each order_id and then filter to get the top 3 items.
WITH ranked_prices AS (
    SELECT
        order_id,
        item_description,
        unit_price
        RANK() OVER (
            PARTITION BY order_id
            ORDER BY unit_price DESC
        ) AS price_rank
        FROM
            online_orders
    )
    SELECT
        order_id,
        item_description,
        unit_price
    FROM
        ranked_prices
    WHERE
        price_rank <= 3;












WITH ranked_prices AS (
    SELECT
        order_id,
        item_description,
        unit_price,
        RANK() OVER (
            PARTITION BY order_id
            ORDER BY unit_price DESC
        ) AS price_rank
    FROM
        online_orders
)