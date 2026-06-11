-- Count rows using aggregation
select count(*) from job_postings_fact;


-- Count rows using window functions
select
   job_id,
   count(*) over()
from job_postings_fact;                 


select 
job_id,
job_title_short,
avg(salary_hour_avg) over(partition by job_title_short)
from job_postings_fact
order by random()
limit 10;


-- ranking yearly avg salary
select job_id,salary_year_avg,
rank() over(order by salary_year_avg desc) as rank_sal
from job_postings_fact
limit 10;


select job_id,salary_year_avg,
dense_rank() over(order by salary_year_avg desc) as rank_sal
from job_postings_fact
limit 10;


-- partition and order by - Running average hourly salary

select job_posted_date,
job_title_short,
salary_hour_avg,
MIN(salary_hour_avg) over(
    partition by job_title_short
    order by job_posted_date
) as running_min_sal
from job_postings_fact
where salary_hour_avg is not null
order by job_posted_date,job_title_short
limit 10;


-- ROW_NUMBER() - PROVIDING  a new job_id

select *,ROW_NUMBER() over(order by job_id) as row_number from job_postings_fact
order by job_posted_date
limit 20;

-- LAG() -Time based comparision of company yearly salary

select 
job_id,company_id,job_title_short,job_posted_date,
salary_year_avg,
LAG(salary_year_avg) over(partition by company_id order by job_posted_date)
as previous_posting_sal,
salary_year_avg-previous_posting_sal as difference,
case
    when difference=0 then 'Neutral'
    when difference<0 then 'No'
    else 'Yes'
end as Hike
from
job_postings_fact
where salary_year_avg is not null
order by company_id,job_posted_date
limit 60;






