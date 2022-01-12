CREATE TABLE your_students(
student_id CHAR(3),
student_name VARCHAR2(30),
studeny_age NUMBER(3,0),
date_of_birth DATE,
CONSTRAINT your_students_fk  FOREIGN KEY (student_id)REFERENCES your_employees (employee_id)
);


CREATE TABLE your_employees(
employee_id CHAR(5),
employee_name VARCHAR2(30)UNIQUE, --UNIQUE ia a "constrait" means no repeated values , multiple null is allowed
employee_salary NUMBER(10,2) NOT NULL,--NOT NULL is a "constrait" emans null values are not accepted --when you add not null it means that you are adding constrait that effects employee salary
employee_state CHAR(2),
company_name VARCHAR2(40),
CONSTRAINT your_employees_pk PRIMARY KEY (employee_id)
);

DROP Table your_employees;
DROP Table your_students;

CREATE TABLE your_suppliers
(
supplier_id NUMBER(10),
supplier_name VARCHAR2(30),
contact_name VARCHAR2(30),
CONSTRAINT suppliers_pk PRIMARY KEY (supplier_id, supplier_name)

);

SELECT * FROM your_suppliers;

INSERT INTO suppliers VALUES(1, 'IBM', 'Jhon Walker');
INSERT INTO suppliers VALUES(2, 'APPLE', 'Tom Hanks');
INSERT INTO suppliers VALUES(3, 'SAMSUNG', 'Tae Shaun');
INSERT INTO suppliers VALUES(4, 'IBM', 'Chris Tien');
INSERT INTO suppliers VALUES(4, 'IBMX', 'Chris Tien');
INSERT INTO suppliers VALUES(5, 'IBMX', 'Chris Tien');
INSERT INTO suppliers VALUES(4, 'IBM', 'Chris Tien');

DROP TABLE your_suppliers;

 SQL Select @version;
 