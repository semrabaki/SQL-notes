
DROP TABLE workers;

CREATE TABLE workers
(
    id CHAR(5),
    name VARCHAR2(50),
    salary NUMBER(5)
);  
    
INSERT INTO workers VALUES(10001, 'Ali Can', 12000);
INSERT INTO workers VALUES(10002, 'Veli Han', 2000);
INSERT INTO workers VALUES(10003, 'Mary Star', 7000);
INSERT INTO workers VALUES(10004, 'Angie Ocean', 8500); 


SELECT name, salary FROM workers WHERE salary= (Select MAX(salary) FROM workers WHERE salary< (SELECT MAX(salary) FROM workers));

SELECT * FROM workers;
SELECT name, salary FROM workers ORDER BY salary DESC OFFSET 1 ROW FETCH NEXT ROW ONLY;

SELECT * FROM my_positions;

SELECT company, number_of_employees FROM companies WHERE number_of_employees= (Select MAX(number_of_employees) FROM companies WHERE number_of_employees< (SELECT MAX(number_of_employees) FROM companies));
SELECT position_name, position_salary FROM my_positions WHERE position_salary= (Select MAX(position_salary) FROM my_positions  WHERE position_salary< (SELECT MAX(position_salary) FROM my_positions ));



SELECT * FROM companies;

SELECT position_name, position_salary FROM my_positions WHERE position_salary <(SELECT AVG(position_salary)FROM my_positions);


CREATE TABLE companies 
(  
  company_id number(9), 
  company varchar2(20),
  number_of_employees number(20)
);

INSERT INTO companies VALUES(100, 'IBM', 12000);
INSERT INTO companies VALUES(101, 'GOOGLE', 18000);
INSERT INTO companies VALUES(102, 'MICROSOFT', 10000);
INSERT INTO companies VALUES(100, 'APPLE', 21000);