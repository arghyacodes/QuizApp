create database QuizDB;

use QuizDB;

create table user(
id int primary key auto_increment,
username varchar(32),
password varchar(32) not null
);

drop table user;

insert into user
values
(404, 'user', 'user@123');

create table admin(
id int primary key auto_increment,
username varchar(32) unique not null,
password varchar(32) not null
);

insert into admin
values
(1,'admin', 'admin@123');


create table question(
id int primary key auto_increment,
category varchar(100) not null,
questionText varchar(255) not null,
optionA varchar(100) not null,
optionB varchar(100) not null,
optionC varchar(100) not null,
optionD varchar(100) not null,
correctOption char(1) not null
);

insert into question
values
(1000,'Java', 'which one is not keyword ?','class', 'interface','abstract','tiffin', 'D');

create table quiz(
id int primary key auto_increment,
name varchar(255) not null,
category varchar(100) not null
);


create table quiz_question(
quiz_id int,
question_id int,
primary key(quiz_id, question_id),
foreign key(quiz_id) references quiz(id),
foreign key (question_id) references question(id)
);


create table result(
id int primary key auto_increment,
user_id int,
quiz_id int,
score int,
foreign key (user_id) references user(id),
foreign key (quiz_id) references quiz(id)
);