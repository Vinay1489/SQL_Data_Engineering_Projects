select count(*) from job_postings_fact;

select 
    cd.company_id,
    cd.name,
    jpf.job_title_short,
    jpf.salary_year_avg
from job_postings_fact jpf
full join 
    company_dim cd 
on cd.company_id=jpf.company_id
;

select 
    jpf.job_id,
    jpf.job_title_short,
    sjd.skill_id,
    sd.skills
    from job_postings_fact jpf
    left join 
    skills_job_dim sjd
    on jpf.job_id=sjd.job_id
    left join skills_dim sd 
    on sjd.skill_id=sd.skill_id;


