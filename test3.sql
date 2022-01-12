DROP TABLE my_companies;

CREATE TABLE my_companies 
(  
  company_id number(9), 
  company_name varchar2(20)
);
INSERT INTO my_companies VALUES(100, 'IBM');
INSERT INTO my_companies VALUES(101, 'GOOGLE');
INSERT INTO my_companies VALUES(102, 'MICROSOFT');
INSERT INTO my_companies VALUES(103, 'APPLE');

SELECT * FROM my_companies;
CREATE TABLE orders 
(  
  order_id number(9),
  company_id number(9), 
  order_date date
);


DROP TABLE orders;
INSERT INTO orders VALUES(11, 101, '17-Apr-2020');
INSERT INTO orders VALUES(22, 102, '18-Apr-2020');
INSERT INTO orders VALUES(33, 103, '19-Apr-2020');
INSERT INTO orders VALUES(44, 104, '20-Apr-2020');
INSERT INTO orders VALUES(55, 105, '21-Apr-2020');

SELECT * FROM orders;

--1)INNER JOIN(JOIN): you will get common records from two tables
SELECT m.company_id, m.company_name, o.order_id
FROM my_companies m INNER JOIN orders o
ON o.company_id=m.company_id;

--2)LEFT JOIN: you will get records from the lest-hand table

SELECT m.company_id, m.company_name, o.order_id
FROM my_companies m LEFT JOIN orders o
ON o.company_id=m.company_id;

--2)RIGHT JOIN: you will get records from the lest-hand table

SELECT o.company_id, m.company_name, o.order_id
FROM my_companies m RIGHT JOIN orders o
ON o.company_id=m.company_id;

--FULL JOIN: YOu will get all records from the right-hand table and left_hand table
SELECT o.company_id, m.company_name, o.order_id
FROM my_companies m FULL JOIN orders o
ON o.company_id=m.company_id;

--5) SELF JOIN: WE join a table with itself
CREATE TABLE workers 
(  
  id number(2), 
  name varchar2(20),
  title varchar2(60),
  manager_id number(2) 
);
INSERT INTO workers VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO workers VALUES(2, 'John Walker', 'QA', 3);
INSERT INTO workers VALUES(3, 'Angie Star', 'QA Lead', 4);
INSERT INTO workers VALUES(4, 'Amy Sky', 'CEO', 5);

SELECT * FROM workers;

Drop table workers;

--Create a report which displays the workers and their managers

SELECT w1.name AS worker_name, w2.name AS manager_name
FROM workers w1 INNER JOIN workers w2
ON w1.manager_id= w2.id;


