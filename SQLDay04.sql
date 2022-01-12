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

            --IN STATEMENT: Instead of using multiple 'OR' we use 'IN'
--1) Select records whose product name is Orange or Apple or Palm
--1.Way:
SELECT * 
FROM customers_products 
WHERE product_name = 'Orange' OR product_name = 'Apple' OR product_name = 'Palm'; 

--2.Way:
SELECT * 
FROM customers_products 
WHERE product_name IN('Orange', 'Apple', 'Palm');

            --NOT IN STATEMENT:Instead of using multiple 'Not OR' we use 'NOT IN'
--2) Select records whose product name is not Orange or not Apple
SELECT * 
FROM customers_products
WHERE product_name NOT IN('Orange', 'Apple');

            --BETWEEN Statement
--3)Select records whose product id is less than or equal to 30 and greater than or equal to 20
--1.Way:
SELECT * 
FROM customers_products
WHERE product_id <= 30 AND product_id >= 20;

--2.Way:
SELECT * 
FROM customers_products
WHERE product_id BETWEEN 20 AND 30; --When you use BETWEEN, boundries are inclusive

            --NOT BETWEEN Statement
--4)Select records whose product id is less than 20, greater than 25
SELECT * 
FROM customers_products
WHERE product_id NOT BETWEEN 20 AND 25;

            --EXISTS Statement
--Sometimes, we need to run a query if subquery returns any record.
--If you need not to run a query if subquery does not return any record, you can use EXISTS Statement
--Sometimes to filter records, we need to use 'subqueries', when you use subqueries to filter using 'EXISTS' is preferable.

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

--5) Update names to "No name" if there is Lary among names in customers_likes table
--1.Way:
UPDATE customers_likes
SET customer_name = 'No name'
WHERE customer_name = 'Lary';

--2.Way:
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE customer_name = 'Lary');

SELECT * FROM customers_products;

--6) Update names to "No name" if there is any liked product whose name is Orange or Pineapple or Avocado in customers_likes table
UPDATE customers_likes
SET customer_name = 'No name'
WHERE EXISTS (SELECT customer_name FROM customers_likes WHERE liked_product IN ('Orange','Pineapple','Avocado'));

UPDATE customers_likes
SET customer_name = 'No name'
WHERE liked_product IN ('Orange','Pineapple','Avocado');

DROP TABLE customers_likes;

---7) Delete records if there is 'Orange' as liked_product in customers_likes table
DELETE FROM customers_likes
WHERE EXISTS (SELECT liked_product FROM customers_likes WHERE liked_product = 'Orange');

DELETE FROM customers_likes
WHERE liked_product = 'Orange';

--8)Select product id and customer names if the product ids are same in customers_products and customers_likes tables.
SELECT product_id, customer_name 
FROM customers_products
WHERE EXISTS (SELECT product_id FROM customers_likes WHERE customers_products.product_id = customers_likes.product_id);

                        --SUBQUERY
CREATE TABLE workers
(  
  id number(9), 
  name varchar2(50), 
  state varchar2(50), 
  salary number(20),
  company varchar2(20)
);

INSERT INTO workers VALUES(123456789, 'John Walker', 'Florida', 2500, 'IBM');
INSERT INTO workers VALUES(234567890, 'Brad Pitt', 'Florida', 1500, 'APPLE');
INSERT INTO workers VALUES(345678901, 'Eddie Murphy', 'Texas', 3000, 'IBM');
INSERT INTO workers VALUES(456789012, 'Eddie Murphy', 'Virginia', 1000, 'GOOGLE');
INSERT INTO workers VALUES(567890123, 'Eddie Murphy', 'Texas', 7000, 'MICROSOFT');
INSERT INTO workers VALUES(456789012, 'Brad Pitt', 'Texas', 1500, 'GOOGLE');
INSERT INTO workers VALUES(123456710, 'Mark Stone', 'Pennsylvania', 2500, 'IBM');

CREATE TABLE companies 
(  
  company_id number(9), 
  company varchar2(20),
  number_of_employees number(20)
);

DROP TABLE companies;
INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(103, 'APPLE', 21000);

SELECT * FROM companies;
SELECT * FROM workers;

--9) Find the worker and company names whose company has more than 15000 employees
SELECT workers.name, workers.company
FROM workers
WHERE company IN(SELECT companies.company FROM companies WHERE companies.number_of_employees>15000);

--10)Find the company ids and company names which are in Florida
SELECT company_id, company
FROM companies
WHERE company IN(SELECT company FROM workers WHERE workers.state = 'Florida');

--11)Find the company name, number of employees and average salary for every company
SELECT company, number_of_employees, (SELECT AVG(salary) FROM workers WHERE workers.company = companies.company) AS average_salary
FROM companies;

--12)Find the name of the companies, company ids, maximum and minimum salaries per company.
SELECT company, company_id,
(SELECT MAX(salary) FROM workers WHERE workers.company = companies.company) AS max_salary,
(SELECT MIN(salary) FROM workers WHERE workers.company = companies.company) AS min_salary 
FROM companies;

                --LIKE Statement
--WildCrads
--1)'%' means zero or more characters
--2)'_' means just a single character
SELECT * FROM workers;

--13)Select employee names which start with 'E'
SELECT name
FROM workers
WHERE name LIKE 'E%';

--14)Select employee names which end with 'e'
SELECT name
FROM workers
WHERE name LIKE '%e';

--15)Select employee names which start with B, end with 't'
SELECT name
FROM workers
WHERE name LIKE 'B%t';

--16)Select employee names which has 'a' in any position
SELECT name
FROM workers
WHERE name LIKE '%a%';

--17)Select employee names which has 'e' and 'r' in any position
--1.Way:
SELECT name
FROM workers
WHERE name LIKE '%e%' AND name LIKE '%r%';

--2.Way:
SELECT name
FROM workers
WHERE name LIKE '%e%r%' OR name LIKE '%r%e%';

--18)Select state whose second character is 'e' and forth character is 'n'
SELECT state
FROM workers
WHERE state LIKE '_e_n%';

--19)Select state whose last second character is 'i'
SELECT state
FROM workers
WHERE state LIKE '%i_';

--20)Select states whose second character is 'e' and it has at least 6 characters
SELECT state
FROM workers
WHERE state LIKE '_e____%';

--21)Select states which has 'i' in any position just after second character
SELECT state
FROM workers
WHERE state LIKE '__%i%' AND state NOT LIKE '_i%';

--22)Select states which do not have 'x' in any position
SELECT state
FROM workers
WHERE state NOT LIKE '%x%';

--23)Select states which do not end with 's' OR do not start with 'F' ==> The inverse of 'A OR B' means 'inverse of A AND inverse of B'
SELECT state
FROM workers
WHERE state NOT LIKE 'F%' AND state NOT LIKE '%s';

                --REGEXP
CREATE TABLE words
( 
  word_id number(10) UNIQUE,
  word varchar2(50) NOT NULL,
  number_of_letters number(6)
);

INSERT INTO words VALUES (1001, 'hot', 3);
INSERT INTO words VALUES (1002, 'hat', 3);
INSERT INTO words VALUES (1003, 'hit', 3);
INSERT INTO words VALUES (1004, 'hbt', 3);
INSERT INTO words VALUES (1008, 'hct', 3);
INSERT INTO words VALUES (1005, 'adem', 4);
INSERT INTO words VALUES (1006, 'selena', 6);
INSERT INTO words VALUES (1007, 'yusuf', 5);

SELECT * FROM words;

--24)Select words whose first character is 'h', last character is 't' and second character is 'o', or 'a' or 'i'
--1.Way:
SELECT word
FROM words
WHERE word LIKE 'ho%t' OR word LIKE 'ha%t' OR word LIKE 'hi%t';

--2.Way:
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'h[oai](*)t');--First parameter is the column name. * means zero or more characters

--25)Select words whose first character is ‘h’, last character is ‘t’ and second character is from ‘a’ to ‘e’
SELECT word
FROM words
WHERE REGEXP_LIKE(word, 'h[a-e](*)t');--From a to e all characters

--26)Select words whose first character is 's' or 'a' or 'y'
SELECT word
FROM words
WHERE REGEXP_LIKE(word, '^[say](*)');-- ^ means first character 