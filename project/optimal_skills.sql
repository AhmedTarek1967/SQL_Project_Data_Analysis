WITH average_salary_per_skill AS (
    SELECT skills_job_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(jpf.salary_year_avg), 0) AS avg_salary_per_skill
    FROM job_postings_fact AS jpf
        INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id,
        skills_dim.skills
),
skills_demand AS (
    SELECT skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_nums
    FROM job_postings_fact AS jpf
        INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE jpf.job_title_short = 'Data Analyst'
        AND jpf.salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id,
        skills_dim.skills
)
SELECT skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_nums,
    average_salary_per_skill.avg_salary_per_skill
FROM skills_demand
    INNER JOIN average_salary_per_skill ON skills_demand.skill_id = average_salary_per_skill.skill_id
WHERE demand_nums > 10
ORDER BY avg_salary_per_skill,
    demand_nums DESC;