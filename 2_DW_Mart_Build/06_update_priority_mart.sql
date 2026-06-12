-- Step 6 : Mart- Update priority roles mart

select '===Updating Roles for priority mart===' as info;

--Update Data Engineer to priority 1
update priority_mart.priority_roles
set priority_lvl=1 
where role_name='Data Engineer';


--Add Data Scientist as level 3

insert into priority_mart.priority_roles(role_id,role_name,priority_lvl)
select 4,'Data Scientist',3
where not exists(
    select 1 from priority_mart.priority_roles
    where role_id=4
);


select '===Creating temp source tale for priority mart===' as info;

-- create TEMP table
create or replace temp table  src_priority_jobs as
select 
jpf.job_id,
jpf.job_title_short,
cd.name as company_name,
jpf.job_posted_date,
jpf.salary_year_avg,
r.priority_lvl,
current_timestamp AS updated_at
from 
job_postings_fact as jpf
left join company_dim as cd
on jpf.company_id=cd.company_id 
inner join priority_mart.priority_roles as r
on jpf.job_title_short=r.role_name;


-- MERGE INTO

select '===Batch Updating priority_jobs_snapshot priority mart ===' as info; 

merge into priority_mart.priority_jobs_snapshot as tgt
using src_priority_jobs as src
on tgt.job_id=src.job_id

when matched and tgt.priority_lvl is distinct from src.priority_lvl then
    update set
        priority_lvl=src.priority_lvl,
        updated_at=src.updated_at

when not matched then
insert(
     job_id ,
    job_title_short,
    company_name,
    job_posted_date,
    salary_year_avg,
    priority_lvl,
    updated_at
)
values(
src.job_id,
src.job_title_short,
src.company_name,
src.job_posted_date,
src.salary_year_avg,
src.priority_lvl,
current_timestamp
)

when not matched by source then DELETE;



-- Final Check Query
select 
job_title_short,
count(*) as job_count,
min(updated_at) as min_updated_at,
min(priority_lvl) as min_priority_lvl,
from priority_mart.priority_jobs_snapshot
group by job_title_short
order by job_count desc;