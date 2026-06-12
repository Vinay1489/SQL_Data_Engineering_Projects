explain analyze select 
    cd.name as company_name,
    count(jpf.*) as posting_count,
    jpf.job_country,
from 
    job_postings_fact jpf
left join 
    company_dim cd
on jpf.company_id=cd.company_id
where not
    job_country='United States'
group by 
    company_name,job_country
    having posting_count>1000
order by posting_count desc
limit 10
;