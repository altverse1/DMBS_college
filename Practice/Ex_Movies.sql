USE Ex_Movies;



-- ACTOR(Act_id, Act_Name, Act_Gender) 
-- DIRECTOR(Dir_id, Dir_Name, Dir_Phone) 
-- MOVIES(Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id) 
-- MOVIE_CAST(Act_id, Mov_id, Role) 
-- RATING(Rat_id,Mov_id, Rev_Stars) 

CREATE TABLE actor
(
	act_id			VARCHAR(5),
	act_name		VARCHAR(25),
	act_gender		VARCHAR(10),
	PRIMARY KEY(act_id)
);

CREATE TABLE director
(
	dir_id			VARCHAR(5),
	dir_name		VARCHAR(25),
	dir_phone		BIGINT,
	PRIMARY KEY(dir_id)
);

CREATE TABLE movies
(
	mov_id			VARCHAR(5),
	mov_title		VARCHAR(50),
	mov_year		INT,
	mov_lang		VARCHAR(10),
	dir_id			VARCHAR(5),
	PRIMARY KEY(mov_id),
	FOREIGN KEY(dir_id) REFERENCES director(dir_id) ON DELETE CASCADE
);

CREATE TABLE movie_cast
(
	act_id			VARCHAR(5),
	mov_id			VARCHAR(5),
	role			VARCHAR(10),
	PRIMARY KEY(act_id, mov_id),
	FOREIGN KEY(act_id) REFERENCES actor(act_id) ON DELETE CASCADE,
	FOREIGN KEY(mov_id) REFERENCES movies(mov_id) ON DELETE CASCADE 
);

CREATE TABLE rating
(
	rat_id			VARCHAR(10),
	mov_id			VARCHAR(5),
	rev_stars		INT,
	PRIMARY KEY(rat_id),
	FOREIGN KEY(mov_id) REFERENCES movies(mov_id) ON DELETE CASCADE
);


-- ACTOR(Act_id, Act_Name, Act_Gender)
INSERT INTO actor VALUES
('001', 'James', 'Male'),
('002', 'Jesse', 'Female'),
('003', 'Ash', 'Male'),
('004', 'Misty', 'Female'),
('005', 'Brock', 'Male'),
('006', 'Serena', 'Female'),
('007', 'Clemont', 'Male'),
('008', 'Oak', 'Male'),
('009', 'May', 'Female'),
('010', 'Dawn', 'Female');

-- DIRECTOR(Dir_id, Dir_Name, Dir_Phone) 
INSERT INTO director VALUES
('001','Hitchcock',123456789),
('002','Steven Spielberg',987654321),
('003','Christopher Nolan',987656789);

-- MOVIES(Mov_id, Mov_Title, Mov_Year, Mov_Lang, Dir_id) 
INSERT INTO movies VALUES
('001','Pkmn Beginning', 1990, 'English', '001'),
('002','Pkmn Journey', 1995, 'English', '001'),
('003','Pkmn Defeat', 2000, 'English', '001'),
('004','Pkmn MAX', 2005, 'Japanese', '002'),
('005','Pkmn Legend', 2005, 'English', '002'),
('006','Pkmn Victory', 2010, 'English', '002'),
('007','Pkmn Epic', 2020, 'Japanese', '003');

-- MOVIE_CAST(Act_id, Mov_id, Role) 
INSERT INTO movie_cast VALUES
('003','001','Lead'),
('001','002','Side'),
('002','002','Side'),
('003','002','Lead'),
('004','002','Main'),
('005','002','Main'),
('001','003','Lead'),
('002','003','Main'),
('003','004','Lead'),
('005','004','Main'),
('009','004','Main'),
('003','005','Lead'),
('005','005','Main'),
('010','005','Main'),
('003','006','Lead'),
('005','006','Main'),
('004','006','Main'),
('003','007','Lead'),
('007','007','Main'),
('006','007','Main'),
('001','007','Side'),
('002','007','Side'),
('008','007','Side');

-- RATING(Rat_id,Mov_id, Rev_Stars) 
INSERT INTO rating VALUES
('001','001',10),
('002','001',8),
('003','001',9),
('004','002',10),
('005','003',8),
('006','004',4),
('007','005',3),
('008','006',2),
('009','007',9),
('010','002',10),
('011','003',8),
('012','004',5),
('013','005',4),
('014','006',4),
('015','007',10),
('016','007',9);


SELECT * FROM actor;
SELECT * FROM director;
SELECT * FROM movies;
SELECT * FROM movie_cast;
SELECT * FROM rating;

-- 1. List the titles of all movies directed by ‘Hitchcock’.
SELECT m.mov_title
FROM movies m
WHERE dir_id IN
(
	SELECT dir_id 
	FROM director
	WHERE dir_name = 'Hitchcock'
);
-- 2. Find the movie names where one or more actors acted in two or more movies. 
SELECT DISTINCT m.mov_title
FROM movies m, movie_cast mc
WHERE m.mov_id = mc.mov_id
AND
(select count(mov_id) 
FROM movie_cast 
WHERE act_id =mc.act_id)>=2;

-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation). 
SELECT a.act_name 
FROM actor a
JOIN movie_cast mc ON a.act_id = mc.act_id 
JOIN movies m ON mc.mov_id = m.mov_id
WHERE m.mov_year<2000
INTERSECT
SELECT a.act_name
FROM actor a
JOIN movie_cast mc ON a.act_id = mc.act_id 
JOIN movies m ON mc.mov_id = m.mov_id
WHERE m.mov_year>2015;

-- 4. Find the title of movies and number of stars for each movie that has at least one rating and find the highest number of stars that movie received. Sort the result by movie title. 
SELECT m.mov_title, SUM(r.rev_stars) as Total_stars, MAX(r.rev_stars) as Max_star
FROM movies m, rating r
WHERE m.mov_id = r.mov_id
GROUP BY m.mov_title, m.mov_id
ORDER BY m.mov_title;

-- 5. Update the rating of all movies directed by ‘Steven Spielberg’ to 5.
UPDATE rating 
SET rev_stars = 5
WHERE mov_id IN
(
	SELECT m.mov_id
	FROM movies m 
	WHERE dir_id IN
	(
		SELECT dir_id
		FROM director
		WHERE dir_name = 'Steven Spielberg'
	)
);

-- 6. Find the count of movies released in each year in each language. 
SELECT mov_year, mov_lang, COUNT(mov_id) AS count_movies
FROM movies
GROUP BY mov_year, mov_lang;

-- 7. Find the total number of movies directed by each director
SELECT d.dir_name, COUNT(m.mov_id) AS no_movies
FROM director d, movies m
WHERE d.dir_id = m.dir_id
GROUP BY d.dir_name