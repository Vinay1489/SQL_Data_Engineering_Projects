--Step 2: DW- Loadt data from csv files into tables

select '===Loading table 1 info---' as info;

insert into company_dim(company_id,name)
select company_id,name
from read_csv('https://storage.googleapis.com/sql_de/company_dim.csv',
auto_detect=true);

select 'Table 1 inserted Successfully';

select '===Loading table 2 info===' as info;

insert into skills_dim(skill_id,skills,type)
select skill_id,skills,type
from read_csv('https://storage.googleapis.com/sql_de/skills_dim.csv',
auto_detect=true);

select 'Table 2 inserted Successfully';

select '===Loading table 3 info===' as info;

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

select 'Table 3 inserted Successfully';

select '===Loading table 4 info===' as info;

insert into skills_job_dim(skill_id,job_id)
select skill_id ,job_id
from read_csv('https://storage.googleapis.com/sql_de/skills_job_dim.csv',
auto_detect=true)
where skill_id in(select skill_id from skills_dim);

select 'Table 4 inserted Successfully';

