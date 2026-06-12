describe
select 
*
from
information_schema.columns
where table_name='job_postings_fact';

describe job_postings_fact;

-- We use CAST() function to convert one data type in to other or just simply use :: (ex: job_id::varchar)

select
cast(job_id as varchar) || '-' ||  cast(company_id as varchar) as unique_id,
cast(job_work_from_home as int) as job_work_from_home,
cast(job_posted_date as date) as job_posted_date,
cast(salary_year_avg as float)
from job_postings_fact
limit 10;

select
(job_id::varchar || '-' ||  company_id::varchar )as unique_id,
job_work_from_home::integer as job_work_from_home,
job_posted_date::date as job_posted_date,
salary_year_avg::float
from job_postings_fact
limit 10;
