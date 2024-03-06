/*
https://datalemur.com/questions/duplicate-job-listings

Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition:

Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.

job_listings Table:
+-------------+--------------+
| Column Name | Type         |
+-------------+--------------+
| job_id      | integer      |
| company_id  | integer      |
| title       | string       |
| description | string       |
+-------------+--------------+

job_listings Example Input:
+----------+------------+------------------+--------------+
| job_id   | company_id | title            | description  |
+----------+------------+------------------+--------------+
| 248      | 827        | Business Analyst |              |
| 149      | 845        | Business Analyst |              |
| 945      | 345        | Data Analyst     |              |
| 164      | 345        | Data Analyst     |              |
| 172      | 244        | Data Engineer    |              |
+----------+------------+------------------+--------------+

Example Output:
+---------------------+
| duplicate_companies | 
+---------------------+
| 1                   |
+---------------------+

*/
SELECT COUNT(*) AS duplicate_companies FROM
  (SELECT company_id AS so_post FROM job_listings
  GROUP BY company_id, title
  HAVING COUNT(*) > 1) AS new_table;
