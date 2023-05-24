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

