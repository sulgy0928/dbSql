--194 실습 join8

SELECT regions.region_id, regions.region_name, countries.country_name
FROM regions JOIN countries ON (regions.region_id = countries.region_id)
WHERE regions.region_id  = 1; --country_name의 순서가 다르지만 같은값들로 잘 출력됨.


SELECT *
FROM countries;  --REGION_ID    COUNTRY_ID   COUNTRY_NAME   

SELECT *
FROM regions; --REGION_ID   REGION_NAME

SELECT *
FROM locations;

SELECT *
FROM departments;

SELECT *
FROM employees;

--195P 실습9
SELECT regions.region_id, regions.region_name,country_name, locations.city 
FROM countries JOIN regions ON (regions.region_id = countries.region_id)
         JOIN locations ON (countries.country_id = locations.country_id)
         WHERE regions.region_name = 'Europe'; 

--196p 실습10
SELECT regions.region_id, regions.region_name,locations.city, country_name 
FROM countries JOIN regions ON (regions.region_id = countries.region_id)
         JOIN locations ON (countries.country_id = locations.country_id)
         JOIN departments ON (locations.location_id = departments.location_id)
         WHERE regions.region_name = 'Europe'; 
         
--197p 실습11 
SELECT regions.region_id, regions.region_name, country_name, locations.city, department_name, first_name || last_name  name
FROM countries JOIN regions ON (regions.region_id = countries.region_id)
         JOIN locations ON (countries.country_id = locations.country_id)
         JOIN departments ON (locations.location_id = departments.location_id)
         JOIN employees ON (departments.department_id = employees.department_id)
         WHERE regions.region_name = 'Europe'; 
         
--198p 실습12
SELECT employees.employee_id, first_name || last_name  name, jobs.job_id, jobs.job_title
FROM employees JOIN jobs ON (employees.job_id = jobs.job_id);

SELECT * 
FROM employees;--job_id

SELECT *
FROM jobs;--_history; --job_id

--199p 실습13
SELECT a.manager_id mng_id, b.first_name || b.last_name mgr_name,  a.employee_id ,
                a.first_name || a.last_name, jobs.job_id, jobs.job_title
FROM employees a, employees b, jobs
WHERE a.manager_id = b.employee_id
        AND a.job_id = jobs.job_id;    

--PC02로 접근할것.((문제의 목적 : A테이블의 사원의 매니저가 누구인지 조회하기.))
SELECT a.empno a_empno, a.ename a_ename, a.mgr a_mgr, b.empno b_empno, b.ename b_ename
FROM emp a, emp b
WHERE a.mgr = b.empno;


















