/*
https://datalemur.com/questions/tesla-unfinished-parts

Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.
Output all details related to retrieved records.

Table: lyft_drivers

+---------------+----------+
| Column Name   | Type     |
+---------------+----------+
| index         | integer  |
| start_date    | datetime |
| end_date      | datetime |
| yearly_salary | integer  |
+---------------+----------+
*/
SELECT * FROM lyft_drivers
WHERE yearly_salary <= 30000 OR yearly_salary >= 70000;
