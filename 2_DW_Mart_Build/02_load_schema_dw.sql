--Step 2: DW- Loadt data from csv files into tables

select '===Loading company_dim table info===' as info;

insert into company_dim(company_id,name)
select company_id,name
from read_csv('https://storage.googleapis.com/sql_de/company_dim.csv',
auto_detect=true);

select 'company_dim table values inserted Successfully';

select '===Loading skills_dim table info===' as info;

insert into skills_dim(skill_id,skills,type)
select skill_id,skills,type
from read_csv('https://storage.googleapis.com/sql_de/skills_dim.csv',
auto_detect=true);

select 'skills_dim table values inserted Successfully';

select '===Loading Job_Postings_fact table info===' as info;

insert into job_postings_fact(
    job_id  ,
    company_id ,
    job_title_short ,
    job_title ,
    job_location ,
    job_via ,
    job_schedule_type ,
    job_work_from_home ,
    search_location ,
    job_posted_date,
    job_no_degree_mention ,
    job_health_insurance ,
    job_country ,
    salary_rate ,
    salary_year_avg,
    salary_hour_avg
)
select *
from read_csv('https://storage.googleapis.com/sql_de/job_postings_fact.csv',
auto_detect=true);

select 'Job_Postings_fact table values inserted Successfully';

select '===Loading Skills_Job_dim table info===' as info;

insert into skills_job_dim(skill_id,job_id)
select skill_id ,job_id
from read_csv('https://storage.googleapis.com/sql_de/skills_job_dim.csv',
auto_detect=true)
where skill_id in(select skill_id from skills_dim);

select 'Skills_Job_dim table values inserted Successfully';


select 'company_dim' as table_name,count(*) as record_count from company_dim
union all
select 'skills_dim',count(*) from skills_dim 
union all
select 'job_postings_fact',count(*) from job_postings_fact
union all
select 'skills_job_dim', count(*) from skills_job_dim;

select '===Company_dimension_sample===' as info;
select * from company_dim limit 5;

select '===skills job dimension sample===' as info;
select * from skills_job_dim limit 5;

select '===Skills dimension sample===' as info;
select * from skills_dim limit 5;

select '===Job_Postings_fact_sample===' as info;
select * from job_postings_fact limit 5;


