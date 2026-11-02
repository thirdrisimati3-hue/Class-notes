CREATE CATALOG IF NOT EXISTS shop;

USE CATALOG shop;


CREATE SCHEMA IF NOT EXISTS fruits;

CREATE OR REPLACE TABLE shop.fruits.sales (
    month STRING,
    sales INT
); 

INSERT INTO shop.fruits.sales
    VALUES 
        ('01. Jan', 200),
        ('02. Feb', 350),
        ('03. Mar', 734),
        ('04. Apr', 849),
        ('05. May', 1000);

SELECT *
FROM shop.fruits.sales;

-- LAG() function: it help us to look back

-- DROP TABLE shop.fruits.sales;


SELECT 
    month,
    sales AS current_month,
    LAG(sales) OVER (
       -- PARTITION BY month 
        ORDER BY month ASC
    ) as previous_sales
FROM shop.fruits.sales;

-- LEAD() function it looks ahead

SELECT 
    month,
    sales AS current_month,
    LEAD(sales) OVER (
       -- PARTITION BY month 
        ORDER BY month ASC
    ) as next_sales
FROM shop.fruits.sales;

------------------------------------------

CREATE OR REPLACE TABLE shop.fruits.orders (
    month STRING,
    sales INT,
    location STRING
); 

INSERT INTO shop.fruits.orders
    VALUES 
        ('01. Jan', 200, 'a'),
        ('02. Feb', 350, 'a'),
        ('03. Mar', 734, 'a'),
        ('04. Apr', 849, 'b'),
        ('05. May', 1000, 'b');

SELECT 
    month,
    location,
    sales AS current_month,
    LEAD(sales) OVER (
        PARTITION BY location 
        ORDER BY month ASC
    ) as next_sales
FROM shop.fruits.orders;

---- Class Project 
SELECT *
FROM retail.sales.retail_sales_dataset
LIMIT 100;

CREATE OR REPLACE TEMPORARY TABLE customers AS (

    SELECT `Customer ID` AS customer_id,
            Gender,
            Age
FROM retail.sales.retail_sales_dataset
);

-------------------------------------------------------
SELECT *
FROM customers

CREATE OR REPLACE TEMPORARY TABLE sales AS (

    SELECT `Transaction ID` AS trans_id,
        Date AS trans_dt,
        `Product Category` AS category,
            Quantity,
            `Total Amount` AS revenue
FROM retail.sales.retail_sales_dataset
);

SELECT *
FROM sales
--------------------------------------------------------------

WITH 
customers AS (
    SELECT Customer ID AS customer_id,
            Gender,
            Age
    FROM workspace.default.retail_sales_dataset
    WHERE gender='Male'
),
sales AS (
    SELECT Transaction ID AS trans_id,
            Date AS trans_dt,
            Product Category AS product_category,
            quantity,
            Total Amount AS revenue
    FROM workspace.default.retail_sales_dataset
    WHERE Total Amount>100
)
SELECT*
FROM sales;
