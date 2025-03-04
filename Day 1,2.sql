show databases;
create database pdb1;
use pdb1;
create table students (sid integer,
sname char(30), age integer,
course char(30));
show tables;
select * from students;
insert into students values(1,'Shreyash',26,'Mysql');
select * from students;
insert into students values(2,'Shubham',22,'Mysql');
insert into students values(3,'Vijay',23,'Mysql');
insert into students values(4,'Siddhesh',20,'Mysql');
select * from students;
show tables;

-- Null Datatype DAY 2
select 5+5 as result;
select "Hello" as greetings;
select 5=5 as result;
select 5!=5 as result; -- != / <> are used here for "Not Equal to"
select 5<>5 as result;
select 5+null as result;
create table patients(pid integer,pname varchar(255),dob date,toa datetime);
show tables;
desc patients;
insert into patients values(1,'Harry','2000-05-26','2023-04-04 08:30:00');
insert into patients values(2,'Potter','2000-06-26','2023-04-05 09:30:00');

-- Alter Command: used to change the following:
-- table name: rename
-- column name: change column
-- data type:  modify column
-- no. of columns: add & drop column

select * from students;
alter table students add column marks integer default 0;    -- To Add Column
select * from students;
alter table students drop column course;    -- To Delete Column
select * from students;
alter table students change column sid std_id integer;    -- To change name of the column
select * from students;
desc students;
alter table students modify column sname varchar(30);
desc students;
alter table students rename to myclass;   -- Rename table name
show tables;

-- RENAME COMMAND
rename table myclass to students;
show tables;

-- INSERT COMMAND
select * from students;
insert into students values(5,'John',null,50);      -- TYPE 1 INSERT
select * from students;
insert into students(std_id,sname) values(6,'Jim');      -- TYPE 2 INSERT
select * from students;
insert into students values(8,'Shrutika',20,99),(9,'Shru',20,90),(10,'Varad',20,80);     -- TYPE 3 INSERT
select * from students;

-- DML UPDATE COMMAND
update students set sname='Natasha' where std_id=10;
set sql_safe_updates=0;
select * from students;
update students set marks=null where marks=0;
select * from students;
update students set age='45', marks=85 where std_id=9;      -- Change 2 values at the same time
select * from students;

-- DML DELETE COMMAND
delete from students where std_id=1;
select * from students;
delete from students where marks=null;      -- This will not delete null values so use 'is null' instead of '='
select * from students;
delete from students where marks is null;
select * from students;
delete from students;
select * from students;

-- INSERT 3 RECORDS IN THE TABLE
insert into students values (1,'Shreyash',27,99);
insert into students values (1,'Shrutika',23,90);
insert into students values (1,'Shru',20,80);
select * from students;

delete from students;
select * from students;

insert into students values (1,'Shreyash',27,99);
insert into students values (2,'Shrutika',23,90);
insert into students values (3,'Shru',20,80);
select * from students;
use pdb1;
-- DDL TRUNATE COMMAND
truncate students;
select * from students;
show create table students;
select * from students;
select * from myemp limit 10;
select * from myemp limit 10 offset 20;
select emp_id,first_name,salary,dep_id from myemp;
select emp_id,first_name,salary,dep_id from myemp limit 10;

-- ADD DERIVED COLUMN
select emp_id,first_name,salary,salary*0.2 as bonus from myemp limit 10;        -- New Derived column (Only for Display Purpose; not available in the table) added with the help of ALIAS using keyword "AS"
-- ADD ONE MORE COLUMN OF TOTAL SALARY
select emp_id,first_name,salary,salary*0.2  as Bonus,salary+salary*0.2 as Total_Salary from myemp limit 10;

-- FIND UNIQUE DEP_ID FROM COLUMN
select dep_id from myemp;         -- It will show all dep_id (including duplicates)
select distinct dep_id from myemp;          -- Only UNIQUE ID'S(excluding duplicates) will be displayed with the help of "DISTINCT" keyword
select distinct job_id from myemp;

-- FIND UNIQUE FIRST NAMES & UNIQUE LAST NAMES FROM TABLE
select * from person;
select distinct fname from person;        -- UNIQUE FIRST NAMES
select distinct lname from person;        -- UNIQUE LAST NAMES
select distinct fname,lname from person;        -- WILL GIVE UNIQUE FIRST NAME + LAST NAME COMBINATION

-- ORDER BY CLAUSE (Ascending & Descending)
-- Change order of columns - Only for display purpose

select * from myemp;
select * from myemp order by dep_id;      -- (order by- by default it is in ascending order)

-- Sort in DESCENDING ORDER
select * from myemp order by dep_id desc;       -- (Descending order with the help of "DESC" keyword)

select * from books;
select * from orders;
select * from myemp;
set global log_bin_trust_function_creators=1;

delete from orders;
alter table orders auto_increment=1;
call pdb1.place_order();

select emp_id,first_name,hire_date,experience(emp_id) as Exp from myemp;
update books set sales=sales+5 where bookid=7;
select * from books;
update books set sales=sales+9 where bookid=14;
select * from books;
select * from book_sales;
select * from marks;



