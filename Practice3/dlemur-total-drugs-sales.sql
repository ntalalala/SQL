/*
https://datalemur.com/questions/total-drugs-sales

Write a query to calculate the total drug sales for each manufacturer. 
Round the answer to the nearest million and report your results in descending order of total sales. 
In case of any duplicates, sort them alphabetically by the manufacturer name.

Since this data will be displayed on a dashboard viewed by business stakeholders, 
please format your results as follows: "$36 million".

pharmacy_sales Table:

+--------------+--------------+
| Column Name  | Type         |
+--------------+--------------+
| product_id   | integer      |
| units_sold   | integer      |
| total_sales  | decimal      |
| cogs         | decimal      |
| manufacturer | varchar      |
| drug         | varchar      |
+--------------+--------------+

Example Output:
manufacturer	sale
Biogen	$4 million
Eli Lilly	$3 million

*/
SELECT manufacturer,
CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS sales_mil 
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;
