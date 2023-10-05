show databases;
create database if not exists first_example;
use first_example;
CREATE TABLE person(
	person_id smallint unsigned,
	fname varchar(20),
	lanme varchar(20),
	gender enum("M","F"),
	birth_date DATE,
	street varchar(30),
	city varchar(20),
	state varchar(20),
	country varchar(20),
	postal_code varchar(20),
    constraint pk_person primary key (person_id)
);

CREATE TABLE favorite_food(
	person_id smallint unsigned,
    food varchar(20),
    constraint pk_favorite_food primary key (person_id, food),
    constraint fk_favorite_food_person foreign key (person_id) 
    references person(person_id)
);

insert into person values ("0", "Joao", "Silva", "M", "2002-09-22",
"rua tal", "cidade n", "sp", "brasil", "12345-111"),
 ("1", "Joana", "Maria", "F", "2000-01-27",
"rua sla", "cidade ddddd", "sp", "brasil", "13344-141"),
("2", "Carlos", "Santos", "M", "1992-03-24",
"rua tal", "cidade n", "sp", "brasil", "12345-111");

insert into favorite_food values (0, "lasanha"), (2, "churrasco"), (1, "massas");]
