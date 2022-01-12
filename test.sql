DROP TABLE workers;


SELECT * FROM workers;

show connection

SELECT * FROM my_positions;

SELECT * FROM my_workers;

 SELECT country_id, country_name FROM countries WHERE region_id>2;
 
 CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);

INSERT INTO workers VALUES (10001, 'Ali Can', 12000);
INSERT INTO workers VALUES (10002, 'Veli Han', 2000);
INSERT INTO workers VALUES (10003, 'Mary Star', 7000);
INSERT INTO workers VALUES (10004, 'Angie Ocean', 8500);

SELECT * FROM workers WHERE salary= (SELECT MIN(salary) FROM workers);

SELECT * FROM campanies WHERE number_of_employees= (SELECT MIN(number_of_employees) FROM companies);
SELECT * FROM countries WHERE region_id= (SELECT MIN(region_id) FROM countries);

SELECT * FROM workers WHERE salary= (SELECT MIN(salary) FROM workers);
