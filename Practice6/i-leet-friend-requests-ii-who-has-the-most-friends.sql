/*
https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/?envType=study-plan-v2&envId=top-sql-50

Write a solution to find the people who have the most friends and the most friends number.
The test cases are generated so that only one person has the most friends.

Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.

Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+

*/
SELECT id, 
(SELECT SUM(
    CASE
        WHEN requester_id = id OR accepter_id = id THEN 1
        ELSE 0
    END
)
FROM RequestAccepted
) AS num
FROM(
    (SELECT requester_id AS id FROM RequestAccepted)
    UNION (SELECT accepter_id FROM RequestAccepted)
    ) AS new_table
ORDER BY num DESC
LIMIT 1
