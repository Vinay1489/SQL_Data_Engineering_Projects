/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/


select
    jpf.job_title_short,
    count(jpf.*) as demand_count,
    sd.skills
from
    job_postings_fact jpf
join  
    skills_job_dim sjd
on
     jpf.job_id=sjd.job_id
join 
    skills_dim sd
on
    sjd.skill_id=sd.skill_id
where jpf.job_title_short='Data Engineer' and jpf.job_work_from_home=true
group by  sd.skills,jpf.job_title_short
order by demand_count desc
limit 10;



/*

┌─────────────────┬──────────────┬────────────┐
│ job_title_short │ demand_count │   skills   │
│     varchar     │    int64     │  varchar   │
├─────────────────┼──────────────┼────────────┤
│ Data Engineer   │        29221 │ sql        │
│ Data Engineer   │        28776 │ python     │
│ Data Engineer   │        17823 │ aws        │
│ Data Engineer   │        14143 │ azure      │
│ Data Engineer   │        12799 │ spark      │
│ Data Engineer   │         9996 │ airflow    │
│ Data Engineer   │         8639 │ snowflake  │
│ Data Engineer   │         8183 │ databricks │
│ Data Engineer   │         7267 │ java       │
│ Data Engineer   │         6446 │ gcp        │
└─────────────────┴──────────────┴────────────┘
  10 rows                           3 columns

*/
