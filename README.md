# Comprehensive SQL Analysis of E-Commerce Data

## Overview

This repository contains a series of SQL queries designed to analyze and manipulate e-commerce data. The dataset used for this project is available at [Kaggle - E-Commerce Data](https://www.kaggle.com/datasets/carrie1/ecommerce-data/code). The queries address various data analysis challenges including data cleaning, joining tables, combining datasets, and performing advanced aggregations.

## Table of Contents

1. [Schema Creation and Data Import](#schema-creation-and-data-import)
2. [Data Cleaning](#data-cleaning)
3. [Data Joining](#data-joining)
4. [Combining Datasets](#combining-datasets)
5. [Running Totals](#running-totals)
6. [Top 3 Most Expensive Items](#top-3-most-expensive-items)
7. [Duplicate Items](#duplicate-items)
8. [Average Unit Price by Country](#average-unit-price-by-country)
9. [Item Summary](#item-summary)
10. [Revenue and Quantity Analysis](#revenue-and-quantity-analysis)
11. [Price Categorization](#price-categorization)

## Schema Creation and Data Import

```sql
-- Create table with data
CREATE TABLE online_orders (
    order_id VARCHAR(30),
    stock_code VARCHAR(30),
    item_description VARCHAR(255),
    quantity INT,
    order_date DATE,
    unit_price DECIMAL,
    customer_id INT,
    country VARCHAR(50)
);

-- Load data from CSV file
COPY public.online_orders (order_id, stock_code, item_description, quantity, order_date, unit_price, customer_id, country) 
FROM '/Users/taliak/Desktop/online_orders.csv' DELIMITER ',' CSV HEADER;
```

## Data Cleaning

```sql
-- Create a query using WITH to define common table expressions (CTEs) for cleaning the orders table
WITH cleaned_invoices AS (
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
```

## Data Joining

```sql
-- Write a query that joins the cleaned orders with the rest of the data information from the same table
WITH cleaned_invoices AS (
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
```

## Combining Datasets

```sql
-- Write a query that combines high-value and low-value orders using UNION ALL
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
low_value_orders AS (
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
```

## Running Totals

```sql
-- Write a query that calculates the running total of unit_price for each order_id
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
```

## Top 3 Most Expensive Items

```sql
-- Write a query to find the top 3 most expensive items in each order_id
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
SELECT
    order_id,
    item_description,
    unit_price
FROM
    ranked_prices
WHERE
    price_rank <= 3;
```

## Duplicate Items

```sql
-- Write a query to identify any order_id that has duplicate item_description values within the same order
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
```

## Average Unit Price by Country

```sql
-- Write a query to find the average unit_price for each country
SELECT
    country,
    AVG(unit_price) AS avg_unit_price
FROM
    online_orders
GROUP BY
    country
ORDER BY
    avg_unit_price DESC;
```

## Item Summary

```sql
-- Write a query to find the total quantity and average unit_price for each item_description with more than 10,000 total quantities sold
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
```

## Revenue and Quantity Analysis

```sql
-- Write a query to calculate the total revenue and average quantity for each item_description
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
```

## Price Categorization

```sql
-- Write a query that categorizes unit_price into three categories: 'Low', 'Medium', and 'High'
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
```

## Getting Started

1. **Clone this repository**:
   ```bash
   git clone https://github.com/yourusername/your-repository.git
   ```

2. **Set up PostgreSQL**:
   - Create a PostgreSQL database.
   - Create the `online_orders` table using the provided schema.
   - Load the data from the CSV file into the table.

3. **Execute Queries**:
   - Use a SQL client or PostgreSQL admin tool to run the provided queries.

## Contributing

Feel free to fork this repository and submit pull requests with improvements or additional queries.
