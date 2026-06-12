-- Array list
select [1,2,3,4,5] as ans;


with skills as(
select 'python' as skill
union all
select 'r'
union all 
select 'sql'), skills_array as(
select array_agg(skill order by skill) as skills from skills)
select skills[1] from skills_array;

--Struct

with skills as( 
select {name:'Harsha',level:0} as ans_struct)
select ans_struct.name from skills;



with skills as(
select 
struct_pack(
    skill:='python',
    type:='programming'
) as s
)
select s.skill from skills;


with skill_table as(
select 'python' as skills,'programming' as types
union all
select 'r','query language',
union all 
select 'sql','programming'
)
select struct_pack(
    skill:=skills,
    type:=types
    ) from skill_table;




-- Array of structs
with skills as(
select[{name:'Vinay',level:1,},{name:'Harsha',level:0}] as ans_array_struct)
select ans_array_struct[1].name from skills;


with skill_table as(
select 'python' as skills,'programming' as types
union all
select 'r','query language',
union all 
select 'sql','programming'
), skills_array as(
select
array_agg(
 struct_pack(
    skill:=skills,
    type:=types
    )
    ) as array_skills
    from skill_table)
    select array_skills[1].skill from skills_array;


--MAP

with skill_map as(
select map{'skill':'python','type':'programming'} as skill_type
)
select skill_type['skill'] from skill_map;


--JSON

with raw_skill_json as(
select 
'{"skill" : ["pyhton","Java"],"type":"Programming"}'::JSON as skill_json
)
select skill_json.skill[1] from raw_skill_json;


--JSON to array of structs

with raw_json as(
select 
'
    [
     {"skill":"python","type":"Programming"},
     {"skill":"sql","type":"query language"},
     {"skill":"r","type":"Programming"}
    ]
'::json as skills_json
)
select 
array_agg(
struct_pack(
    skill:=json_extract_string(e.value,'$.skill'),
    type:=json_extract_string(e.value,'$.type')
)
) as skills
from raw_json,json_each(skills_json) as e;



--Arrays Final example
-- Build a flat skill table for co-workers to access job titles, salary info and skills in one table

create or replace temp table job_skills_array as
select 
jpf.job_id,
jpf.job_title_short,
jpf.salary_year_avg,
array_agg(sd.skills) as skills
from job_postings_fact as jpf 
left join skills_job_dim as sjd 
on jpf.job_id=sjd.job_id
left join skills_dim sd
on sjd.skill_id=sd.skill_id
group by all
limit 200
;


-- From the perspective of a Data Analyst, analyse the median salary per skill

with skill_table as(
select 
job_title_short,
salary_year_avg,
unnest(skills) as skill
from job_skills_array
where salary_year_avg is not null
limit 20)
select skill,
median(salary_year_avg) as median_sal
from skill_table
group by skill
order by median_sal desc 
;


-- Arrays of structs final example

create or replace temp table job_skills_array_struct as
select 
jpf.job_id,
jpf.job_title_short,
jpf.salary_year_avg,
array_agg(
    struct_pack(
        skill_type:=sd.type,
        skill_name:=sd.skills
    )
) as skills_type
from job_postings_fact as jpf 
left join skills_job_dim as sjd 
on jpf.job_id=sjd.job_id
left join skills_dim sd
on sjd.skill_id=sd.skill_id
group by all
limit 200
;


-- From the perspective of a Data Analyst, analyse the median salary per type of  skill

with skill_table as(
select 
job_title_short,
salary_year_avg,
unnest(skills_type).skill_type as skill_type,
unnest(skills_type).skill_name as skill_name
from job_skills_array_struct
where salary_year_avg is not null
)
select skill_type,
median(salary_year_avg) as median_sal
from skill_table
group by skill_type
order by median_sal desc 
;

