/*
https://www.hackerrank.com/challenges/the-blunder/problem?isFullScreen=false

Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, 
but did not realize her keyboard's 0 key was broken until after completing the calculation. 
She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.

The EMPLOYEES table is described as follows:

+-------------+--------------+
| Column      | Type         |
+-------------+--------------+
| ID          | Integer      |
| NAME        | Integer      |
| SALARY      | Integer      |
+-------------+--------------+
Note: Salary is per month.
Constraints: 1000 < Salary < 10^5

Sample Input
+-----+-------------+--------------+
| ID  | Name        | Salary       |
+-----+-------------+--------------+
| 1   | Kristeen    | 1420         |
| 2   | Ahsley      | 2006         |
| 3   | Julia       | 2210         |
| 4   | Marria      | 3000         |
+-----+-------------+--------------+

Sample Output: 2061

Explanation
+-----+-------------+--------------+
| ID  | Name        | Salary       |
+-----+-------------+--------------+
| 1   | Kristeen    | 142          |
| 2   | Ahsley      | 26           |
| 3   | Julia       | 221          |
| 4   | Marria      | 3            |
+-----+-------------+--------------+
Samantha computes an average salary of 9800. The actual average salary is 2159.00.

The resulting error between the two calculations 2159.00 - 98.00 = 2061.00 is . Since it is equal to the integer 2061 , it does not get rounded up.
*/
SELECT CEIL(AVG(Salary) -  AVG(REPLACE(Salary, '0', ''))) FROM EMPLOYEES;
