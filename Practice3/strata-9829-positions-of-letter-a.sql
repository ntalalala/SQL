/*
https://platform.stratascratch.com/coding/9829-positions-of-letter-a?code_type=1

Find the position of the lower case letter 'a' in the first name of the worker 'Amitah'.

Table: worker

+--------------+----------+
| Column Name  | Type     |
+--------------+----------+
| worker_id    | integer  |
| first_name   | varchar  |
| last_name    | varchar  |
| salary       | integer  |
| joining_date | datetime |
| department   | varchar  |
+--------------+----------+
*/
SELECT POSITION('a' IN first_name) FROM worker
WHERE first_name = 'Amitah';
