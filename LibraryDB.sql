-- -- Done on Microsoft SQL Server Management Studio.
-- -- Allows us to select and execute.

-- -- Create a Schema Diagram before starting

-- Creating Table Publisher (1)

USE	library_ai012;

create table publisher
(
	name varchar(10) PRIMARY KEY,
	address varchar(10),
	phone int,
);

-- Creating Table Book (2)
create table book
(
	book_id varchar(5) PRIMARY KEY,
	title varchar(20),
	pub_name varchar(10),
	pub_year int,
	FOREIGN KEY(pub_name) references publisher(name) on delete cascade,
);

-- Creating Table Library_Branch (3)
create table library_branch
(
	branch_id varchar(5) PRIMARY KEY,
	branch_name varchar(10),
	address varchar(15),
);

-- Creating Table book_authors (4)
create table book_authors
(
	book_id varchar(5),
	author_name varchar(15),
	PRIMARY KEY(book_id, author_name), -- Both book_id and author name are the primary key.
	FOREIGN KEY(book_id) references book(book_id) on delete cascade
);

-- Creating Table book_copies (5)
create table book_copies
(
	book_id varchar(5),
	branch_id varchar(5),
	no_of_copies int,
	PRIMARY KEY (book_id, branch_id),
	FOREIGN KEY (book_id) references book(book_id) on delete cascade,
	FOREIGN KEY (branch_id) references library_branch(branch_id) on delete cascade,
);

-- Creating Table book_lending (6)
create table book_lending 
(
	book_id varchar(5),
	branch_id varchar(5),
	card_no varchar(5),
	date_out date,
	due_date date,
	PRIMARY KEY (book_id, branch_id, card_no),
	FOREIGN KEY (book_id) references book(book_id) on delete cascade,
	FOREIGN KEY (branch_id) references library_branch(branch_id) on delete cascade,
);

-- -- Inserting into tables as per the table creation order
-- Publishers
insert into publisher values('Inedition','Noida', 961235521);
insert into publisher values('Editorist','Indore', 943235521);
insert into publisher values('OverWrite','Nagpur', 961235421);
insert into publisher values('WWWeeb','Bangalore', 961228321);
insert into publisher values('TechStuff','Mumbai', 961232321);
select * from publisher;

-- Books
insert into book values('111','ArtificalDumbness','Inedition',2021);
insert into book values('112','SmallBrainBigBrain','Editorist',2020);
insert into book values('113','LearingSnekLang.','OverWrite',2023);
insert into book values('114','1000IQMoments','Editorist',2020);
insert into book values('115','UrbanDictionary','Inedition',2019);
insert into book values('116','BigSmallTalk','Editorist',2018);
insert into book values('117','AdvancedMemes','Inedition',2018);
select * from book

-- Library Branch
insert into library_branch values('111','GrandOrder','Delhi_N01');
insert into library_branch values('112','Fate','Delhi_N12');
insert into library_branch values('113','Levelling','Mumbai_S01');
select * from library_branch;

-- Book Author
insert into book_authors values('111','JK_Kidding'); 
insert into book_authors values('112','JK_Kidding');
insert into book_authors values('113','SirGohan');
insert into book_authors values('114','MoistCritikal');
insert into book_authors values('115','MoistCritikal');
insert into book_authors values('116','JK_Kidding');
insert into book_authors values('117','JK_Kidding');
select * from book_authors;

-- Book_Copies
insert into book_copies values('111','111',10);
insert into book_copies values('112','111',32);
insert into book_copies values('113','111',52);
insert into book_copies values('114','111',65);
insert into book_copies values('115','111',76);
insert into book_copies values('111','112',876);
insert into book_copies values('112','112',456);
insert into book_copies values('113','112',465);
insert into book_copies values('114','112',345);
insert into book_copies values('115','112',764);
insert into book_copies values('116','111',35);
insert into book_copies values('117','111',74);
insert into book_copies values('116','112',45);
insert into book_copies values('117','112',76);
insert into book_copies values('117','112',76);
insert into book_copies values('117','113',0);
insert into book_copies values('112','113',0);
select * from book_copies;

-- Book Lending
insert into book_lending values('111','111','20001','2023-01-01','2023-02-01');
insert into book_lending values('112','112','20001','2023-01-01','2023-02-01');
insert into book_lending values('112','111','20002','2023-02-01','2023-03-01');
insert into book_lending values('113','111','20002','2023-04-01','2023-04-16');
insert into book_lending values('113','111','20003','2023-03-01','2023-04-01');
insert into book_lending values('111','111','20003','2023-03-01','2023-04-01');
insert into book_lending values('112','111','20003','2023-03-01','2023-04-01');
insert into book_lending values('114','111','20003','2023-03-01','2023-04-01');
insert into book_lending values('115','111','20003','2023-03-01','2023-04-01');
insert into book_lending values('114','111','20004','2023-01-12','2023-02-12');
insert into book_lending values('115','112','20005','2023-01-23','2023-02-23');
insert into book_lending values('114','112','20005','2023-03-23','2023-04-23');
insert into book_lending values('113','112','20005','2023-02-23','2023-03-23');
insert into book_lending values('111','112','20005','2023-04-23','2023-05-23');
insert into book_lending values('112','112','20005','2023-02-23','2023-03-23');
insert into book_lending values('112','112','20006','2023-02-01','2023-03-01');
select * from book_lending;




-- All Tables
select * from publisher
select * from book
select * from library_branch
select * from book_authors
select * from book_copies
select * from book_lending;
