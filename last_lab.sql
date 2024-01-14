create view Student_cant_think_of_a_name_view as
select S.student_id, CONCAT(first_name, '', last_name) as full_name, course_id, grade
from students S
         join grades G on S.student_id = G.student_id;

-- 2. Applications of MySQL triggers:
/*
Data validation and integrity: Enforce rules and prevent invalid data entry.
Automation: Trigger actions are based on events, like triggering additional actions or updating related tables.
Trigger updates based on changes in other tables=> Maintain consistency within a database.
Security?: I've tried once SQL injecting MyGJU but failed miserably, I think there was a Trigger that ensured that
 the Query was safe to execute by restricting that Query to Actions only defined on that Trigger on Inserting.

 */

-- 3.
DELIMITER BATATA
CREATE TRIGGER after_student_insert
    AFTER INSERT
    ON students
    FOR EACH ROW
BEGIN
    INSERT INTO grades (student_id, course_id, grade)
    VALUES (NEW.student_id, 'CS115', 0);
END BATATA
DELIMITER ;

-- 4.
-- because CS115 doesn't exist from the Foreign key constraint required in the previous Lab
INSERT INTO courses (course_id, course_name, credits)
VALUES ('CS115', 'unnecessary Fundamentals', 3);

INSERT INTO students
VALUES (1000, 'folan', 'al-folani', '3000-01-01', 'test@test.test');

select g.*
from grades g
         join students s on g.student_id = s.student_id
where s.first_name = 'folan';
-- return | 17 | 1000 | CS115 | 0 | which mean Trigger is working

-- 5.
DELIMITER kartoffel
create TRIGGER grades_bef_insert_trrg
    before insert
    on grades
    for each row
begin
    if NEW.grade = 0 then
        set new.grade = 35;
    end if;
end kartoffel
delimiter ;

-- 6.
ALTER TABLE grades ADD COLUMN grade_status VARCHAR(20) DEFAULT NULL;

DELIMITER zzzzz
CREATE TRIGGER bef_grade_updt
BEFORE UPDATE ON grades
FOR EACH ROW
BEGIN
    IF NEW.grade >= 90 THEN
        SET NEW.grade_status = 'EXCELLENT';
    ELSEIF NEW.grade >= 75 THEN
        SET NEW.grade_status = 'VERY GOOD';
    ELSEIF NEW.grade >= 60 THEN
        SET NEW.grade_status = 'GOOD';
    ELSEIF NEW.grade >= 40 THEN
        SET NEW.grade_status = 'AVERAGE';
    ELSE
        SET NEW.grade_status = 'NOT PROMOTED';
    END IF;
END zzzzz
DELIMITER ;

UPDATE grades SET grade =39 WHERE student_id = 202110739;

-- 7.
DELIMITER Delimitterrr
CREATE PROCEDURE fakefunction_select_grades()
BEGIN
    select * from grades;
END Delimitterrr
DELIMITER ;

-- 8.
DELIMITER loremipsum..._________
CREATE PROCEDURE fetchStudentDetails(IN s_id BIGINT)
BEGIN
    SELECT * FROM students WHERE student_id = s_id;
END loremipsum..._________
DELIMITER ;

-- 9.
delimiter _*---*_
create procedure avgGrades(out average_grade decimal(5,2))
begin
    select avg(grade) into average_grade from grades;
END _*---*_
DELIMITER ;

-- 10.
set global log_bin_trust_function_creators = 1;
delimiter $
create FUNCTION spUpdateCounter(init_val int, increment_by int)  -- had a weird bug, for some reason FUNCTION was only working on Capital-case, even in this Comment, Lesson learned !set delim as f u n c.
returns int
begin
    declare updated_counter int;
    set updated_counter = init_val + increment_by;
    return updated_counter;
end $
delimiter ;
SET GLOBAL log_bin_trust_function_creators = 0;

SET @counter=10;
CALL UniversityDB.spUpdateCounter(@counter,3);
SELECT @counter;

-- 11.
delimiter those
create procedure countStudentsWhoGenerateProfit(out c_below_avg int)
begin
    declare avg_grade decimal(5,2);
    select avg(grade) into avg_grade from grades;
    select count(*) into c_below_avg from grades where grade < avg_grade;
END those
delimiter ;
