use employee_ai012;

-- Department(**DNo**,DName,MgrSSN,MgrStartDate)
create table department(
	dno varchar(5) PRIMARY KEY,
	dname varchar(25),
	mgrssn varchar(5),
	mgrstartdate date,
);

-- EMPLOYEE(**SSN**,name,Address,Sex,Salary,SuperSSN,DNo)
CREATE table employee(
	ssn varchar(5) PRIMARY KEY,
	name varchar(25),
	address varchar(50),
	sex varchar(7),
	salary int,
	superssn varchar(5),
	dno varchar(5),
);
 
alter table employee add constraint fk1 foreign key(dno) references department(dno) on delete cascade;
alter table employee add constraint fk2 foreign key(superssn) references employee(ssn);
alter table department add constraint fk3 foreign key(mgrssn) references employee(ssn);


-- Dlocation(**DNo**,**Dloc**)
CREATE table dlocation(
	dno varchar(5),
	dloc varchar(25),
	PRIMARY KEY(dno, dloc),
	FOREIGN KEY(dno) references department(dno) on delete cascade
);
-- Project(**Pno**,Pname,Plocation,Dno)
create table project(
	pno varchar(5),
	pname varchar(10),
	plocation varchar(25),
	dno varchar(5),
	primary key(pno),
	foreign key(dno) references department on delete cascade
);
-- Works_On(**SSN**,**Pno**,Hours)
create table works_on(
	ssn varchar(5),
	pno varchar(5),
	hours int,
	PRIMARY KEY(ssn, pno),
	foreign key(ssn) references employee(ssn) on delete cascade,
	foreign key(pno) references project(pno) on delete no action
);


-- -- Insertion 
insert into department values ('1', 'Networks', NULL, '10-JUN-13'),('2', 'Data Mining', NULL, '17-OCT-10');

insert into employee values('111', 'John B Smith', 'Nevada', 'MALE',800000, NULL, '1'), 
('222', 'Jason Y Yagami', 'Los Angeles', 'MALE', 700000, '111', '2'),
('333', 'Micheal Jackson', 'New York', 'FEMALE', 680000, '111', '1'),
('444', 'Jesse', 'Nevada', 'MALE', 800000, '222', '2'),
('555', 'Brian A Smith', 'Mexico City', 'MALE', 700000, '222','2'),
('666', 'June A', 'Washington DC', 'FEMALE', 600000, '333','1'),
('777', 'May B', 'Detroit', 'FEMALE', 500000, '333','2');

UPDATE department SET mgrssn = '111' where dno = '1';
UPDATE department SET mgrssn = '333' where dno = '2';

insert into dlocation values ('1','New York'),('2','Silicon Valley'),('1','Stanford'),('2','Houston');

insert into project values ('11','IOT','New York','1'),('12','WebMining','Silicon Valley','2'),('13','Sensors','Stanford','1'),('14','Clusters','Houston','2'),('15','Routing','Stanford','1');

insert into works_on values('555','11','4'),
('666','11','4'),
('666','12','3'),
('666','12','3'),


select * from department;
select * from employee;
select * from dlocation;
select * from project;

-- Make a list of all project number for projects that involve an employee whose last name is scott either as a worker or as a manager of the department that controls the project.
-- Show the resulting salaries if every employee working on the IOT project is given a 10 precent raise.
-- Find the sum of salaries of all employees of the 'Accounts' department as well as the maximum salary and the average salary in this department.
-- Retrieve the name of each employee who works on all the projects controlled by department number 5(use not exists operator)
-- For each department that has more than five employees retirieve the department number and the number of its employees who are making more than Rs. 6,00,000


