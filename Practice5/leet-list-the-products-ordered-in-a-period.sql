/*
https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/?envType=study-plan-v2&envId=top-sql-50

Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

Table: Products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key (column with unique values) for this table.
This table contains data about the company's products.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
This table may have duplicate rows.
product_id is a foreign key (reference column) to the Products table.
unit is the number of products ordered in order_date.

*/
# Write your MySQL query statement below
SELECT Products.product_name, SUM(Orders.unit) AS unit FROM Products
JOIN Orders 
ON Orders.product_id = Products.product_id 
WHERE EXTRACT(month FROM order_date) = 2 AND  EXTRACT(year FROM order_date) = 2020
GROUP BY Orders.product_id
HAVING SUM(Orders.unit) >= 100;


