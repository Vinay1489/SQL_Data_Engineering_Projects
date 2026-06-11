-- Bucket Salaries
-- <25 = 'Low'
-- 25-30= "Medium"
-- >50= 'High'

select  
    job_title_short,
    salary_hour_avg,
    case 
        when salary_hour_avg<25 then 'Low'
        when salary_hour_avg<=50 then 'Medium'
        else 'High'
    end as salary_category
from job_postings_fact
where salary_hour_avg is not null
limit 10;


-- Handling Missing Data (Nulls)

select  
    job_title_short,
    salary_hour_avg,
    case 
        when salary_year_avg is null then 'Missing'
        when salary_hour_avg<25 then 'Low'
        when salary_hour_avg<=50 then 'Medium'
        else 'High'
    end as salary_category
from job_postings_fact
limit 10;


-- Categorizing Values

select 
job_title,
case
    when job_title_short like '%Data%' and job_title_short like '%Analyst%' then 'Data Analyst'
    else 'Other'
end as Job_Category,
job_title_short
from job_postings_fact
order by random()
limit 10;


-- Conditional Aggregation

select 
job_title_short,
count(*) as total_postings,
median(
    case
        when salary_year_avg < 100_000 then salary_year_avg 
    end
) as median_low_salary
from job_postings_fact
group by job_title_short;


--Final Example-- COnditional Calculations

select 
job_title_short,
salary_hour_avg,
salary_year_avg,
case
    when salary_year_avg IS NOT NULL then salary_year_avg
    when salary_hour_avg is not null then salary_hour_avg*2080
end as standard_salary,
case 
    when standard_salary is not null and standard_salary<75_000  then 'Low'
    when standard_salary is not null and standard_salary < 150_000 then 'Medium'
    when standard_salary is not null then 'High'
    else 'No salary'
end as Salary_Category
from job_postings_fact
where salary_hour_avg is not null or salary_year_avg is not null
order by random()
limit 10;
