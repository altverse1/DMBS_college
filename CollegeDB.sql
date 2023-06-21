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
 

-- Insert values for the 'student' table
INSERT INTO student (usn, sname, address, phone, gender)
VALUES
    ('1BI15CS101', 'John Doe', '123 Main Street', 1234567890, 'Male'),
    ('1BI15CS102', 'Jane Smith', '456 Elm Avenue', 9876543210, 'Female'),
    ('1BI15CS103', 'Mike Johnson', '789 Oak Road', 5555555555, 'Male'),
    ('1BI15CS104', 'Emily Brown', '321 Pine Court', 1111111111, 'Female'),
    ('1BI15CS105', 'David Wilson', '654 Cedar Lane', 2222222222, 'Male'),
    ('1BI15CS106', 'Sarah Davis', '987 Maple Drive', 3333333333, 'Female'),
    ('1BI15CS107', 'Michael Miller', '741 Birch Street', 4444444444, 'Male'),
    ('1BI15CS108', 'Jennifer Anderson', '852 Walnut Avenue', 6666666666, 'Female'),
    ('1BI15CS109', 'Robert Taylor', '963 Spruce Road', 7777777777, 'Male'),
    ('1BI15CS110', 'Jessica Wilson', '159 Pine Court', 8888888888, 'Female');

-- Insert values for the 'semsec' table
INSERT INTO semsec (ssid, sem, sec)
VALUES
    ('SSID001', '1', 'A'),
    ('SSID002', '1', 'B'),
    ('SSID003', '2', 'A'),
    ('SSID004', '2', 'B'),
    ('SSID005', '3', 'A'),
    ('SSID006', '3', 'B'),
    ('SSID007', '4', 'A'),
    ('SSID008', '4', 'B'),
    ('SSID009', '5', 'A'),
    ('SSID010', '5', 'B'),
    ('SSID011', '8', 'A'),
    ('SSID012', '8', 'B'),
    ('SSID013', '8', 'C');

-- Insert values for the 'class' table
INSERT INTO class (usn, ssid)
VALUES
    ('1BI15CS101', 'SSID011'),
    ('1BI15CS102', 'SSID011'),
    ('1BI15CS103', 'SSID011'),
    ('1BI15CS104', 'SSID011'),
    ('1BI15CS105', 'SSID011'),
    ('1BI15CS106', 'SSID011'),
    ('1BI15CS107', 'SSID011'),
    ('1BI15CS108', 'SSID011'),
    ('1BI15CS109', 'SSID012'),
    ('1BI15CS110', 'SSID013');

-- Insert values for the 'subject' table
INSERT INTO subject (subcode, title, sem, credits)
VALUES
    ('SUB001', 'Mathematics', '1', 4),
    ('SUB002', 'English', '1', 3),
    ('SUB003', 'Physics', '2', 4),
    ('SUB004', 'Chemistry', '2', 4),
    ('SUB005', 'Biology', '3', 4),
    ('SUB006', 'History', '3', 3),
    ('SUB007', 'Geography', '4', 3),
    ('SUB008', 'Computer Science', '4', 4),
    ('SUB009', 'Economics', '5', 3),
    ('SUB010', 'Psychology', '5', 3),
    ('SUB011', 'Subject1', '8', 3),
    ('SUB012', 'Subject2', '8', 4),
    ('SUB013', 'Subject3', '8', 3);

-- Insert values for the 'iamarks' table
INSERT INTO iamarks (usn, subcode, ssid, test1, test2, test3, finalia)
VALUES
    ('1BI15CS101', 'SUB001', 'SSID011', 90, 85, 92, 95),
    ('1BI15CS102', 'SUB001', 'SSID011', 80, 92, 88, 87),
    ('1BI15CS103', 'SUB001', 'SSID011', 95, 93, 90, 94),
    ('1BI15CS104', 'SUB001', 'SSID011', 88, 90, 92, 91),
    ('1BI15CS105', 'SUB001', 'SSID011', 92, 87, 85, 89),
    ('1BI15CS106', 'SUB001', 'SSID011', 91, 94, 88, 90),
    ('1BI15CS107', 'SUB001', 'SSID011', 86, 88, 90, 88),
    ('1BI15CS108', 'SUB001', 'SSID011', 89, 91, 87, 90),
    ('1BI15CS109', 'SUB001', 'SSID012', 94, 92, 95, 93),
    ('1BI15CS110', 'SUB001', 'SSID013', 87, 90, 86, 88);


select * from student; 
select * from semsec;
select * from class;
select * from subject;
select * from iamarks;




-- Q.List all the student details studying in fourth semester 'C' Section
-- Q.Compute the totla number of male and femal students in each semester and in each section
-- Q.Create a view of Test1 marks of student USN '1BI15CS101' in all subjects.
-- Q.Calculate the FinalIA(best of two test marks and update the corresponding table of students
-- Q.Categorize students based on the following criterion:
--		If FinalIA = 17 to 20 then CAT = 'Outstanding'
--		If FinalIA = 12 to 16 then CAT = 'Average'
--		If FinalIA < 12 then CAT = 'Weak'
-- Give these details only for 8th semester A, B and C section students
