USE Ex_library;


-- BOOK(Book_id*, Title, Publisher_Name, Pub_Year)
-- BOOK_AUTHORS(Book_id*, Author_Name*)
-- PUBLISHER(Name*, Address, Phone)
-- BOOK_COPIES(Book_id*, Branch_id*, No-of_Copies)
-- BOOK_LENDING(Book_id*, Branch_id*, Card_No*, Date_Out, Due_Date)
-- LIBRARY_BRANCH(Branch_id*, Branch_Name, Address)


CREATE TABLE publisher
(
	name VARCHAR(25),
	address VARCHAR(30),
	phone bigint,
	PRIMARY KEY(name)
);

CREATE TABLE book
(
	book_id VARCHAR(5),
	title VARCHAR(15),
	publisher_name VARCHAR(25),
	pub_year INT,
	PRIMARY KEY(book_id),
	FOREIGN KEY (publisher_name) REFERENCES publisher(name) ON DELETE CASCADE
);


CREATE TABLE library_branch
(
	branch_id VARCHAR(5),
	branch_name VARCHAR(15),
	address VARCHAR(30),
	PRIMARY KEY(branch_id)
);

CREATE TABLE book_authors
(
	book_id VARCHAR(5),
	author_name VARCHAR(25),
	PRIMARY KEY(book_id, author_name),
	FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE
);

CREATE TABLE book_copies
(
	book_id VARCHAR(5),
	branch_id VARCHAR(5),
	no_of_copies INT,
	PRIMARY KEY(book_id, branch_id),
	FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
	FOREIGN KEY (branch_id) REFERENCES library_branch(branch_id) ON DELETE CASCADE
);

CREATE TABLE book_lending
(
	book_id VARCHAR(5),
	branch_id VARCHAR(5),
	card_no VARCHAR(5),
	date_out DATE,
	dur_date DATE,
	PRIMARY KEY(book_id, branch_id, card_no),
	FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
	FOREIGN KEY (branch_id) REFERENCES library_branch(branch_id) ON DELETE CASCADE
);

-- PUBLISHER(Name*, Address, Phone)
INSERT INTO publisher VALUES 
('Publisher A', 'S1-Banglore', 923456789),
('Publisher B', 'S2-Manglore', 743426788),
('Publisher C', 'S3-Mysore', 453436787),
('Publisher D', 'S4-Chennai', 363446786);

-- BOOK(Book_id*, Title, Publisher_Name, Pub_Year)
INSERT INTO book VALUES 
('111', 'Inspire', 'Publisher A', 2000),
('112', 'Admier', 'Publisher B', 2001),
('113', 'Conquest', 'Publisher D', 2002),
('114', 'Wish', 'Publisher B', 2003),
('115', 'Love', 'Publisher A', 2004),
('116', 'Life', 'Publisher D', 2005),
('117', 'Believe', 'Publisher A', 2006),
('118', 'See', 'Publisher A', 2007),
('119', 'Honest', 'Publisher D', 2008),
('120', 'Sense', 'Publisher D', 2009);

-- BOOK_AUTHORS(Book_id*, Author_Name*)
INSERT INTO book_authors VALUES
('111', 'Richard'),
('112', 'Watson'),
('113', 'Raiden'),
('114', 'Toast'),
('114', 'Bread'),
('114', 'Sandwitch'),
('114', 'Lemon'),
('115', 'Bread'),
('116', 'Sandwitch'),
('117', 'Lemon'),
('118', 'June'),
('118', 'May'),
('118', 'Lemon'),
('118', 'April'),
('119', 'May'),
('120', 'April');

-- LIBRARY_BRANCH(Branch_id*, Branch_Name, Address)
INSERT INTO library_branch VALUES
('1000', 'Branch A', 'Udupi'),
('1001', 'Branch C', 'Delhi'),
('1002', 'Branch B', 'Indore');

-- BOOK_COPIES(Book_id*, Branch_id*, No-of_Copies)
INSERT INTO book_copies VALUES
('111', '1000',10),
('111', '1001',12),
('111', '1002',4),

('112', '1000',30),
('112', '1001',0),
('112', '1002',0),

('113', '1000',11),
('113', '1001',13),
('113', '1002',14),

('114', '1000',1),
('114', '1001',2),
('114', '1002',4),

('115', '1000',30),
('115', '1001',22),
('115', '1002',14),

('116', '1000',12),
('116', '1001',13),
('116', '1002',14),

('117', '1000',1),
('117', '1001',12),
('117', '1002',42),

('118', '1000',14),
('118', '1001',12),
('118', '1002',4),

('119', '1000',10),
('119', '1001',12),
('119', '1002',4),

('120', '1000',5),
('120', '1001',6),
('120', '1002',7);


-- BOOK_LENDING(Book_id*, Branch_id*, Card_No*, Date_Out, Due_Date)
INSERT INTO book_lending VALUES
('111', '1001', '11', '2017-07-10', '2017-07-20'),
('111', '1001', '12', '2017-07-13', '2017-07-23'),
('114', '1000', '14', '2017-07-05', '2017-07-15'),
('115', '1000', '14', '2017-06-10', '2017-06-20'),
('116', '1000', '14', '2017-07-15', '2017-07-25'),
('111', '1001', '13', '2017-03-23', '2017-04-02'),
('111', '1001', '15', '2017-03-20', '2017-03-30'),
('113', '1002', '16', '2017-04-02', '2017-04-12'),
('113', '1002', '17', '2017-05-05', '2017-05-15'),
('115', '1001', '13', '2017-02-02', '2017-02-12');


SELECT * FROM publisher;
SELECT * FROM book;
SELECT * FROM book_authors;
SELECT * FROM library_branch;
SELECT * FROM book_copies;
SELECT * FROM book_lending;


-- BOOK(Book_id*, Title, Publisher_Name, Pub_Year)
-- BOOK_AUTHORS(Book_id*, Author_Name*)
-- PUBLISHER(Name*, Address, Phone)
-- BOOK_COPIES(Book_id*, Branch_id*, No-of_Copies)
-- BOOK_LENDING(Book_id*, Branch_id*, Card_No*, Date_Out, Due_Date)
-- LIBRARY_BRANCH(Branch_id*, Branch_Name, Address)


-- Q. Retrieve details of all books in the library - id, name of publisher, authors, number of copies in each branch 
SELECT b.book_id, b.title, b.publisher_name, ba.author_name, bc.branch_id, bc.no_of_copies
FROM book b, book_authors ba, book_copies bc
WHERE b.book_id=ba.book_id AND
b.book_id = bc.book_id;

-- Q.Get the particulars of borrowers who have borrowed more than 3 books but from Jan 2017 TO Jun 2017
SELECT bl.card_no 
FROM book_lending bl
WHERE bl.date_out BETWEEN '2017-01-01' AND '2017-07-30'
GROUP BY card_no
HAVING COUNT(bl.card_no)>=3;


-- Q. Get the particulars of book with more than 3 Authors
select b.book_id
FROM book b, book_authors ba
WHERE b.book_id = ba.book_id
GROUP BY b.book_id
HAVING COUNT(ba.author_name)>3;

-- Q. Delete a book in table
DELETE FROM book 
WHERE book_id = '120';

-- Q. Create a view of all books and its number of copies that are currently available in the library

CREATE VIEW books_remain AS(
	select book_id,sum(no_of_copies) - (select count(card_no) from book_lending
	where b.book_id = book_id) as avail_copies
	from book_copies b group by book_id
);

SELECT * FROM books_remain;

-- Q. Retrieve the details of publisher who published more than 3 books
SELECT p.name, p.address, p.phone 
FROM publisher p, book b
WHERE b.publisher_name=p.name
GROUP BY p.name, p.address, p.phone
HAVING COUNT(p.name)>3;

SELECT publisher_name
FROM book
GROUP BY publisher_name
HAVING COUNT(book_id) > 3;


-- Q. Retrieve the details of publisher who published NO books

SELECT name 
FROM publisher
WHERE name NOT IN
(
	SELECT DISTINCT publisher_name
	FROM book
);

-- Q. Get the particulars of Library Branch which has 0 copies of book with id 112
SELECT branch_id, branch_name, address
FROM library_branch
WHERE branch_id IN
(SELECT branch_id 
FROM book_copies
WHERE book_id='112'AND no_of_copies=0)

-- BOOK(Book_id*, Title, Publisher_Name, Pub_Year)
-- BOOK_AUTHORS(Book_id*, Author_Name*)
-- PUBLISHER(Name*, Address, Phone)
-- BOOK_COPIES(Book_id*, Branch_id*, No-of_Copies)
-- BOOK_LENDING(Book_id*, Branch_id*, Card_No*, Date_Out, Due_Date)
-- LIBRARY_BRANCH(Branch_id*, Branch_Name, Address)
