/*
https://leetcode.com/problems/exchange-seats/description/?envType=study-plan-v2&envId=top-sql-50

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.

Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+

*/
SELECT id,
CASE
    WHEN id % 2 = 0 AND lag IS NOT NULL THEN lag
    WHEN id % 2 != 0 AND lead IS NOT NULL THEN lead
    ELSE student
END AS student
FROM (
    SELECT *,
    LEAD(student) OVER (ORDER BY id),
    LAG(student) OVER (ORDER BY id)
    FROM Seat
) AS new1;


