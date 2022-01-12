SELECT * FROM workers;

SELECT * FROM companies;

DROP TABLE workers;

SELECT company, number_of_employees FROM companies ORDER BY number_of_employees DESC OFFSET 1 ROW FETCH NEXT ONLY 1 ROW;

SELECT company, number_of_employees
FROM companies 
WHERE number_of_employees=( 
                           SELECT max(number_of_employees)
                           FROM companies WHERE number_of_employees <(
                           SELECT max(number_of_employees) 
                           FROM companies));

--1.Exampe: Update the number of employees to 10000 if the number of employees is less than the avarage number of employees
		
UPDATE companies SET number_of_employees =10000 
WHERE number_of_employees<(SELECT AVG(number_of_employees) FROM companies);

SELECT * FROM companies


