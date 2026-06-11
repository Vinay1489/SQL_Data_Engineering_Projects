select length('SQL');

select lower('SQL');

select upper('Sql');

select left('SQL',2);

select right('SQL',2);

select substring('SQL',1,2);

select concat('Vinay','-','Vennampally');

select 'Vinay'||'-'||'Vennampally';

select trim('   hello   ');

select ltrim('   hello   ');

select rtrim('   hello   ');

select replace('Vinay','ay','nu');


-- Final example - clean up this using text functions


with lower_table as(
    select job_title,
    lower(trim(job_title)) as lower_title
    from job_postings_fact
)
select 
job_title,
case
    when lower_title like '%data%'
    and lower_title like '%analyst%' then 'Data Analyst'
    when lower_title like '%data%'
    and lower_title like '%scientist%' then  'Data Scientist'
    when lower_title like '%data%' 
    and lower_title like '%engineer%' then 'Data Engineer'
    else 'Other'
end as job_title_category
from lower_table
order by random()
limit 10;

-- NULLIF FUNCTIONS

select nullif(10,10);

select nullif(10,20);

select nullif('apple','orange');

select 
avg(nullif(salary_hour_avg,0)),
avg(nullif(salary_year_avg,0))
from job_postings_fact
where salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 100000;

-- COALESCE Funtcion return first non null value 

select COALESCE(null,'hello','bro');

select 
salary_hour_avg,
salary_year_avg,
COALESCE(salary_year_avg,salary_hour_avg*2080,null)
from job_postings_fact
where salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 1000;


select 
job_title_short,
salary_hour_avg,
salary_year_avg,
    COALESCE(salary_year_avg,salary_hour_avg*2080,null) 
    as standard_salary,
case 
    when standard_salary is not null and standard_salary<75_000  then 'Low'
    when standard_salary is not null and standard_salary < 150_000 then 'Medium'
    when standard_salary is not null then 'High'
    else 'No salary'
end as Salary_Category
from job_postings_fact
where standard_salary is not null
order by random()
limit 10;


