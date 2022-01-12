
--How to create PRIMARY Key by using multiple fields
CREATE TABLE suppliers
(
supplier_id NUMBER(10),
supplier_name VARCHAR2(30),
contact_name VARCHAR2(30),
CONSTRAINT suppliers_pk PRIMARY KEY (supplier_id, supplier_name)

);

SELECT * FROM suppliers;

INSERT INTO suppliers VALUES(1, 'IBM', 'Jhon Walker');
INSERT INTO suppliers VALUES(2, 'APPLE', 'Tom Hanks');
INSERT INTO suppliers VALUES(3, 'SAMSUNG', 'Tae Shaun');
INSERT INTO suppliers VALUES(4, 'IBM', 'Chris Tien');
INSERT INTO suppliers VALUES(4, 'IBMX', 'Chris Tien');
INSERT INTO suppliers VALUES(5, 'IBMX', 'Chris Tien');


DROP TABLE suppliers;


---How to update data in a table (DML-Data manupulation Language)

UPDATE suppliers 
SET supplier_name ='GOOGLE'
WHERE supplier_id=5;



--How to update multiple data in table
--1.Example
UPDATE suppliers
SET contact_name='Veli Han'
WHERE supplier_id < 3;

--2.Example
UPDATE suppliers
SET supplier_name= 'YAHOO'
WHERE contact_name='Veli Han';

--3.Example
UPDATE suppliers
SET supplier_name='HONDA',
    contact_name='Angie Sun'
WHERE supplier_id =3;

DROP TABLE my_employees;

--Create "my _employees" table with employee_id, employee_name, employee_salary then iset 3 records
CREATE TABLE my_employees1(
employee_id CHAR(5),
employee_name VARCHAR2(30),
employee_salary NUMBER(7,2)
);

INSERT INTO my_employees1 VALUES ('101', 'Tom Hanks',3000.00);
INSERT INTO my_employees1 VALUES ('102', 'Angelina Julie',3500.75);
INSERT INTO my_employees1 VALUES ('103', 'Brad Pitt',4500.75);

SELECT
    * FROM my_employees1;
DROP TABLE my_employees1;

--Create "my _positions" table with position_id, position_name, position_salary then iset 3 records
CREATE TABLE my_positions(
position_id CHAR(5),
position_name VARCHAR2(30),
position_salary NUMBER(7,2)
);

INSERT INTO my_positions VALUES ('901', 'Junior Worker',2000.50);
INSERT INTO my_positions VALUES ('902', 'Senior Worker',5000.00);
INSERT INTO my_positions VALUES ('902', 'Manager',10000.50);

DROP TABLE my_position;
SELECT
    * FROM my_positions;


UPDATE my_employees1
SET employee_salary=(
                     SELECT position_salary
                     FROM my_positions
                     WHERE position_name= 'Manager'
                     )
WHERE employee_name='Angelina Julie';

SELECT
    * FROM my_employees1;

UPDATE my_employees1 SET employee_name='Brad Pitt Julie', employee_salary=(SELECT position_salary
                                                         FROM my_positions
                                                         WHERE position_name='Senior Worker')
WHERE employee_name='Brad Pitt';
    
--Update the Brad Pitt`s name to Brad Pitt Julie and Brad Pitt`s salary to SEnior Worker`s salary

UPDATE my_employees1
SET     employee_name='Brad Pitt Julie',
        employee_salary=(
                     SELECT position_salary
                     FROM my_positions
                     WHERE position_name= 'Senior Worker'
                     )
WHERE employee_name='Bras Pitt';

--We need to make %10 discount for Senior position and Manager position salaries for the employees

UPDATE my_employees1 
SET employee_salary = (
                        SELECT position_salary
                        FROM my_positions
                        WHERE position_name='Senior Worker'
                        )*0.90
                        
WHERE employee_name ='Brad Pitt Julie';

UPDATE my_employees1 
SET employee_salary = (
                        SELECT position_salary
                        FROM my_positions
                        WHERE position_name='Manager'
                        )*0.90
                        
WHERE employee_name ='Angelina Julie';



--Change the salary to 6000 if the salary is less than 5000

UPDATE my_employees1
SET employee_salary = 4000
WHERE employee_salary=6000;

DROP TABLE my_employees1;
DROP TABLE my_positions;


SELECT
    * FROM my_employees1;
    
    --Change the salary to 7000 if the salary less than Senior Worker salary
    
    UPDATE my_employees1
    SET employee_salary= 7000
    WHERE employee_salary<(SELECT position_salary 
                         FROM my_positions
                         WHERE position_name='Senior Worker'
                         );
                         
    
    
    
    
    UPDATE my_employees1
    SET employee_salary=7000
    WHERE employee_salary<(SELECT position_salary
                           FROM my_positions
                           WHERE position_name='Senior Worker'
                           );
                           
--Note: Sub Queries can be used after "SET" or "WHERE" keyword

--IS NULL Condition

CREATE TABLE people
(
ssn CHAR (9),
name VARCHAR2(50),
address VARCHAR2(50)
);

INSERT INTO people VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES (345678901, 'Mary Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES (456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES (567890123, 'California');
INSERT INTO people (ssn, name) VALUES (567890123, 'California');

SELECT * FROM people;

SELECT * FROM people
WHERE name IS NULL OR address IS NULL;

---How to update null to more understandle data
UPDATE people
SET name='Name is not inserted yet'
WHERE name IS NULL;

UPDATE people
SET address='Address is not inserted yet'
WHERE address IS NULL;

--2.way
UPDATE people
SET name= COALESCE(name, 'Name is not inserted yet'),
    address= COALESCE(address, 'Address is not inserted yet');
    
    DROP TABLE people;
    
     CREATE TABLE people
(
ssn CHAR (9),
name VARCHAR2(50),
address VARCHAR2(50)
);

INSERT INTO people VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO people VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO people VALUES (345678901, 'Mary Tien', 'New Jersey');
INSERT INTO people(ssn, address) VALUES (456789012, 'Michigan');
INSERT INTO people(ssn, address) VALUES (567890123, 'California');
INSERT INTO people (ssn, name) VALUES (567890123, 'California'); 
    --How to delete a data from a table
    --What is the difference between "DROP" and "DELETE"
    --DROP removes the table from schema completely that is, it removes table data and table structure
    --DELETE does not touch the table structure, it removes just data inside the table
    
 --   1)How to delete all records from a table
 
 DELETE FROM people;
 
 SELECT * FROM people;



--2)How to DELETE a s pecific record

DELETE FROM people
WHERE name= 'Mark Star';

--3) Delete all records whose name is null or address is null

DELETE FROM people
WHERE name IS NULL OR address IS NULL;

--4) Delete all recors whose names are not null
DELETE FROM people
WHERE name IS NOT NULL;
  
    

--WHAT is "TRUNCATE?"
--1)"TRUNCATE" is used to remove just all records.
--BUT "DELETE" is used to remove "all" and " specitic" records
--2) If you use "TRUNCATE" you cannot roll the records back
  -- BUT when you use "DELETE" you can roll the records back.
 -- 3)You cannot use "WHERE" caluse in "TRUNCATE"
-- BUT in "DELETE" you can


TRUNCATE TABLE people;

--HOW to prevent to roll a table back after using "DROP"?

--If you "PURGE" together with "DROP" , the table will be removed from schema and to roll it back will be impossible

SELECT * FROM people;
DROP TABLE people PURGE;

--Using SELECT statment (DQL)
--1)How to get all records from a table

SELECT * 
FROM people;

--2)How to select speciifc records from a table
--1. example
SELECT *
FROM people
WHERE name='Mary Tien';

--2.Example
--SElect records whose name lengths are less than 10
SELECT *
FROM people
WHERE LENGTH (name)<10;



CREATE TABLE workers
(
id CHAR (5),
name VARCHAR2(50),
salary NUMBER(5),
CONSTRAINT id4_pk PRIMARY KEY (id)
);

INSERT INTO workers VALUES (10001, 'Ali Can', 12000);
INSERT INTO workers VALUES (10002, 'Veli Han', 2000);
INSERT INTO workers VALUES (10003, 'Mary Star', 7000);
INSERT INTO workers VALUES (10004, 'Angie Ocean', 8500);

SELECT * 
FROM workers;

--4.Example
--Select the record whose salary is maximum ***INterview question!!!



SELECT * 
FROM workers
WHERE salary =(
               SELECT MAX(salary)
               FROM workers

               );
--5) example
--SElect the records whose salary is minumum


SELECT *
FROM workers
WHERE salary=(
             SELECT MIN(salary)
             FROM workers
);

--6) example
--Select the record whose salary is minimum or maximum
SELECT *
FROM workers
WHERE salary= (SELECT MIN(salary) FROM workers) 
OR salary= (SELECT MAX(salary) FROM workers);

SELECT * 
FROM workers
WHERE salary= (SELECT MIN (salary) FROM workers)OR salary= (SELECT MAX (salary) FROM workers);
               
--7) exmaples
--Select the record whose salary is the second maximum***Interview Question!!!!

SELECT *
FROM workers
WHERE salary= (
               SELECT MAX(salary) 
               FROM workers 
               WHERE salary<( 
                                SELECT MAX(salary)
                                FROM workers));

SELECT *
FROM workers 
WHERE salary =(
               SELECT MAX(salary)
               FROM workers
               WHERE salary< (
                              SELECT MAX (salary) 
                              FROM workers
                              )
               );

           
--8) exampele
--SELECT min salary from workers table

SELECT MIN(salary) AS MINUMUM_SALARY
  FROM workers;
  
  --9) exampele
--SELECT maxmin salary from workers table by using alias







SELECT MAX(salary) AS maximum_salary
FROM workers;


--10)
--Select maximum and minumum salary from the workers table by using alias


SELECT MAX(salary) AS Maximum_salary,
      MIN(salary) AS minumum_salary
  FROM workers;

--11)Select second maximum  from the workers table by using alias

SELECT MAX(salary)AS secont_maximum_salary
FROM workers
WHERE salary<(SELECT MAX(salary)FROM workers);

--12)SEelect second minumum salary from the workers table by suing alias


SELECT salary
FROM workers 
WHERE salary=(
               SELECT MIN( salary) 
               FROM workers 
               WHERE salary> 
                             (SELECT MIN (salary) FROM workers));
                

SELECT MIN(salary) AS second_minimum_salary
FROM workers
WHERE salary>(SELECT MIN(salary)FROM workers);

--13) Select all data about the worker who has second minumum salary from the workers table
--1.way
SELECT *
FROM workers
WHERE salary=(SELECT MIN(salary)
              FROM workers 
              WHERE salary>(SELECT MIN(salary)
                             FROM workers)
             );
             
             
--2.wasy
SELECT *
FROM workers
ORDER BY salary ASC
OFFSET 2 ROWS
FETCH NEXT 2 ROWS ONLY;

SELECT * 
FROM workers
ORDER BY salary ASC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;
             
--14Example
--Select all data of the worker whose saalry is the third maximum salary from the workers table ny using alias
--1.way

Select * From workers where( salary=(Select Max (salary) from workers where salary<(Select MAX (salary)From workers where salary<(Select MAX(salary) FROM workers))));

SELECT * 
FROM workers 
WHERE (salary=(SELECT MAX (salary)
                FROM workers
                WHERE salary < ( SELECT MAX(salary) 
                                 FROM workers
                                 WHERE salary<(SELECT MAX(salary)
                                 FROM workers)
                                 
                                 
                                 
                                 
        ) ));


--2.way
--To sort records in SQL we use "ORDER BY" with field name. It puts thre records in ascending order as default, if you want to put records in desending otder
--you have to declare
--IF you want to skip some records form the top use"OFFSET<number of rows>ROW"
--IF you want to get some records from top use "FETCH NEXT<number of rows> ROW ONLY
SELECT *
FROM workers
ORDER BY salary DESC
OFFSET 2 ROWS
FETCH NEXT 1 ROWS ONLY;

