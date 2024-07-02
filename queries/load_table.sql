--- Create table with data: InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country

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

-- Load data from csv file (I used PostGreSQL Admin to do so, but you can use the following command in the terminal (replace with your path!))
copy public.online_orders (order_id, stock_code, item_description, quantity, order_date, unit_price, customer_id, country) FROM '/Users/taliak/Desktop/online_orders.csv' DELIMITER ',' CSV HEADER;