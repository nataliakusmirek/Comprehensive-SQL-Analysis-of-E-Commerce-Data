--- Write a query that joins the cleaned orders with the rest of the data information from the customers table. Use the cleaned_invoices CTE from the previous exercise.

WITH cleaned_invoices AS
    (
    SELECT
        order_id,
        unit_price,
        country,
        quantity
    FROM
        online_orders
    WHERE
        unit_price > 0 
        AND country = 'United Kingdom'
        AND quantity > 0
    )
SELECT
    cleaned_invoices.*,
    online_orders.order_id,
    online_orders.unit_price,
    online_orders.country,
    online_orders.quantity
FROM
    cleaned_invoices
JOIN online_orders
    ON cleaned_invoices.order_id = online_orders.order_id
    AND cleaned_invoices.unit_price = online_orders.unit_price
    AND cleaned_invoices.quantity = online_orders.quantity
    AND cleaned_invoices.country = online_orders.country;