select 
    job_id,
    job_title_short,
    salary_year_avg,
    company_id
from 
    job_postings_fact
where 
    salary_year_avg is not null
limit 10;


select 
    *
from 
    company_dim
limit 10;

select 
    *
from  information_schema.table_constraints
where table_catalog='data_jobs';


pragma show_tables;

pragma show_tables_expanded;

describe job_postings_fact;