-- SubQuery
select *
from(
    select *
    from job_postings_fact
    where salary_year_avg is  not null
) as valid_salaries
limit 10;

-- CTE
with valid_salaries as (
     select *
    from job_postings_fact
    where salary_year_avg is  not null 
)
select * from valid_salaries limit 10;


-- Scenario 1- Subquery in 'SELECT'
-- Show each job's salary next to the overall market median:

select distinct(job_title_short),
(
    select median(salary_year_avg)
    from job_postings_fact
) as median_sal
from job_postings_fact group by job_title_short;



-- Scenario 2- Subquery in 'FROM'
-- Stage only jobs that are remote before aggregating to determine the remote median salary per job :

select * from
(
    select median(salary_year_avg),job_title_short
    from job_postings_fact
    where job_work_from_home=true
    group by job_title_short
) as median_sal 
;


select median(salary_year_avg),job_title_short,
(
    select median(salary_year_avg) from
    job_postings_fact
) as market_median_sal
from(
    select job_title_short,
    salary_year_avg
    from job_postings_fact
    where job_work_from_home=true
) as clean_jobs
where salary_year_avg is not null
group by job_title_short
limit 10;





-- Scenario 3- Subquery in 'HAVING'
-- Keep only job titles whose median salary is above overall medians: 

select job_title_short,median(salary_year_avg) as median_sal,
(
    select median(salary_year_avg) from
    job_postings_fact
) as market_median_sal
from job_postings_fact
where salary_year_avg is not null and job_work_from_home=true
group by job_title_short
having median_sal > (
    select median(salary_year_avg)
    from job_postings_fact 
) 
order by median_sal desc;


-- CTE example
-- Compare how much more ( or less) remote roles pay compared to onsite roles for each job_title.
-- Use a CTE to calculate the median salary by title and work arrangement , then compare those medians.

with title_median as(
select job_title_short,
job_work_from_home,
median(salary_year_avg)::int as median_sal
from job_postings_fact
group by job_title_short,job_work_from_home
)

select 
r.job_title_short,
r.median_sal as remote_median_sal,
o.median_sal as onsite_mdeian_sal,
(remote_median_sal - onsite_mdeian_sal) as premium_remote
from title_median as r
inner join title_median as o
on o.job_title_short=r.job_title_short
where r.job_work_from_home=true 
and o.job_work_from_home=false
order by premium_remote desc;



-- EXISTS and NOT EXISTS Demonstration

select * from range(10) as src(key);

select * from range(7) as tgt(key);

select * from range(10) as src(key)
where exists(
    select 1 from range(8) as tgt(key)
    where src.key=tgt.key
);

select * from range(10) as src(key)
where not exists(
    select 1 from range(8) as tgt(key)
    where src.key=tgt.key
);


select * from job_postings_fact as tgt
where EXISTS (
select 1 from skills_job_dim as src
where tgt.job_id=src.job_id
) order by job_id;



select * from job_postings_fact as tgt
where NOT EXISTS (
select 1 from skills_job_dim as src
where tgt.job_id=src.job_id
) order by job_id;
