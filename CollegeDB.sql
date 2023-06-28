use collegedb_ai012;

-- Student(USN, SName, Address, Phone, Gender)
create table student(
	usn varchar(10) PRIMARY KEY,
	sname varchar(25),
	address varchar(50),
	phone bigint,
	gender varchar(10)
);

-- SEMSEC(SSID, Sem, Sec)
create table semsec(
	ssid varchar(10) PRIMARY KEY,
	sem char(1),
	sec char(1)
);
-- Class(USN, SSID
create table class(
	usn varchar(10),
	ssid varchar(10),
	PRIMARY KEY(usn, ssid),
	FOREIGN KEY(usn) references student(usn) on delete cascade,
	FOREIGN KEY(ssid) references semsec(ssid) on delete cascade
);
-- Subject(Subcode, Title, Sem, Credits)
create table subject(
	subcode varchar(10) PRIMARY KEY, 
	title varchar(25),
	sem char(1),
	credits int
);
-- IAMARKS(USN, Subcode, SSID, Test1, Test2, Test3, FinalIA)
create table iamarks(
	usn varchar(10),
	subcode varchar(10),
	ssid varchar(10),
	test1 int, 
	test2 int,
	test3 int,
	finalia int,
	PRIMARY KEY(usn,subcode,ssid),
	FOREIGN KEY(usn) references student(usn) on delete cascade,
	FOREIGN KEY(subcode) references subject(subcode) on delete cascade,
	FOREIGN KEY(ssid) references semsec(ssid) on delete cascade
);


INSERT INTO student (usn, sname, address, phone, gender)
VALUES ('USN001', 'John Doe', '123 Main Street', 1234567890, 'Male'),
('USN002', 'Jane Smith', '456 Elm Street', 9876543210, 'Female'),
('USN003', 'Mark Johnson', '789 Oak Street', 5551234567, 'Male'),
('USN004', 'Emma Williams', '987 Pine Street', 5559876543, 'Female'),
('1BI15CS101', 'Michael Brown', '321 Elm Street', 5553456789, 'Male'),
('USN006', 'Olivia Taylor', '654 Cherry Lane', 5558765432, 'Female'),
('USN005', 'David Smith', '456 Maple Avenue', 5552345678, 'Male');

INSERT INTO semsec (ssid, sem, sec)
VALUES ('SSID001', '4', 'A'),
('SSID002', '3', 'B'),
('SSID003', '8', 'C'),
('SSID004', '8', 'A'),
('SSID005', '8', 'B'),
('SSID006', '8', 'C');
 
 
INSERT INTO class (usn, ssid)
VALUES ('USN001', 'SSID001'),
('USN002', 'SSID001'),
('USN003', 'SSID002'),
('USN004', 'SSID002'),
('1BI15CS101', 'SSID003'),
('USN005', 'SSID004'),
('USN006', 'SSID005'),
('USN006', 'SSID006');
 
INSERT INTO subject (subcode, title, sem, credits)
VALUES ('SUB001', 'Mathematics', '8', 4),
('SUB002', 'Physics', '8', 3),
('SUB003', 'Chemistry', '8', 4),
('SUB004', 'Biology', '8', 3);

INSERT INTO iamarks (usn, subcode, ssid, test1, test2, test3, finalia)
VALUES ('1BI15CS101', 'SUB001', 'SSID003', 80, 75, 85, NULL),
('1BI15CS101', 'SUB002', 'SSID003', 90, 85, 80, NULL),
('USN005', 'SUB003', 'SSID004', 70, 75, 80, NULL),
('USN006', 'SUB004', 'SSID005', 85, 90, 95, NULL);

select * from student; 
select * from semsec;
select * from class;
select * from subject;
select * from iamarks;

DROP Table student;
DROP Table semsec;
DROP Table class;
DROP Table subject;
DROP Table iamarks;

-- Q.List all the student details studying in fourth semester 'A' Section
select s.usn, sname, gender, address
from student s, semsec sc, class c
where s.usn=c.usn and c.ssid=sc.ssid and sc.sem=4 and sc.sec='A';

-- Q.Compute the total number of male and female students in each semester and in each section
select from student s, semsec sc, class c join 

-- Q.Create a view of Test1 marks of student USN '1BI15CS101' in all subjects.

-- Q.Calculate the FinalIA(best of two test marks and update the corresponding table of students
UPDATE iamarks SET finalia = (test1+test2+test3)/3 where finalia is NULL;

-- Q.Categorize students based on the following criterion:
--		If FinalIA = 17 to 20 then CAT = 'Outstanding'
--		If FinalIA = 12 to 16 then CAT = 'Average'
--		If FinalIA < 12 then CAT = 'Weak'
-- Give these details only for 8th semester A, B and C section students
select s.sname from student s order by (case when finalia>17 and finalia=17 and finalia<20where  
-- Insert values for the 'class' table

