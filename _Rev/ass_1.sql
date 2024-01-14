-- Create a database, call it “UniversityDB
create schema universityDB;


-- Inside the UniversityDB create 3 tables as follow
create table students
(
    student_id    int Primary key,
    first_name    varchar(15) not null,
    last_name     varchar(15),
    date_of_birth date,
    email         varchar(50) unique
);
create table courses
(
    course_id   varchar(10) Primary key,
    course_name varchar(30) not null,
    credits     int
);


create table grades
(
    grade_id   int Primary key auto_increment,
    student_id int,
    course_id  int,
    grade      int,
    constraint FK_S Foreign key (student_id) references students (student_id),
    constraint FK_C Foreign key (course_id) references courses (course_id),
    Check (grade between 0 and 100)
);

alter table grades
    auto_increment = 10;


-- 3.
insert into students(student_id, first_name, last_name, date_of_birth, email)
values (202120580, 'Ali', 'Osama', 18 - 03 - 2003, 'ali.osama@gju.edu.jo'),
       (202110739, 'Aseel', 'Adam', 27 - 09 - 2003, 'aseel.adam@gju.edu.jo'),
       (202022453, 'Fatimah', 'Ahmad', 02 - 04 - 2002, 'fatimah.ahmad@gju.edu.jo'),
       (202219876, 'Ahmad', 'Zaid', 07 - 08 - 2004, 'ahmd.zaid@gju.edu.jo')
;

-- 5.
insert into students(student_id, first_name, last_name, date_of_birth, email)
VALUES (202202220222022, 'aaa', 'abatata', 18 - 12 - 2003, 'adsadsad@asdasd.com');

-- 10 9- Create a table called gradeCopy
-- by selecting the student full name, the course
-- name and the grade.

create table gradecopy as
select concat(s.first_name, ' ', s.last_name) as full_name, c.course_name as course_name, g.grade as grade_
from students s
         join courses c
         join grades g on s.student_id = g.student_id AND g.course_id = c.course_id;

-- Then modify the table to have
-- the student name and course name
-- as composite primary key.
alter table gradeCopy
add constraint pk_adasdas primary key(student_name,course_name);