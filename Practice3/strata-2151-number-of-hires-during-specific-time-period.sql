/*
https://platform.stratascratch.com/coding/2151-number-of-hires-during-specific-time-period?code_type=1

You have been asked to find the number of employees hired between the months of January and July in the year 2022 inclusive.
Your output should contain the number of employees hired in this given time frame.

Table: employees

+--------------+----------+
| Column Name  | Type     |
+--------------+----------+
| id           | integer  |
| first_name   | varchar  |
| last_name    | varchar  |
| last_name    | integer  |
| joining_date | datetime |
| department   | varchar  |
+--------------+----------+
*/
SELECT COUNT(*) FROM employees
WHERE joining_date BETWEEN '2022-01-01' AND '2022-07-31';
