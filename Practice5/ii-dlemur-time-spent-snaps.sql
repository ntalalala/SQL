/*
https://datalemur.com/questions/time-spent-snaps

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. 
Round the percentage to 2 decimal places in the output.

Calculate the following percentages:
time spent sending / (Time spent sending + Time spent opening)
Time spent opening / (Time spent sending + Time spent opening)

To avoid integer division in percentages, multiply by 100.0 and not 100.

activities Table:
+----------------+--------------------------------+
| Column Name    | Type                           |
+----------------+--------------------------------+
| activity_id    | integer                        |
| user_id        | integer                        |
| actitvity_type | string('send', 'open', 'chat') |
| time_spent     | float                          |
| activity_date  | datetime                       |
+----------------+--------------------------------+

age_breakdown Table:
+---------------+-----------------------------------+
| Column Name   | Type                              |
+---------------+-----------------------------------+
| user_id       | integer                           |
| age_bucket    | string('21-25', '26-30', '31-35') |
+---------------+-----------------------------------+

activities Example Input:
+-------------+---------+---------------+------------+---------------------+
| activity_id | user_id | activity_type | time_spent | activity_date       |
+-------------+---------+---------------+------------+---------------------+
| 7274        | 123     | open          | 4.50       | 06/22/2022 12:00:00 |
| 2425        | 123     | send          | 3.50       | 06/22/2022 12:00:00 |
| 1413        | 456     | send          | 5.67       | 06/23/2022 12:00:00 |
| 1414        | 789     | chat          | 11.00      | 06/25/2022 12:00:00 |
| 2536        | 456     | open          | 3.00       | 06/25/2022 12:00:00 | |
+-------------+---------+---------------+------------+---------------------+

age_breakdown Example Input:
+----------+------------+
| user_id  | age_bucket | 
+----------+------------+
| 123      | 31-35      | 
| 456      | 26-30      | 
| 789      | 21-25      | 
+----------+------------+

Example Output:

+-------------+-----------+-----------+
| age_bucket  | send_perc | open_perc |
+-------------+-----------+-----------+
| 26-30       | 65.40     | 34.60     |
| 31-35       | 43.75     | 56.25     |
+-------------+-----------+-----------+

*/
SELECT age_breakdown.age_bucket,
ROUND(
  SUM(CASE WHEN activities.activity_type = 'send' THEN activities.time_spent ELSE 0 END) * 100.0/
  SUM(activities.time_spent), 2
) AS send_perc,
ROUND(
  SUM(CASE WHEN activities.activity_type = 'open' THEN activities.time_spent ELSE 0 END) * 100.0/
  SUM(activities.time_spent), 2
) AS open_perc
FROM activities
JOIN age_breakdown
ON activities.user_id = age_breakdown.user_id
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age_breakdown.age_bucket;


