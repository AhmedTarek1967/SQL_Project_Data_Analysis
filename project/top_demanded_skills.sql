SELECT skills,
    COUNT(skills_job_dim.job_id) as demand_nums
FROM job_postings_fact AS jpf
    INNER JOIN skills_job_dim on jpf.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand_nums DESC