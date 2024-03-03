/*
https://datalemur.com/questions/signup-confirmation-rate

New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts.
Users may receive multiple text messages for account confirmation until they have confirmed their new account.

A senior analyst is interested to know the activation rate of specified users in the emails table. 
Write a query to find the activation rate. Round the percentage to 2 decimal places.

emails Table:
+-------------+--------------+
| Column Name | Type         |
+-------------+--------------+
| email_id    | integer      |
| user_id     | integer      |
| signup_date | datetime     |
+-------------+--------------+

texts Table:
+---------------+--------------+
| Column Name   | Type         |
+---------------+--------------+
| text_id       | integer      |
| email_id      | integer      |
| signup_action | varchar      |
+---------------+--------------+

emails Example Input:
+----------+---------+---------------------+
| email_id | user_id | signup_date         |
+----------+---------+---------------------+
| 125      | 7771    | 06/14/2022 00:00:00 |
| 236      | 6950    | 07/01/2022 00:00:00 |
| 433      | 1052    | 07/09/2022 00:00:00 |
+----------+---------+---------------------+

texts Example Input:
+----------+----------+---------------+
| text_id  | email_id | signup_action |
+----------+----------+---------------+
| 6878     | 125      | Confirmed     |
| 6920     | 236      | Not Confirmed |
| 6994     | 236      | Confirmed     |
+----------+----------+---------------+

Example Output:

+--------------+
| confirm_rate | 
+--------------+
| 0.67         |
+--------------+

67% of users have successfully completed their signup and activated their accounts. 
The remaining 33% have not yet replied to the text to confirm their signup.
*/
SELECT 
ROUND(AVG(
  CASE 
    WHEN texts.signup_action = 'Confirmed' THEN 1
    ELSE 0
  END), 2)
FROM texts
LEFT JOIN emails
ON texts.email_id = emails.email_id;

