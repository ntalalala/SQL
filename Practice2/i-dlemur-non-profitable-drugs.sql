/*
https://datalemur.com/questions/non-profitable-drugs

Each drug is exclusively manufactured by a single manufacturer.
Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.
Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. Display the results sorted in descending order with the highest losses displayed at the top.

pharmacy_sales table:
+---------------------+--------------+
| Column Name         | Type         |
+---------------------+--------------+
| product_id          | integer      |
| units_sold          | integer      |
| total_sales         | decimal      |
| cogs                | decimal      |
| manufacturer        | varchar      |
| drug                | varchar      |
+---------------------+--------------+

Input:
+------------+------------+-------------+-------------+--------------+---------------------------+
| product_id | units_sold | total_sales | cogs        | manufacturer | drug                      |
+------------+------------+-------------+-------------+--------------+---------------------------+
| 156        | 89514      | 3130097.00  | 3427421.73  | Biogen       | Acyclovir                 |
| 25         | 222331     | 2753546.00  | 2974975.36  | AbbVie       | Lamivudine and Zidovudine |
| 50         | 90484      | 2521023.73  | 2742445.90  | Eli Lilly    | Dermasorb TA Complete Kit |
| 98         | 110746     | 813188.82   | 140422.87   | Biogen       | Medi-Chord                |
+------------+------------+-------------+-------------+--------------+---------------------------+

Output:
+--------------+------------+---------------+
| manufacturer | drug_count | total_loss    |
+--------------+------------+---------------+
| Biogen       | 1          | 297324.73     |
| AbbVie       | 1          | 221429.36     |
| Eli Lilly    | 1          | 221422.17     |
+--------------+------------+---------------+

Explanation:
The first three rows indicate that some drugs resulted in losses. Among these, Biogen had the highest losses, followed by AbbVie and Eli Lilly. However, the Medi-Chord drug manufactured by Biogen reported a profit and was excluded from the result.
*/

SELECT manufacturer, COUNT(drug) AS drug_count, SUM(ABS(cogs - total_sales)) AS total_loss
FROM pharmacy_sales
WHERE cogs > total_sales
GROUP BY manufacturer
ORDER BY total_loss DESC
