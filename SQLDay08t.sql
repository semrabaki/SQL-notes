DROP TABLE workers PURGE;

?
CREATE TABLE workers 
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);
?
INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');
?
SELECT * FROM workers;
?
--Find the total salary for every worker

SELECT name,SUM(salary) AS total_salary FROM workers GROUP BY name;

--Find the number of workers for every state
SELECT  COUNT(name), state  AS total_workers FROM workers GROUP BY state;

--Find the number of the workers whose salary is more than $2000 per company 

SELECT COUNT(name) AS total_workers, company FROM workers  WHERE salary >2000 GROUP BY company;

--Find the minimum and maximum salary for every company 

SELECT MAX(salary) AS max_salary, MIN(salary) AS min_salary, company FROM workers GROUP BY company;

--"HAVING" clause: It is used after "GROUP BY" to filter
?
--Find the total salary if it is greater than 2500 for every worker
?
--Note: After "WHERE", group functions(SUM(), COUNT(), MIN(), MAX(), AVG()) CANNOT be used.
--Note: After "GROUP BY",  "WHERE" CANNOT be used
--Note: After "GROUP BY", if you need to filter, you have to use "HAVING"
--Note: After "HAVING", you can use group functions or field names both work

--Find the total salary if it is greater than 2500 for every worker
SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
HAVING SUM(salary) > 2500;

--Find the total salary if the worker name is after 'Brad Pitt' in alphabet for every worker
SELECT name, SUM(salary) AS total_salary
FROM workers
GROUP BY name
HAVING name>'Brad Pitt';

--Find the number of employees if it is more than 1 per state

SELECT  COUNT(name), state FROM workers GROUP BY state HAVING COUNT(name)>1;

--Find the minimum salary if it is more than 2000 for every company

SELECT MIN(salary) AS min_salary, company FROM workers GROUP BY company HAVING MIN(salary)>2000;

--Find the maximum salary if it is less than 3000 for every state

SELECT MAX(salary) AS max_salary, state FROM workers GROUP BY state HAVING MAX(salary)<3000;

--SET Operations in SQL
--UNION, UNION ALL, INTERSECT, MINUS
--SET Operations are used between 2 SELECT Queries
?

?
--Note: Expression must have same datatype as corresponding expression
--Note: Query blocks must have same number of result columns
?
?
                --UNION Example
--When you use UNION same records are displayed just one, NO DUPLICATION

--Find the state OR employee names whose salary is greater than 3000, less than 2000 without duplication.


SELECT state AS state_or_employee, salary
FROM workers
WHERE salary>3000

UNION

SELECT name AS state_or_employee, salary
FROM workers
WHERE salary<2000;


--UNION ALL Example
--When you use UNION ALL same records are displayed multiple times, DUPLICATION is allowed

SELECT state AS state_or_employee, salary
FROM workers
WHERE salary>3000

UNION ALL

SELECT name AS state_or_employee, salary
FROM workers
WHERE salary<2000;
 --INTERSECT Example
                
--Find all common worker names whose salary is greater than 1000, less than 2000

SELECT name FROM workers 
WHERE salary>1000

INTERSECT

SELECT name FROM workers
WHERE salary<2000;

--Find all common employee names whose salary is greater than 2000 and company name is IBM, APPLE or GOOGLE
SELECT name FROM workers 
WHERE salary >2000

INTERSECT

SELECT name FROM workers
WHERE company IN ('IBM', 'APPLE', 'GOOGLE');

--MINUS Example
?
--Find the employee names whose salary is less than 3000 and not working in GOOGLE

SELECT name, state FROM workers 
WHERE salary<3000
MINUS
SELECT name,state FROM workers
WHERE company='GOOGLE';