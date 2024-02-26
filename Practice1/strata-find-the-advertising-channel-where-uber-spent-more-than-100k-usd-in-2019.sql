/*
https://platform.stratascratch.com/coding/10002-find-the-advertising-channel-where-uber-spent-more-than-100k-usd-in-2019?code_type=1

Find the advertising channel where Uber spent more than 100k USD in 2019.

Table: uber_advertising

+----------------------+----------+
| Column Name          | Type     |
+----------------------+----------+
| year                 | integer  |
| advertising_channel  | varchar  |
| money_spent          | integer  |
| customers_acquired   | integer  |
+----------------------+----------+
*/
SELECT advertising_channel FROM uber_advertising
WHERE money_spent > 100000 and year = 2019;
