-- Perform Selection	

-- -- -- Notes 
-- In [].book_id, [] is called as a alias.

USE LibraryDB
-- Q. Retrieve details of all book in the library - id, title, name of publisher, authors, number of copies in each brancch etc.(INCLUDED)
select b.book_id, b.title, b.pub_name, ba.author_name, bc.branch_id, bc.no_of_copies from book b, 
book_authors ba, book_copies bc where b.book_id = bc.book_id and b.book_id = ba.book_id;

-- Q. Get the particular of borrowers who have borrowed more than 2 books, but from certrain date(INCLUDED)
select * from book_lending;
select distinct card_no from book_lending where (date_out between '2023-02-01' and '2023-04-01') group by card_no having count(*)>2;

-- Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation.(INCLUDED)
-- delete from book where book_id = '116';

-- Create a view of all books and its number of copies that are currently available in the Library(INCLUDED)
create view available as
(
select book_id,sum(no_of_copies) -
(select count(card_no) from book_lending
where b.book_id = book_id) as avail_copies
from book_copies b group by book_id
);
select * from available;




-- -- EXTRA
-- Q. Retrieve the details of publishers without any books.
select p.name, p.address, p.phone from publisher p
where not exists(select pub_name from book where pub_name=p.name);

-- Q. Retrieve the details of authors who have more than 3 books
select a.author_name from book_authors a 
group by a.author_name having count(a.author_name)>3;

-- Q. Details of publishers who published more than 2 books.
select p.name from publisher p, book b where p.name = b.pub_name group by p.name having count(p.name)>2;
