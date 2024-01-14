-- Trigger
DELIMITER BATATA
CREATE TRIGGER TRIGGER_NAME
    AFTER INSERT
    ON TABLE_NAME
    FOR EACH ROW
BEGIN
    /* QUERY goes here*/

END BATATA
DELIMITER ;

--  Trigger with Conditionals
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


-- Procedure with parameters.
DELIMITER loremipsum..._________
CREATE PROCEDURE fetchStudentDetails(IN s_id BIGINT) -- IN: a Parameter Variable
BEGIN
    SELECT * FROM students WHERE student_id = s_id;
END loremipsum..._________
DELIMITER ;

-- Procedure with a return Value.
delimiter _*---*_
create procedure avgGrades(out average_grade decimal(5,2))  -- out: equivelant of a value that's going to be returned
begin
    select avg(grade) into average_grade from grades;
END _*---*_
DELIMITER ;


-- Procedure with declared Variables.
delimiter those
create procedure countStudentsWhoGenerateProfit(out c_below_avg int)
begin
    declare avg_grade decimal(5,2);  -- Declare declares a Variable
    select avg(grade) into avg_grade from grades;
    select count(*) into c_below_avg from grades where grade < avg_grade;
END those
delimiter ;

-- Function
delimiter $
create FUNCTION spUpdateCounter(init_val int, increment_by int)
returns int
begin
    declare updated_counter int;
    set updated_counter = init_val + increment_by;
    return updated_counter;
end $
delimiter ;

-- Function Call
SET @counter=10;
CALL UniversityDB.spUpdateCounter(@counter,3);
SELECT @counter;

