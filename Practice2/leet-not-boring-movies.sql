/*
https://leetcode.com/problems/not-boring-movies/description/?envType=study-plan-v2&envId=top-sql-50

Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".

Return the result table ordered by rating in descending order.

Table: Cinema

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+

id is the primary key (column with unique values) for this table.
Each row contains information about the name of a movie, its genre, and its rating.
rating is a 2 decimal places float in the range [0, 10]
*/

SELECT * FROM Cinema
WHERE id % 2 != 0 AND description != 'boring'
ORDER BY rating DESC;
