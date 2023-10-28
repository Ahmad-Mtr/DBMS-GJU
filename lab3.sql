# Question 1
-- 1.
select *
from students;
-- 2.
select *
from students
where grade = 12;
-- 3.
select *
from students
where math_score > 90;
-- 4.
select COUNT(id)
from students;
-- 5.
select count(gender)
from students
group by gender;
-- 6.
select *
from students
order by biology_score DESC;
-- 7.
select AVG(age)
from students;
-- 8.
select count(grade)
from students
group by grade;
-- 9.
select avg(math_score)      as AVG_Math,
       avg(physics_score)   as AVG_Physics,
       avg(chemistry_score) as AVG_chemistry,
       avg(biology_score)   as AVG_Biology
from students;

-- 10.
select *
from students
where chemistry_score in (select min(chemistry_score) from students);

-- 11.
select AVG(math_score)
from students;

-- 12.
select AVG(math_score) as _avg
from students
group by gender;

-- 13.
select *
from students
where first_name LIKE 'A%';

-- 14.
select AVG(age)
from students
where gender = 'Male';

-- 15.
select *
from students
where math_score in (select max(math_score) from students);
-- 16.
select COUNT(id)
from students
where math_score > 80
  AND physics_score > 80
  AND chemistry_score > 80
  AND biology_score > 80;


-- 17.
select *
from students
where (math_score+physics_score+chemistry_score+biology_score)/4 > 85;

-- 18.
select *
from students
where math_score in (select math_score from students group by math_score having COUNT(math_score) > 1)
order by math_score ASC;

-- 19.
select *
from students
where biology_score > math_score;

-- 20.
select *
from students
where math_score = biology_score
  AND math_score = physics_score
  AND math_score = chemistry_score;

-- 21.
select COUNT(id)
from students
where math_score in (select math_score from students where math_score > 90)
   OR physics_score in (select physics_score from students where physics_score > 90)
   OR chemistry_score in (select chemistry_score from students where chemistry_score > 90)
   OR biology_score in (select biology_score from students where biology_score > 90);

-- 22.
select *
from students
where (grade, math_score) in (select grade, MAX(math_score) from students group by grade)
;

-- 23.
# ALTER TABLE students ADD total_score int;
# update students set total_score = math_score+physics_score+chemistry_score+biology_score;
select *
from students
where (grade, total_score) in (select grade, MAX(students.total_score) from students group by grade);

-- 24.
SELECT *
FROM students _s1
WHERE (
    SELECT COUNT(*)
    FROM students _s2
    WHERE _s2.grade = _s1.grade AND _s2.total_score >= _s1.total_score
) <= 9
ORDER BY _s1.grade, _s1.total_score DESC;

-- 25.
select * from students
where math_score in (select math_score from students where math_score - physics_score >= 10 OR
                                                           math_score - chemistry_score >= 10 OR
                                                           math_score - biology_score >= 10);
-- 26.
select * from students _s1
where (select count(*) from students _s2
                       where _s2.total_score =_s1.total_score) > 1
order by total_score ASC;

-- 27.
select *, total_score/4 as _Avg from students _s1
where (select count(*) from students _s2
                       where _s2.total_score =_s1.total_score) > 1
order by _Avg ASC;