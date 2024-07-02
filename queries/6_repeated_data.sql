-- Write a query to identify any order_id that has duplicate item_description values within the same order. List these order_ids and the duplicated item_description values.

SELECT
    order_id,
    item_description
FROM
    online_orders
    GROUP BY
        order_id,
        item_description
    HAVING
        COUNT(*) > 1;
