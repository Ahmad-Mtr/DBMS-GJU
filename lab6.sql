use company;
-- 1. Retrieve all columns for all employees from the Employees table.
select *
from employees;
-- 2. Display the count of employees in each department.
select COUNT(EmployeeID)
from employees
group by DepartmentID;
-- 3. Find the employee with the highest salary.
select *
from employees
where Salary = (select max(Salary) from employees);
-- ** 4. Identify the department with the lowest average salary.
select *
from departments
         join (select DepartmentID, avg(Salary) as _avg
               from employees
               group by DepartmentID
               order by avg(Salary) asc
               limit 1) as r on r.DepartmentID = departments.DepartmentID;

-- 5.**  Display the average salary for each department.
select AVG(Salary)
from employees;

-- 6. Calculate the duration (in days) of each project by subtracting the start date from the end date
select DATEDIFF(EndDate, StartDate)
from projects
;

-- 7. List employees who work in more than one department.
select
-- 8. Retrieve the projects that do not have an end date specified.

-- 9. Find the department with the highest number of employees.

-- 10. Identify projects that have overlapping time periods.
select s1.* from projects s1 join projects s2 on s1.ProjectID != s2.ProjectID
where s1.StartDate between s2.StartDate AND s2.EndDate or
 s1.EndDate between s2.StartDate AND s2.EndDate;

-- 11. Retrieve the top 5 highest-paid employees.

-- 12. Identify employees who share the same first names.

-- 13. Retrieve projects with a duration longer than 6 months.

-- 14. Identify employees who work in both the IT and Finance departments.

-- 15. Retrieve the names of projects that are scheduled to start within the next 30 days.

/* Date Functions
 CURRENT_DATE() / CURDATE(): Return the current date in 'YYYY-MM-DD' format.
 NOW() / CURRENT_TIMESTAMP(): Return the current date and time in 'YYYY-MM-DD HH:MM:SS' format.
 CURTIME(): Return the current time in 'HH:MM:SS' format.
 DATE_FORMAT(date, format): Formats a date according to the specified format. For example, DATE_FORMAT(NOW(), '%W, %M %e, %Y') returns 'Friday, November 12, 2023'.
 DAY(date): Returns the day of the month for a given date.
 MONTH(date): Returns the month for a given date.
 YEAR(date): Returns the year for a given date.
 DATEDIFF(date1, date2): Returns the difference in days between two dates.
 DATE_ADD(date, INTERVAL unit): Adds a specified value and unit to a date. For example, DATE_ADD(NOW(), INTERVAL 7 DAY) adds 7 days to the current date.
 DATE_SUB(date, INTERVAL value unit): Subtracts a specified value and unit from a date.
 LAST_DAY(date): Returns the last day of the month for a given date.
 DAYNAME (date): Returns the day name for a given date.
Unit can be one of (SECOND,MINUTE,HOUR,DAY,WEEK,MONTH,QUARTER,YEAR)
Format can be one of
Format
Meaning
%a
Abbreviated weekday name (Sun to Sat)
%W
Weekday name in full (Sunday to Saturday)
%b
Abbreviated month name (Jan to Dec)
%M
Month name in full (January to December)
%c
Numeric month name (0 to 12)
%D
Day of the month as a numeric value, followed by suffix (1st, 2nd, 3rd, ...)
%d
Day of the month as a numeric value (01 to 31)
%e
Day of the month as a numeric value (1 to 31)
%Y
Year as a numeric, 4-digit value
%y
Year as a numeric, 2-digit value
You can find more functions and formats
https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
   */

select *
from projects;
select *
from departments;
select *
from employees;
