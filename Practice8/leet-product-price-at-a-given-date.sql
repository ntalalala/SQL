/*
https://leetcode.com/problems/product-price-at-a-given-date/description/?envType=study-plan-v2&envId=top-sql-50

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+

*/

SELECT DISTINCT a.product_id, 
CASE
    WHEN b.price IS NULL THEN 10
    ELSE b.price
END AS price
FROM Products AS a
LEFT JOIN (
    SELECT *,
    FIRST_VALUE(new_price) OVER(PARTITION BY product_id ORDER BY change_date DESC) AS price FROM Products 
    WHERE change_date <= '2019-08-16'
) AS b
ON a.product_id = b.product_id;

