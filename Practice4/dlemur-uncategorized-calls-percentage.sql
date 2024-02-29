/*
https://datalemur.com/questions/uncategorized-calls-percentage

Write a query to find the percentage of calls that cannot be categorised. Round your answer to 1 decimal place.
These uncategorised calls are labelled “n/a”, or are just empty

callers Table:

+--------------------+--------------+
| Column Name        | Type         |
+--------------------+--------------+
| policy_holder_id   | integer      |
| case_id            | varchar      |
| call_category      | varchar      |
| call_received      | timestamp    |
| call_duration_secs | integer      |
| original_order     | integer      |
+--------------------+--------------+
*/
SELECT
  ROUND(
    COUNT(
      CASE
        WHEN call_category IS NULL OR call_category = 'n/a' THEN 1
        ELSE 0
      END) * 100.0 / COUNT(case_id), 1) AS call_percentage
FROM callers;

