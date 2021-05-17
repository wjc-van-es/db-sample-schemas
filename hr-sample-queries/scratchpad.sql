
SELECT * FROM EMPLOYEES e;

SELECT 
concat(CONCAT(e.FIRST_NAME, ' '),  e.LAST_NAME) AS name,
j.JOB_TITLE 
FROM EMPLOYEES e
INNER JOIN JOBS j 
ON e.JOB_ID = j.JOB_ID ;

SELECT 
e.JOB_ID AS JOB_ID, 
COUNT(e.EMPLOYEE_ID) AS amount,
MAX(e.SALARY) AS max_salary,
avg(e.SALARY) AS mean_salary,
MEDIAN(e.SALARY) AS median_salary,
MIN(e.SALARY) AS min_salary
FROM EMPLOYEES e 
GROUP BY e.JOB_ID;

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





