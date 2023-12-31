use jobs_data;
-- 1.
CREATE TABLE IF NOT EXISTS jobs
(
    job_id     varchar(10) not null,
    JOB_TITLE  varchar(35),
    MIN_SALARY decimal(6, 0),
    MAX_SALARY decimal(6, 0),

    constraint PK_Jobs primary key (job_id)
);


CREATE TABLE IF NOT EXISTS job_history
(
    employee_id   int UNIQUE,
    start_date    date,
    end_date      date,
    job_id        varchar(10),
    department_id int,

    constraint PK_Job_history primary key (employee_id),
    constraint FK_Job_history foreign key (job_id) references jobs (job_id)
);


-- 2.
# Write a SQL statement to insert rows in the job_history table in which one column
# job_id is containing those values which are exists in job_id column of jobs table.
INSERT INTO jobs(JOB_ID, JOB_TITLE)
VALUES (1001, 'OFFICER');
INSERT INTO jobs(JOB_ID, JOB_TITLE)
VALUES (1002, 'CLERK');

INSERT INTO job_history
VALUES (501, now(), null, 1001, 60);
INSERT INTO job_history
VALUES (502, now(), null, 1003, 80);

-- Last statement won't execute because of the referential integrity constraing, '1003' doesn't exist as a primary key in [jobs]

-- 3.
# Write a SQL statement to increase the minimum and maximum salary of CLERK by
# 1500.
update jobs
set MIN_SALARY = MIN_SALARY + 1500,
    MAX_SALARY = MAX_SALARY + 1500;
-- 4.

# 4. Write a SQL statement to add a foreign key constraint named fk_job_id on job_id
# column of job_history table referencing to the primary key job_id of jobs table.
# alter table job_history
#     modify
#         constraint fk_job_id foreign key references jobs(job_id);
-- Constraint already exists as FK_Job_history above


-- 5.
# Write a SQL statement to drop the existing foreign key fk_job_id from job_history
# table on job_id column which is referencing to the job_id of jobs table.
alter table job_history
    drop foreign key FK_Job_history;

