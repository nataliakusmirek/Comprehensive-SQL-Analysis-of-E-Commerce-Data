--- Create a query using WITH to define common table expressions (CTEs) for cleaning the orders and customers tables. Use these CTEs to select the cleaned data with appropriate column names using AS.

WITH cleaned_invoices AS
    (
    SELECT
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
    *
FROM
    cleaned_invoices;