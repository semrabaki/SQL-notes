CREATE TABLE customers_products
( 
  product_id number(10),
  customer_name varchar2(50),
  product_name varchar2(50)
);
 
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_products VALUES (20, 'John', 'Apple');
INSERT INTO customers_products VALUES (30, 'Amy', 'Palm');
INSERT INTO customers_products VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_products VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_products VALUES (40, 'John', 'Apricot');
INSERT INTO customers_products VALUES (20, 'Eddie', 'Apple'); 


SELECT * FROM customers_products;

--SElect all records whose product name are Orange or apple or appricot
--1.way
SELECT * FROM customers_products WHERE product_name='Orange' OR  product_name='Apple' OR  product_name='Apricot';

--2.way
SELECT *
FROM customers_products
WHERE product_name IN ('Orange', 'Apple', 'Appricot');

--2)Select words whose product name is not Orange or not Apple

SELECT *
FROM customers_products
WHERE product_name NOT IN ('Orange', 'Apple');

--BETWEEN Condition
--SEelect all records whose product id`s are greater than 10 and less than 30
SELECT *
FROM customers_products
WHERE product_id>=10 AND product_id<=30;

--2.way
SELECT *
FROM customers_products
WHERE produt_id BETWEEN 10 AND 30; --==> If you use "BETWEEN" borders are inclusive


--NOT BETWEEN CONDITIOM
--SElect all records whose product id`s are less than 20 or greater than 30

SELECT *
FROM customers_products
WHERE product_id<20 OR product_id>30;

--2.way
SELECT *
FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 30;--==> If you use "NOT BETWEEN" borders are inclusive

--EXIST Condition
--EXISTS is used for before "SUBQUERIES"
--Sometimes, we need to run a query if subqiery does not return any record.
--If you need to run a query if subquery does not return any record, you can use EXISTS Statemnt
--Sometimes to filter records, we need to use 'subquerries', when you use subqueries to fil


CREATE TABLE customers_likes
( 
  product_id number(10),
  customer_name varchar2(50),
  liked_product varchar2(50)
);

INSERT INTO customers_likes VALUES (10, 'Mark', 'Orange');
INSERT INTO customers_likes VALUES (50, 'Mark', 'Pineapple');
INSERT INTO customers_likes VALUES (60, 'John', 'Avocado');
INSERT INTO customers_likes VALUES (30, 'Lary', 'Cherries');
INSERT INTO customers_likes VALUES (20, 'Mark', 'Apple');
INSERT INTO customers_likes VALUES (10, 'Adem', 'Orange');
INSERT INTO customers_likes VALUES (40, 'John', 'Apricot');
INSERT INTO customers_likes VALUES (20, 'Eddie', 'Apple');

SELECT * FROM customers_likes;

--5) Update names to "NO name" if there us Lary among names in Customers_likes table
--1.way
UPDATE customers_likes
SET customer_name = 'No name'
WHERE customer_name='Lary';

DROP TABLE customers_likes;

--2.way
UPDATE customers_likes
SET customer_name = 'No name'
WHERE  EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name='Lary';

--6) Update names to "No name" if there is any liked product whose name is Orange or Pineapple or Avacado in customers_likes table

UPDATE customers_likes
SET customer_name = 'No name'
WHERE  EXISTS (SELECT customer_name FROM customers_likes WHERE liked_product IN ('Orange', 'Pineapple', 'Avocado'));  --this updates each record because exists means if tehre is any return in existx it will be executed for alll records

UPDATE customers_likes
SET  customer_name = 'No name'
WHERE liked_product IN ('Orange', 'Pineapple', 'Avocado'); --This only updated the prange pineappli and avacoda records

--7)Delete records if there is 'Orange' as Liked_product in customers_likes table
--Note: Following query will delete all records if there us  at least 1 orage amon liked products
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product='Orange');--Go to the table if there is orange delete all records if there is not orange fo not delete any record

DELETE FROM customers_likes
WHERE liked_product= 'Orange';--Go to the table, find the orange then delete the orange records

--8) SElect customer names  and product _id if the product ids are same in customers_products and customers_likes tables

DROP TABLE customers_products;
DROP TABLE customers_likes;

SELECT product_id, customer_name 
FROM customers_products
WHERE EXISTS (SELECT product_id FROM customers_likes WHERE customers_products.product_id=customers_likes.product_id);

                                  ---SUBQUERY
                                  
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

DROP TABLE workers;

SELECT * FROM workers;

CREATE TABLE companies 
(  
  company_id number(9), 
  company varchar2(20),
  number_of_employees number(20)
);
SELECT * FROM companies;
?
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

-----------------------------------
--9)Find the worker and company names whose company has more than 15000 employees

SELECT workers.name, workers.company
FROM workers
WHERE company IN(SELECT company FROM companies WHERE companies.number_of_employees>15000 );

--IF you work with 2 table you should find the comman field and work on those fields

--10) Find the company ids and company names which are  in Florida.

SELECT companies.company_id, companies.company 
FROM companies
WHERE company IN (Select company FROM workers WHERE workers.state='Florida');

--11) Find the company name, number of employees and avarage salary for every company
--if you need a columun which does not exist in your table you need to use subqueary after SELECT statment
SELECT company, number_of_employees, ( SELECT AVG(salary)  FROM workers WHERE workers.company=companies.company) AS average_salary
FROM companies;

--12)Find the name of the companies, company ids, maximum and minumum salaries per cpmpany

SELECT company, company_id, 
(SELECT MAX(salary) FROM workers WHERE workers.company=companies.company) AS max_salary,
(SELECT MIN (salary) FROM workers WHERE workers.company=companies.company) As min_salary
FROM companies;

                          --LIKE Statement
--WildCrads
--1)'%' means zero or more characters
--2)'_' means just a single character

SELECT * FROM workers;
--13)Select employee names which start with E

SELECT name
FROM workers
WHERE name LIKE 'E%';

--14)Select employee names which end with 'e'

SELECT name 
FROM workers
WHERE name LIKE '%e';

--15)Select employee names which start with B, and with 't'
SELECt name
FROM workers
WHERE name LIKE 'B%t';

--16) Select employee names which has 'a' in any posiiton
SELECT name
FROm workers
WHERE name LIKE '%a%';

--17) SElect employee names which has 'e' and 'r' in any position
--1.way
SELECT name
FROM workers
WHERE name LIKE '%e%' AND name LIKE '%r%';

--2.way
SELECT name
FROM workers
WHERE name LIKE '%e%r%' OR name LIKE '%r%e%';


--18) Select state whose second chaarcter is 'e' and forth character is 'n'

SELECT state
FROM workers
WHERE state LIKE '_e_n%';

SELECT * FROM workers;


--19) Select state whose last second character is 'i';
SELECT state
FROM workers
WHERE state LIKE '%i_';

--20) Select states whose secind character is 'e' and it has at least 6 chaarcters

SELECT state
FROM workers
WHERE state LIKE '_e____%';

--21) SElects states which has 'i' in any posiitons just after second character


SELECT state
FROM workers
WHERE state LIKE '_%i%' AND state NOT LIKE '_i%';

--22)SElect states which do not habe 'h in anu position

SELECT state
FROM workers
WHERE state NOT LIKE  '%x%';

--23)SElect states which do not end with 's' or and do not start 'F'==> Yhe inverse of 'A OR B' means  'inverse of A AND inverse of B'

SELECT state
FROM workers
WHERE state NOT LIKE 'F%' AND state NOT LIKE '%s';


----REGEXP

CREATE TABLE words
( 
  word_id number(10) UNIQUE,
  word varchar2(50) NOT NULL,
  number_of_letters number(6)
);
?
INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);


SELECT * from words;


--24)SElect words whose first characters is 'h' , last character is 't' and second chaarcter is 'o' or 'a' or 'i'

SELECT word
from words
WHERE word LIKE 'ho%t' OR  word LIKE 'ha%t' OR word LIKE 'hi%t';


--2.way
SELECT word
from words
WHERE REGEXP_LIKE (word, 'h[oai]*t');--First paarmeter is the column name . * means zero or more characters

--25) SElect words whose first chaarcter is 'h', last character is 't' and second character is from 'a' to 'e'


SELECT word
from words
WHERE REGEXP_LIKE (word, 'h[a-e](*)t');--From a to e all characters


--26)SElect words whose first chaarcter is 's' or 'a' or 'y'

SELECT word
from words
WHERE REGEXP_LIKE (word, '^[say](*)'); --^ -->means first character
-------------------------------------------------------

DROP TABLE workers;
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
--1) Select records whose state is Texas or Virginia or Pennsylvania

SELECT * 
FROM workers 
WHERE state IN ('Texas', 'Virginia', 'Pennsylvania');

----2) Select records whose company is not IBM or APPLE

SELECT *
FROM workers 
WHERE company  NOT IN ('IBM','APPLE');

--3)Select records whose salary is less than or equal to 3000 and greater than or equal to 1000
--1.Way:

SELECT *
FROM workers
WHERE salary <=3000 and salary>=1000; 
--2.way
SELECT *
FROM workers
WHERE salary BETWEEN 1000 AND 3000; --Make the smaller value first

--4)Select records whose salary is less than 2000, greater than 3000

SELECT * 
FROM workers
WHERE salary NOT BETWEEN 2000 and 3000;


--5)Delete all records if any salary is 1000 (since it says all records we need to use EXISTS)
--Following code deletes all records if there is 1000 among the salaries

DELETE FROM workers
WHERE EXISTS(Select salary FROM workers WHERE salary=1000);

SELECT * 
FROM workers;

--Following code deletes the records whose salary is 1000
DELETE FROM workers
WHERE salary = 1000;


--6)Select employee names which has 'k' after 3rd character in any position

SELECT name 
FROM workers
WHERE name LIKE '___%k%';

--7)Select employee names which do not start with 'E' and do not end with 'y'
--1.Way:

SELECT name 
FROM workers
WHERE name  NOT LIKE 'E%y';


--2.way
SELECT name
FROM workers
WHERE REGEXP_LIKE (name, '^[^E](.*)[^y]$');-- If you use ^ inside the brackets, it means 'different from'

-8)Select employee names which start with 'E' and end with 'y'
SELECT name
FROM workers
WHERE REGEXP_LIKE (name, '^E(.*)y$'); --^ --> means first character //$--> means last chaarcters  []--.>used for if there is more than one character
                                       --(.*)-->zero or more  characteers
                                       --If you have just a single option, using [] is optional
                                       
                                       
                                       
 --9)Select worker names whose last character is ‘r’ or ‘t’ AND first character is 'J' or 'B' or 'E'
SELECT name
FROM workers
WHERE REGEXP_LIKE (name, '^[JBE](.*)[rt]$') ;     --(.*) if the character before this first character we need to put * (.*).If not we use it like (*)  


--10)Select worker names whose last character is ‘r’ or ‘t’ OR first character is 'J' or 'B' or 'E'
SELECT name
FROM workers
WHERE REGEXP_LIKE(name,'^[JBE]') OR REGEXP_LIKE(name,'[rt]$');

--11)Select worker names whose last character is not ‘r’ or ‘t’ AND first character is not 'J' or 'B' or 'E'
 
SELECT name
FROM workers
WHERE REGEXP_LIKE(name, '^[^JBE](.*)[^rt]$') ;--[^]  means different than 
?

--12)Select worker names whose last character is not ‘r’ or ‘t’ OR first character is not 'J' or 'B' or 'E'
SELECT name
FROM workers
WHERE REGEXP_LIKE(name,'^[^JBE]') OR REGEXP_LIKE(name,'[^rt]$'); --false||false ==false all the others are true in OR operation

--13)Select names which have ‘a’ in any position
--By using regexp
SELECT name
FROM workers
WHERE REGEXP_LIKE(name,'a');  --for any posiiton just putting the chaarcter is enough!!!

--14)Select names which have ‘a’ or 'k' in any position
SELECT name
FROM workers
WHERE REGEXP_LIKE(name, '[ak]');  --we use [] for multiple chaarcter in regex in [] when you put chaarcter it means or for exaple a or k

--15)Select names which have characters from 'A' to 'F' at the beginning followed by any character then 'a'
SELECT name
FROM workers
WHERE REGEXP_LIKE(name,'^[A-F].a(*)');  --. means one chaarcter


--16)Select names which have characters from ’A to ‘F’ at the beginning followed by any 2 characters then ‘i’
SELECT name
FROM workers
WHERE REGEXP_LIKE(name,'^[A-F]..i(.*)');


--17)Select states whose third character is 'o' or 'x'
SELECT state
FROM workers
WHERE REGEXP_LIKE(state, '^..[ox]');--To reach thisrd character put 2 dots, and do not forget to put ^


--18)Select states whose third character is not 'o' or 'x'
SELECT state
FROM workers
WHERE REGEXP_LIKE(state, '^..[^ox]');-- first two characters then o or x

--19)Select states whose third character from the end is 'n' or 'x'
SELECT state
FROM workers
WHERE REGEXP_LIKE(state, '[nx]..$');
?
--20)Select states whose third character from the end is not 'n' or 'x'
SELECT state
FROM workers
WHERE REGEXP_LIKE(state, '[^nx]..$');


