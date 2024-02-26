/*
https://datalemur.com/questions/cards-issued-difference

Write a query that outputs the name of each credit card and the difference in the number of issued cards 
between the month with the highest issuance cards and the lowest issuance. 
Arrange the results based on the largest disparity.

monthly_cards_issued table:
+---------------------+--------------+
| Column Name         | Type         |
+---------------------+--------------+
| issue_month         | integer      |
| issue_year          | integer      |
| card_name           | string       |
| issue_amount        | integer      |
+---------------------+--------------+

Input:
+------------------------+---------------+-------------+------------+
| card_name              | issued_amount | issue_month | issue_year |
+------------------------+---------------+-------------+------------+
| Chase Freedom Flex     | 55000         | 1           | 2021       |
| Chase Freedom Flex     | 60000         | 2           | 2021       |
| Chase Freedom Flex     | 65000         | 3           | 2021       |
| Chase Freedom Flex     | 70000         | 4           | 2021       |
| Chase Sapphire Reserve | 170000        | 1           | 2021       |
| Chase Sapphire Reserve | 175000        | 2           | 2021       |
| Chase Sapphire Reserve | 180000        | 3           | 2021       |
+----------+----------+----------------------+-------------------+

Output:
+------------------------+---------------+
| card_name              | difference    |
+------------------------+---------------+
| Chase Freedom Flex     | 15000         |
| Chase Sapphire Reserve | 10000         |
+------------------------+---------------+

Explanation:
Chase Freedom Flex's best month was 70k cards issued and the worst month was 55k cards, so the difference is 15k cards.
Chase Sapphire Reserve’s best month was 180k cards issued and the worst month was 170k cards, so the difference is 10k cards.
*/

SELECT card_name, MAX(issued_amount) - MIN(issued_amount) as difference 
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC
