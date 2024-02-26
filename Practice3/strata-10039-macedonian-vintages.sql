/*
https://platform.stratascratch.com/coding/10039-macedonian-vintages?code_type=1

Find the vintage years of all wines from the country of Macedonia. The year can be found in the 'title' column. 
Output the wine (i.e., the 'title') along with the year. The year should be a numeric or int data type.

Table: winemag_p2

+-----------------------+----------+
| Column Name           | Type     |
+-----------------------+----------+
| id                    | integer  |
| countr                | varchar  |
| description           | varchar  |
| designation           | varchar  |
| points                | integer  |
| price                 | float    |
| province              | varchar  |
| region_1              | varchar  |
| region_2              | varchar  |
| taster_name           | varchar  |
| taster_twitter_handle | varchar  |
| title                 | varchar  |
| variety               | varchar  |
| winery                | varchar  |
+-----------------------+----------+

*/
SELECT title, SUBSTRING(title, POSITION('2' IN title), 4)
FROM winemag_p2
WHERE country = 'Macedonia';
