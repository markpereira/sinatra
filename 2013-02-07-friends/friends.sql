-- this is called a schema

create table friends
(
  id serial4 primary key,
  name varchar(100),
  age integer,
  gender varchar(1),
  image varchar(200),
  twitter_name varchar(20),
  github_name varchar(20)
);
