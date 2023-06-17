USE MovieDB_ai012;

--Creating Table ACTOR
create table actor
(
	act_id varchar(5) PRIMARY KEY,
	act_name varchar(15),
	act_gender varchar(6),
);
--Creating Table DIRECTOR
create table director
(
	 dir_id varchar(5) PRIMARY KEY	,
	 dir_name varchar(15),
	 dir_phone bigint,
);
--Creating Table MOVIES
create table movies
(
	mov_id varchar(5) PRIMARY KEY,
	mov_title varchar(25),
	mov_year int,
	mov_lang varchar(10),
	dir_id varchar(5),
	foreign key(dir_id) references director(dir_id) on delete cascade
);

--Creating Table Movie Cast
create table movie_cast
(
	act_id varchar(5),
	mov_id varchar(5),
	role varchar(10),
	primary key(act_id, mov_id),
	foreign key(act_id) references actor(act_id) on delete cascade,
	foreign key(mov_id) references movies(mov_id) on delete cascade
);

--Creating Table Rating
create table rating
(
	rat_id varchar(5) PRIMARY KEY,
	mov_id varchar(5),
	rev_stars int,
	foreign key(mov_id) references movies(mov_id) on delete cascade
	
);

-- Inserting Values 
-- Inserting actors
INSERT INTO actor VALUES ('A001', 'Tom', 'Male');
INSERT INTO actor VALUES ('A002', 'Emma', 'Female');
INSERT INTO actor VALUES ('A003', 'Brad', 'Male');
INSERT INTO actor VALUES ('A004', 'Meryl', 'Female');
INSERT INTO actor VALUES ('A005', 'Leonardo', 'Male');
INSERT INTO actor VALUES ('A006', 'Jennifer', 'Female');
INSERT INTO actor VALUES ('A007', 'Samuel L.', 'Male');
INSERT INTO actor VALUES ('A008', 'Aamir Khan', 'Male');
INSERT INTO actor VALUES ('A009', 'R Madhavan', 'Male');



-- Inserting directors

INSERT INTO director VALUES ('D004', 'Tarantino', 5556667777);
INSERT INTO director VALUES ('D005', 'Hitchcock', 9998887777);
INSERT INTO director VALUES ('D006', 'Cameron', 4443332222);
INSERT INTO director VALUES ('D001', 'Nolan', 1234567890);
INSERT INTO director VALUES ('D002', 'Spielberg', 9876543210);
INSERT INTO director VALUES ('D003', 'Scorsese', 1112223333);
INSERT INTO director VALUES ('D007', 'Mark', 231235312);
INSERT INTO director VALUES ('D008', 'Aamir Khan', 987123555);


-- Inserting movies

INSERT INTO movies VALUES ('M004', 'Pulp Fiction', 1994, 'English', 'D004');
INSERT INTO movies VALUES ('M005', 'Psycho', 1960, 'English', 'D005');
INSERT INTO movies VALUES ('M006', 'Avatar', 2009, 'English', 'D006');
INSERT INTO movies VALUES ('M001', 'Inception', 2010, 'English', 'D001');
INSERT INTO movies VALUES ('M002', 'Jurassic Park', 1993, 'English', 'D002');
INSERT INTO movies VALUES ('M003', 'The Departed', 2006, 'English', 'D003');
INSERT INTO movies VALUES ('M007', 'Wall Street', 2013, 'English', 'D003');
INSERT INTO movies VALUES ('M008', 'Garfield', 2024, 'English', 'D007');
INSERT INTO movies VALUES ('M009', '3 Idiots', 2009, 'Hindi', 'D008');

-- Inserting movie cast
INSERT INTO movie_cast VALUES ('A004', 'M004', 'Margaret ');
INSERT INTO movie_cast VALUES ('A005', 'M004', 'Vincent');
INSERT INTO movie_cast VALUES ('A006', 'M004', 'Wallace');
INSERT INTO movie_cast VALUES ('A001', 'M001', 'Cobb');
INSERT INTO movie_cast VALUES ('A002', 'M001', 'Arthur');
INSERT INTO movie_cast VALUES ('A003', 'M001', 'Eames');
INSERT INTO movie_cast VALUES ('A005', 'M007', 'Jordan');
INSERT INTO movie_cast VALUES ('A007', 'M002', 'Arnold');
INSERT INTO movie_cast VALUES ('A007', 'M008', 'Vic');
INSERT INTO movie_cast VALUES ('A008', 'M009', 'Rancho');
INSERT INTO movie_cast VALUES ('A009', 'M009', 'Farahn');

-- Inserting movie ratings
INSERT INTO rating VALUES ('R004', 'M004', 5);
INSERT INTO rating VALUES ('R005', 'M005', 4);
INSERT INTO rating VALUES ('R006', 'M006', 4);
INSERT INTO rating VALUES ('R001', 'M001', 5);
INSERT INTO rating VALUES ('R002', 'M002', 4);
INSERT INTO rating VALUES ('R003', 'M003', 4);
INSERT INTO rating VALUES ('R007', 'M007', 5);
INSERT INTO rating VALUES ('R008', 'M008', 4);
INSERT INTO rating VALUES ('R009', 'M009', 5);


-- Q. Select all movie directed by Nolan
select m.mov_title from movies m, director d where m.dir_id =d.dir_id and d.dir_name='Nolan';

-- Q. Find movie names where one or more actors acted in two or more movies
select distinct mov_title from movies m, movie_cast mc where m.mov_id = mc.mov_id and (select count(mov_id) 
from movie_cast where act_id = mc.act_id)>=2;

-- Q. List all actors who acted in a movie before 2000 and also in a movie after 2015(use JOIN operation)
select act_name from actor a join movie_cast mc on a.act_id = mc.act_id join movies m on mc.mov_id = m.mov_id where 
m.mov_year<2004 intersect select act_name from actor a 
join movie_cast mc on a.act_id = mc.act_id join movies m on mc.mov_id = m.mov_id where m.mov_year>2010;

-- Q. Find the title of movies and number of stars for each movie that has at least one reating and find the highest number of stars that movie received. Sort the result by movie title.
SELECT mov_title, sum(rev_stars) total_stars, max(rev_stars) max_stars
FROM rating r, movies m WHERE m.mov_id = r.mov_id GROUP BY m.mov_title, m.mov_id ORDER BY m.mov_title;

-- Q. Update rating of all movies directed by 'Steven Spilberg' to 5
update rating set rev_stars=5 where mov_id in (select m.mov_id from movies m,director d where m.dir_id=d.dir_id and d.dir_name='Hitchcock');

-- Q. Find the number of movies released in each year in each language
select mov_year, mov_lang, count(mov_id) released from movies group by mov_year, mov_lang;

-- Q. Find the total number of movies directed by each director
select d.dir_id, d.dir_name, count(m.mov_id) no_directed from movies m, director d where d.dir_id=m.dir_id  group by d.dir_id, d.dir_name;
