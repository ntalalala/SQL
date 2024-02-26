/*
https://datalemur.com/questions/sql-average-post-hiatus-1

Given a table of Facebook posts, for each user who posted at least twice in 2021, 
write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. 
Output the user and number of the days between each user's first and last post.

posts table:
+---------------------+--------------+
| Column Name         | Type         |
+---------------------+--------------+
| user_id             | integer      |
| post_id             | integer      |
| post_date           | timestamp    |
| post_content        | text         |
+---------------------+--------------+

Input:
+----------+----------+----------------------+-------------------+
| user_id  | post_id  | post_date            | post_content      |
+----------+----------+----------------------+-------------------+
| 151652   | 599415   | 07/10/2021 12:00:00  | Need a hug        |
| 661093   | 624356   | 07/29/2021 13:00:00  | abc               |
| 004239   | 784254   | 07/04/2021 11:00:00  | xyz               |
| 661093   | 442560   | 07/08/2021 14:00:00  | def               |
| 151652   | 111766   | 07/12/2021 19:00:00  | Need a hug...     |
+----------+----------+----------------------+-------------------+

Output:
+-------------+-------------------+
| user_id     | days_between      |
+-------------+-------------------+
| 151652      | 2                 |
| 661093      | 21                |
+-------------+-------------------+
*/

SELECT user_id,
MAX(DATE(post_date)) - MIN(DATE(post_date)) as days_between
FROM posts
WHERE EXTRACT(YEAR FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(user_id) >= 2

--extract(hour from timestamp '2001-02-16 20:38:40') res: 20
