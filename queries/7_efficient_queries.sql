--- Write a query to find the average unit_price for each country. Ensure that the query is optimized for performance, especially if the online_orders table is large.
SELECT
    country,
    AVG(unit_price)
    FROM
        online_orders
    GROUP BY
        country
    ORDER BY
        AVG(unit_price) DESC;