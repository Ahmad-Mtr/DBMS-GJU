use UniversityDB;
-- 1. Create a view that display the student_id with concatenate the first name with the
-- last name with each course_id and grade from grades table.
create view Student_cant_think_of_a_name_view as
select S.student_id, CONCAT(first_name, '', last_name) as full_name, course_id, grade
from students S
         join grades G on S.student_id = G.student_id;

-- 3. create trigger to add an entry in the grades table after every INSERT in the
-- student’s table. Note: default grade equal 0, default course_id CS115.
delimiter Zitrone
create trigger das_trigger
    after insert
    on students
    for each row
begin
    insert into grades (student_id, course_id, grade)
    values (NEW.student_id, 'CS115', 0);
end Zitrone
delimiter ;

-- 4. check if the corresponding record in the grades table has been created or not.


-- 5. Create trigger before every insert in grades table if the new inserted grade
-- equal 0% then set the value to 35%.
delimiter FOOOOOOOOO
create trigger der_trigger
    before insert
    on grades
    for each row
begin
    update grades set grade = 35 where grade = 0;
end FOOOOOOOOO
delimiter ;

-- 6. Add new column called Grade-Status as varchar (20) to the grades table
-- set default null, then create a trigger before update to set the value for each
-- row in this new column
-- status (will be stored GRADE_status column):
-- If GRADE >=90 -> 'EXCELLENT'
-- If GRADE >=75 AND GRADE <90 -> 'VERY GOOD'
-- -If GRADE >=60 AND GRADE <75 -> 'GOOD'
-- If GRADE >=40 AND GRADE <60 -> 'AVERAGE'
-- If GRADE <40-> 'NOT PROMOTED'

-- Sol.
-- 1- Add Column `Grade-Status`
alter table grades
add  column Grade_Status varchar(20) null;
-- 2. Add Trigger
delimiter batatata
create trigger _gradeTrigger before update on grades for each row
    begin
        if grade >=90 then
            set grade_status = 'Excellent';
        elseif grade >= 75 then

        end if batatata
    end batatata
delimiter ;