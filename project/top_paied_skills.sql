SELECT skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary_per_skill
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim ON jpf.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary_per_skill DESC
LIMIT 10;