-- The core group by query for creating stats per JOB_ID 
SELECT 
e.JOB_ID AS JOB_ID, 
COUNT(e.EMPLOYEE_ID) AS amount,
MAX(e.SALARY) AS max_salary,
avg(e.SALARY) AS mean_salary,
MEDIAN(e.SALARY) AS median_salary,
MIN(e.SALARY) AS min_salary
FROM EMPLOYEES e 
GROUP BY e.JOB_ID;

-- candidate view 
-- embellished version with former query as the subselect in the from
-- to get extra columns from jobs associated with job_id
-- don't use as keyword in the from / join clause or you get 'SQL command not properly ended' error.
SELECT 
j.JOB_TITLE,
j.MAX_SALARY AS nominal_max_salary,
j.MIN_SALARY AS nominal_min_salary,
job_stat.*
FROM 
	(SELECT 
	e.JOB_ID AS JOB_ID, 
	COUNT(e.EMPLOYEE_ID) AS amount,
	MAX(e.SALARY) AS max_salary,
	avg(e.SALARY) AS mean_salary,
	MEDIAN(e.SALARY) AS median_salary,
	MIN(e.SALARY) AS min_salary
	FROM EMPLOYEES e 
	GROUP BY e.JOB_ID) job_stat	-- You will GET an error 'SQL command not properly ended' IF you use AS job_stat
INNER JOIN JOBS j
ON j.JOB_ID = job_stat.JOB_ID
ORDER BY nominal_max_salary DESC;
---------------------------------------------------------------------

-- here all sales representitives with dif from actual min and max score
SELECT 
concat(CONCAT(e2.FIRST_NAME, ' '),  e2.LAST_NAME) AS name,
j.JOB_TITLE,
e2.SALARY AS actual_salary,
job_stat.max_salary,
(job_stat.max_salary - e2.SALARY) AS dif_from_max,
(e2.SALARY - job_stat.mean_salary) AS diff_from_mean,
job_stat.mean_salary,
(e2.SALARY - job_stat.min_salary) AS dif_from_min,
job_stat.min_salary,
j.MAX_SALARY AS nominal_max_salary,
j.MIN_SALARY AS nominal_min_salary
FROM 
	(SELECT 
	e.JOB_ID AS JOB_ID, 
	COUNT(e.EMPLOYEE_ID) AS amount,
	MAX(e.SALARY) AS max_salary,
	avg(e.SALARY) AS mean_salary,
	MEDIAN(e.SALARY) AS median_salary,
	MIN(e.SALARY) AS min_salary
	FROM EMPLOYEES e 
	GROUP BY e.JOB_ID) job_stat	-- You will GET an error 'SQL command not properly ended' IF you use AS job_stat
INNER JOIN JOBS j
ON j.JOB_ID = job_stat.JOB_ID
INNER JOIN EMPLOYEES e2 
ON e2.JOB_ID = job_stat.JOB_ID
WHERE e2.JOB_ID = 'SA_REP'
ORDER BY e2.SALARY DESC;

