/*
https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class?code_type=1

Make a report showing the number of survivors and non-survivors by passenger class.
Classes are categorized based on the pclass value as:
pclass = 1: first_class
pclass = 2: second_classs
pclass = 3: third_class
Output the number of survivors and non-survivors by each class.

Table: titanic

+-----------------------+----------+
| Column Name           | Type     |
+-----------------------+----------+
| passengerid           | integer  |
| survived              | integer  |
| pclass                | integer  |
| name                  | varchar  |
| sex                   | varchar  |
| age                   | float    |
| sibsp                 | integer  |
| parch                 | integer  |
| ticket                | varchar  |
| fare                  | float    |
| cabin                 | varchar  |
| embarked              | varchar  |
+-----------------------+----------+
*/
SELECT survived,
    SUM(
        CASE
            WHEN pclass = 1 THEN 1
            ELSE 0
        END 
        ) AS first_class,
    SUM(
        CASE
            WHEN pclass = 2 THEN 1
            ELSE 0
        END 
        ) AS second_class,
    SUM(
        CASE
            WHEN pclass = 3 THEN 1
            ELSE 0
        END 
        ) AS third_class
    FROM titanic
    GROUP BY survived;
