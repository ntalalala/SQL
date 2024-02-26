/*
https://datalemur.com/questions/alibaba-compressed-mean

You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information 
on the count of items in each order (item_count table) and the corresponding number of orders for each item count (order_occurrences table).

items_per_order table:
+---------------------+--------------+
| Column Name         | Type         |
+---------------------+--------------+
| item_count          | integer      |
| order_occurrences   | integer      |
+---------------------+--------------+

Input:
+-------------+-------------------+
| item_count  | order_occurrences |
+-------------+-------------------+
| 1           | 500               |
| 2           | 1000              |
| 3           | 800               |
| 4           | 1000              |
+-------------+-------------------+

Output:
+-------+
| mean  |
+-------+
| 2.7   |
+-------+

Explanation
Let's calculate the arithmetic average:
Total items = (1*500) + (2*1000) + (3*800) + (4*1000) = 8900
Total orders = 500 + 1000 + 800 + 1000 = 3300
Mean = 8900 / 3300 = 2.7
*/

SELECT ROUND((SUM(item_count * order_occurrences) :: numeric)/ SUM(order_occurrences), 1)  AS mean FROM items_per_order;
/*
SELECT ROUND(SUM(item_count * order_occurrences)/ SUM(order_occurrences), 1)  AS mean FROM items_per_order;
sẽ gây ra lỗi ERROR: function round(double precision, integer) does not exist
-> Sửa dùng CAST: SELECT ROUND(CAST(longitude AS numeric),2) FROM my_points; 
hoặc SELECT ROUND(value::numeric, 2) FROM table_x; 
