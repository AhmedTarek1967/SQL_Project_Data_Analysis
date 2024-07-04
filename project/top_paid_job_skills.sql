WITH top_paied_jobs AS(
    SELECT job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name AS company_name
    FROM job_postings_fact AS jpf
        LEFT JOIN company_dim ON jpf.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    Limit 100
)
SELECT top_paied_jobs.*,
    skills
FROM top_paied_jobs
    INNER JOIN skills_job_dim ON top_paied_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;