USE Ex_Emp;

-- EMPLOYEE(SSN, Name, Address, Sex, Salary, SuperSSN, DNo) 
-- DEPARTMENT(DNo, DName, MgrSSN, MgrStartDate) 
-- DLOCATION(DNo,DLoc) 
-- PROJECT(PNo, PName, PLocation, DNo) 
-- WORKS_ON(SSN, PNo, Hours)
CREATE TABLE employee
(
	ssn			VARCHAR(10),
	name		VARCHAR(25),
	address		VARCHAR(50),
	sex			VARCHAR(10),
	salary		INT,
	superssn	VARCHAR(10),
	dno			VARCHAR(5),
	PRIMARY KEY(ssn)
);

CREATE TABLE department
(
	dno				VARCHAR(5),
	dname			VARCHAR(25),
	mgrssn			VARCHAR(10),
	mgrstartdate	DATE,
	PRIMARY KEY(dno)
);

ALTER TABLE employee ADD CONSTRAINT FK1 FOREIGN KEY(dno) REFERENCES department(dno) ON DELETE CASCADE;
ALTER TABLE employee ADD CONSTRAINT FK2 FOREIGN KEY(superssn) REFERENCES employee(ssn) ON DELETE NO ACTION;
ALTER TABLE department ADD CONSTRAINT FK3 FOREIGN KEY(mgrssn) REFERENCES employee(ssn) ON DELETE NO ACTION;


CREATE TABLE dlocation
(
	dno			VARCHAR(5),
	dloc		VARCHAR(30),
	PRIMARY KEY(dno, dloc),
	FOREIGN KEY(dno) REFERENCES department(dno)
);

CREATE TABLE project
(
	pno			VARCHAR(5),
	pname		VARCHAR(25),
	plocation	VARCHAR(30),
	dno			VARCHAR(5),
	PRIMARY KEY(pno),
	FOREIGN KEY(dno) REFERENCES department(dno),
);

CREATE table works_on
(
	ssn			VARCHAR(10),
	pno			VARCHAR(5),
	hours		INT,
	PRIMARY KEY(ssn,pno),
	FOREIGN KEY(ssn) REFERENCES employee(ssn),
	FOREIGN KEY(pno) REFERENCES project(pno)
);

-- DEPARTMENT(DNo, DName, MgrSSN, MgrStartDate) 
INSERT INTO department VALUES 
('1','IT',NULL,'2020-06-06'),
('2','Data Mining',NULL,'2020-08-01');


-- EMPLOYEE(SSN, Name, Address, Sex, Salary, SuperSSN, DNo) 
INSERT INTO employee VALUES 
('111','John B. Smith', 'Park Avenue', 'Male', 100000, NULL, '1'),
('112','Jake E', 'New York', 'Male', 90000, '111','2'),
('113','Jesse E', 'New York', 'Female', 90000, '111','1'),
('114','May B', 'Washington DC', 'Female', 75000, '113','1'),
('115','Dawn E', 'Virginia', 'Female', 80000, '112','2'),
('116','Ash S. Scott', 'California', 'Male', 60000, '113','1');

UPDATE department SET mgrssn = '113' WHERE dno = '1';
UPDATE department SET mgrssn = '112' WHERE dno = '2';

-- DLOCATION(DNo,DLoc) 
INSERT INTO dlocation VALUES
('1','Virginia'),
('1','Washington DC'),
('2','Los Angeles'),
('2','San Fansisco');

-- PROJECT(PNo, PName, PLocation, DNo) 
INSERT INTO project VALUES 
('1','Data Warehousing','Virginia','2'),
('2','IoT','San Fansisco','1'),
('3','Enchanced Predictor','Washington DC','2'),
('4','Surround Sound','New York','1');

-- WORKS_ON(SSN, PNo, Hours)
INSERT INTO works_on VALUES
('116','4',9),
('116','2',11),
('115','3',9),
('114','1',11),
('113','2',14),
('112','1',16),
('111','4',9);


-- 1. Make a list of all project numbers for projects that involve an employee whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project.
SELECT distinct pno
from project
WHERE pno IN
(SELECT p.pno 
FROM project p,department d,employee e
WHERE p.dno = d.dno AND d.mgrssn = e.ssn AND name LIKE '%Scott')
OR
pno IN
(SELECT pno
FROM works_on w,employee e
WHERE w.ssn = e.ssn AND name LIKE '%Scott');

-- 2. Show the resulting salaries if every employee working on the ‘IoT’ project is given a 10 percent raise. 
SELECT ssn, (salary+(salary*0.10)) AS resulting_sal 
FROM employee
WHERE ssn IN
(SELECT ssn 
FROM WORKS_ON
WHERE pno IN
(SELECT pno 
FROM project
WHERE pname = 'IoT'));

-- 3. Find the sum of the salaries of all employees of the ‘IT’ department, as well as the maximum salary, the minimum salary, and the average salary in this department 
SELECT SUM(salary) Sum_sal, MAX(salary) Max_sal, MIN(salary) Min_sal, AVG(salary) Avg_sal
FROM employee
WHERE dno IN
(SELECT dno 
FROM department 
WHERE dname = 'IT');

-- 4. Retrieve the name of each employee who works on all the projects controlledby department number 1 (use NOT EXISTS operator). 
SELECT e.name 
FROM employee  e
WHERE NOT EXISTS((SELECT pno FROM project WHERE dno = '1') MINUS (SELECT pno FROM works_on WHERE ssn = e.ssn));

-- 5. For each department that has more than 2 employees, retrieve the department number and the number of its employees who are making more THAN RS. 6,00,000.
SELECT d.dno, COUNT(*) as no_of_emp 
FROM employee e, department d
WHERE d.dno = e.dno AND salary>80000 AND d.dno IN 
(SELECT dno FROM employee
GROUP BY dno
HAVING COUNT(*)>1)
GROUP by d.dno;

-- EMPLOYEE(SSN, Name, Address, Sex, Salary, SuperSSN, DNo) 
-- DEPARTMENT(DNo, DName, MgrSSN, MgrStartDate) 
-- DLOCATION(DNo,DLoc) 
-- PROJECT(PNo, PName, PLocation, DNo) 
-- WORKS_ON(SSN, PNo, Hours)
