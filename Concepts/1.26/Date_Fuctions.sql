select job_posted_date,
job_posted_date::date as date,
job_posted_date::time as time,
job_posted_date::timestamp as timestamp,
job_posted_date::timestamptz as timestamptz 
from job_postings_fact
limit 10;


-- EXTRACT

select job_title_short,
extract(year from job_posted_date) as job_posted_year,
extract(month from job_posted_date) as job_posted_month,
case 
    when job_posted_month=1 then 'Jan'
    when job_posted_month=2 then 'Feb'
    when job_posted_month=3 then 'Mar'
    when job_posted_month=4 then 'Apr'
    when job_posted_month=5 then 'May'
    when job_posted_month=6 then 'Jun'
    when job_posted_month=7 then 'Jul'
    when job_posted_month=8 then 'Aug'
    when job_posted_month=9 then 'Sep'
    when job_posted_month=10 then 'Oct'
    when job_posted_month=11 then 'Nov'
    when job_posted_month=12 then 'Dec'
end as month_name
from job_postings_fact
where extract(year from job_posted_date)=2023
order by random()
limit 10;





with date_table as(
select job_title_short,
job_posted_date,
extract(month from job_posted_date) as job_month,
salary_hour_avg
from job_postings_fact
where extract(year from job_posted_date)=2023
)

select job_title_short,job_month,
-- to_char(job_posted_date,'Mon) as month_name for postgre sql
strftime(job_posted_date,'%b') as month_name,
round(avg(
    case
        when salary_hour_avg is not null then 
        salary_hour_avg
    end
),2) as month_avg_sal
from date_table
group by job_title_short,job_month,month_name
order by job_title_short,job_month;



-- DATE_TRUNC

select job_posted_date,
DATE_TRUNC('month',job_posted_date) as job_month,
DATE_TRUNC('year',job_posted_date) as job_year,
DATE_TRUNC('quarter',job_posted_date) as job_quarter,
DATE_TRUNC('week',job_posted_date) as job_week,
DATE_TRUNC('day',job_posted_date) as job_day,
DATE_TRUNC('hour',job_posted_date) as job_hour
from job_postings_fact
limit 10;




--Conversion of time zones

select '2026-06-12 00:00:00+00'::timestamptz at time zone 'IST';

select job_posted_date at time zone 'UTC' at time zone 'IST' from job_postings_fact limit 20;



