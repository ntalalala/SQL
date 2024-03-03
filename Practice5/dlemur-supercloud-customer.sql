/*
https://datalemur.com/questions/supercloud-customer

A Microsoft Azure Supercloud customer is defined as a company that purchases at least one product from each product category.

Write a query that effectively identifies the company ID of such Supercloud customers.

customer_contracts Table:
+-------------+--------------+
| Column Name | Type         |
+-------------+--------------+
| customer_id | integer      |
| product_id  | integer      |
| amount      | integer      |
+-------------+--------------+

products Table:
+------------------+--------------+
| Column Name      | Type         |
+------------------+--------------+
| product_id       | integer      |
| product_category | string       |
| product_name     | string       |
+------------------+--------------+

customer_contracts Example Input:
+-------------+------------+--------+
| customer_id | product_id | amount |
+-------------+------------+--------+
| 1           | 1          | 1000   |
| 1           | 3          | 2000   |
| 1           | 5          | 1500   |
| 2           | 2          | 3000   |
| 2           | 6          | 2000   |
+-------------+------------+--------+

products Example Input:
+------------+------------------+--------------------------+
| product_id | product_category | product_name             |
+------------+------------------+--------------------------+
| 1          | Analytics        | Azure Databricks         | 
| 2          | Analytics        | Azure Stream Analytics   |
| 4          | Containers       | Azure Kubernetes Service |
| 5          | Containers       | Azure Service Fabric     |
| 6          | Compute          | Virtual Machines         |
| 7          | Compute          | Azure Functions          |
+------------+------------------+--------------------------+

Example Output:

+-------------+
| customer_id | 
+-------------+
| 1           |
+-------------+

Customer 1 bought from Analytics, Containers, and Compute categories of Azure, and thus is a Supercloud customer. 
Customer 2 isn't a Supercloud customer, since they don't buy any container services from Azure.
*/
SELECT a.customer_id
FROM customer_contracts AS a   
JOIN products AS b  
ON a.product_id = b.product_id
GROUP BY a.customer_id
HAVING COUNT(DISTINCT b.product_category) = (SELECT COUNT(DISTINCT product_category) FROM products);

