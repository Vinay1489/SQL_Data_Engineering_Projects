select unnest([1,1,1,2])
union
select unnest([1,1,3]);


select unnest([1,1,1,2])
union all
select unnest([1,1,3]);

select unnest([1,1,1,2])
intersect
select unnest([1,1,3]);

select unnest([1,1,1,2])
intersect all
select unnest([1,1,3]);


select unnest([1,1,1,2])
except
select unnest([1,1,3]);


select unnest([1,1,1,2])
except all
select unnest([1,1,3]);

create or replace temp table jobs_2023 as
select * exclude(job_id,job_posted_date)
from job_postings_fact
where extract(year from job_posted_date)=2023;

select * from jobs_2023;


create or replace temp table jobs_2024 as
select * exclude(job_id,job_posted_date)
from job_postings_fact
where extract(year from job_posted_date)=2024;

select * from jobs_2024;

-- which unique job_postings appeared in either 2023 or 2024

select * from jobs_2023
union 
select * from jobs_2024;



select 'jobs_2023' as table_name,count(*) from jobs_2023
union 
select 'jobs_2024' as table_name ,count(*) from jobs_2024;


-- which job_postings appeared across both years, counting duplicates?

select * from jobs_2023
union all
select * from jobs_2024;

select 'jobs_2023' as table_name,count(*) from jobs_2023
union all
select 'jobs_2024' as table_name ,count(*) from jobs_2024;

-- which job_postings appeared in 2023 but not in 2024

select * from jobs_2023
except 
select * from jobs_2024;

-- which job_postings remain in 2023 after subtracting nmatching jobs in 2024 one-one

select * from jobs_2023
except all 
select * from jobs_2024;


-- which job_postings appeared in both 2023 and 2024

select * from jobs_2023 
intersect 
select * from jobs_2024;

-- which jobs_postongs appeared in both years , perspectively duplicate ones?

select * from jobs_2023 
intersect all
select * from jobs_2024;
