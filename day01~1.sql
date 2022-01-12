--Create a table, name it as employees.Fileds are id, name, salary, state, company name
--How to create a table
CREATE TABLE my_students(
student_id CHAR(3),
student_name VARCHAR2(30),
studeny_age NUMBER(3,0),
date_of_birth DATE,
CONSTRAINT student_id_fk FOREIGN KEY (student_id) REFERENCES my_employees (employee_id)-- how to create foreign key
);

--2nd way to create primary key
CREATE TABLE my_employees(
employee_id CHAR(5),
employee_name VARCHAR2(30)UNIQUE, --UNIQUE ia a "constrait" means no repeated values , multiple null is allowed
employee_salary NUMBER(10,2) NOT NULL,--NOT NULL is a "constrait" emans null values are not accepted --when you add not null it means that you are adding constrait that effects employee salary
employee_state CHAR(2),
company_name VARCHAR2(40),
CONSTRAINT employee_id_pk PRIMARY KEY (employee_id) --2nd way to create primary key but this way  has benefits  which you are able to put your own index name- the meaning of code : I am creating constrit which name is employee_is_pk for employee_id
);

DROP TABLE my_students;
DROP TABLE my_employees;

--How to check values 
CREATE TABLE suppliers(
supplier_id NUMBER(3),--Check if the id is between 200 and 500
supplier_name VARCHAR2(30),
supplier_date DATE,
CONSTRAINT supplier_id_check CHECK(supplier_id BETWEEN 200 AND 500)
);

--Constraints :1) Primary Key 2) Unique 3) Not Null 4) foreign Key 5) Check

CREATE TABLE my_suppliers(
supplier_id NUMBER(3),--Check if the id is between 200 and 500
supplier_name VARCHAR2(30),--CReate a constraint to check if all names are in uppercase
supplier_date DATE,
CONSTRAINT supplier_name_check CHECK(supplier_name= UPPER(supplier_name))
);

--How to insert data into a table

INSERT INTO my_suppliers VALUES(101, 'ALI CAN', '07-Apr-21');
INSERT INTO my_suppliers VALUES(102, 'VELI HAN', '07-Apr-21');

--How to see table on the output console
SELECT * FROM my_suppliers;

CREATE TABLE my_employees(
employee_id CHAR(5),
employee_name VARCHAR2(30)UNIQUE, --UNIQUE ia a "constrait" means no repeated values , multiple null is allowed
employee_salary NUMBER(10,2) NOT NULL,--NOT NULL is a "constrait" emans null values are not accepted --when you add not null it means that you are adding constrait that effects employee salary
employee_state CHAR(2),
company_name VARCHAR2(40),
CONSTRAINT employee_id_pk PRIMARY KEY (employee_id) --2nd way to create primary key but this way  has benefits  which you are able to put your own index name- the meaning of code : I am creating constrit which name is employee_is_pk for employee_id
);

INSERT INTO my_employees VALUES('13456', 'Aliye Can', 123000.00, 'FL', 'Google'); --First way to insert data
INSERT INTO my_employees VALUES('13457', 'Veli Han', 146000.23, null, 'Apple');

SELECT * FROM my_employees;

--2nd way

INSERT INTO my_suppliers( supplier_id, supplier_name) VALUES (123, 'KEMAL KUZU');
INSERT INTO my_suppliers( supplier_name,supplier_id ) VALUES ( 'KEMAL KOC',124);
SELECT * FROM my_suppliers;



