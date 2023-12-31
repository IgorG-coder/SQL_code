SELECT COUNT(*) FROM `employees` WHERE gender='M';
SELECT gender as Gender, COUNT(*) AS Count FROM `employees` GROUP BY gender;
SELECT gender as Gender, MAX(birth_date) , COUNT(*) AS Count FROM `employees` WHERE birth_date >='1960-01-01' GROUP BY gender;
SELECT * FROM employees ORDER BY hire_date ASC LIMIT 50;
SELECT * FROM employees ORDER BY hire_date DESC LIMIT 50;
SELECT * FROM employees ORDER BY hire_date DESC LIMIT 1;
SELECT hire_date FROM employees ORDER BY hire_date DESC LIMIT 1;
SELECT CONCAT(e.first_name, ' ', e.last_name) as full_name FROM `employees` as e WHERE e.gender='M' LIMIT 50;
SELECT *, CONCAT(e.first_name, ' ', e.last_name) AS full_name FROM `employees` as e WHERE e.gender='M' LIMIT 50;
-- comment
SELECT*, CONCAT(e.first_name,' ', e.last_name) AS full_name, current_time FROM`employees`AS e WHERE e.gender ='M'LIMIT 25;

select
    `emp_no` ,    max(`from_date`) ,    max(`to_date`) 
    
from
    dept_emp
group by
    emp_no;
    
select
    `employees`.`dept_emp`.`emp_no` AS `emp_no`,
    max(`employees`.`dept_emp`.`from_date`) AS `from_date`,
    max(`employees`.`dept_emp`.`to_date`) AS `to_date`
from
    `employees`.`dept_emp`
group by
    `employees`.`dept_emp`.`emp_no`;
 --
select
    `employees`.`l`.`emp_no` AS `emp_no`,
    `d`.`dept_no` AS `dept_no`,
    `employees`.`l`.`from_date` AS `from_date`,
    `employees`.`l`.`to_date` AS `to_date`
from
    (
        `employees`.`dept_emp` `d`
        join `employees`.`dept_emp_latest_date` `l` on(
            (
                (`d`.`emp_no` = `employees`.`l`.`emp_no`)
                and (`d`.`from_date` = `employees`.`l`.`from_date`)
                and (`employees`.`l`.`to_date` = `d`.`to_date`)
            )
        )
    ) ;
    -- simplified current_dept_emp
SELECT
    dept_emp_latest_date.emp_no ,
    dept_emp.dept_no ,
    dept_emp_latest_date.from_date ,
    dept_emp_latest_date.to_date 
FROM
    dept_emp
    JOIN dept_emp_latest_date ON dept_emp.emp_no = dept_emp_latest_date.emp_no
    AND dept_emp.from_date = dept_emp_latest_date.from_date
    AND dept_emp_latest_date.to_date = dept_emp.to_date;
--
SELECT
    l.emp_no,
    d.dept_no,
    l.from_date,
    l.to_date
FROM
    dept_emp AS d
    JOIN dept_emp_latest_date AS l ON d.emp_no = l.emp_no
    AND d.from_date = l.from_date
    AND l.to_date = d.to_date;
 --   
SELECT
    *
FROM
    current_dept_emp;
    --

SELECT * FROM current_dept_emp AS cde;
--
SELECT * FROM current_dept_emp AS cde JOIN employees AS e ON cde.emp_no = e.emp_no;
--
SELECT *, CONCAT(e.first_name, ' ', e.last_name) AS full_name FROM current_dept_emp AS cde JOIN employees AS e ON cde.emp_no = e.emp_no;
--
SELECT *, CONCAT(e.first_name, ' ', e.last_name) AS full_name FROM current_dept_emp AS cde JOIN employees AS e ON cde.emp_no = e.emp_no 
JOIN departments AS d ON cde.dept_no = d.dept_no LIMIT 10;
--
SELECT *, CONCAT(e.first_name, ' ', e.last_name) AS full_name FROM current_dept_emp AS cde JOIN employees AS e ON cde.emp_no = e.emp_no 
JOIN departments AS d ON cde.dept_no = d.dept_no WHERE cde.to_date <>'9999-01-01' LIMIT 20;
--
SELECT *, CONCAT(e.first_name, ' ', e.last_name) AS full_name FROM current_dept_emp AS cde JOIN employees AS e ON cde.emp_no = e.emp_no 
JOIN departments AS d ON cde.dept_no = d.dept_no WHERE cde.to_date <>'9999-01-01' AND d.dept_name IN ('Development', 'Finance') LIMIT 20;
--
SELECT *, CONCAT(e.first_name, ' ', e.last_name) AS full_name FROM current_dept_emp AS cde JOIN employees AS e ON cde.emp_no = e.emp_no 
JOIN departments AS d ON cde.dept_no = d.dept_no WHERE cde.to_date <>'9999-01-01' AND d.dept_name NOT IN ('Development', 'Finance') LIMIT 10;
--
SELECT
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.dept_name AS department,
    CASE
        cte.title
        WHEN 'Staff' THEN 'Member'
        WHEN 'Senior Staff' THEN 'Senior Member'
        ELSE cte.title
    END as title,
    e.birth_date,
    e.hire_date,
    TIMESTAMPDIFF(YEAR, e.birth_date, e.hire_date) AS age
FROM
    current_dept_emp AS cde
    JOIN employees AS e ON cde.emp_no = e.emp_no
    JOIN departments AS d ON cde.dept_no = d.dept_no
    JOIN current_title_emp AS cte ON cte.emp_no = e.emp_no
WHERE
    cde.to_date <> '9999-01-01'
    AND d.dept_name NOT IN ('Development', 'Finance')
LIMIT
    10;

SELECT CURRENT_DATE;

SELECT CURRENT_USER;

-- having
-- находим сотрудников которые работали в более чем одном департаменте
SELECT
	de.emp_no,
	COUNT(*) AS count
FROM
	dept_emp AS de
GROUP BY
	de.emp_no
HAVING
	count > 1;

-- сотрудники с суммой выплат больше миллиона
SELECT
    s.emp_no,
    SUM(s.salary) AS total_salary
FROM
    salaries AS s
GROUP BY
    s.emp_no
HAVING
    total_salary > 1000000
ORDER BY
    total_salary DESC;
    
-- 
-- 
SELECT
    l.emp_no,
    d.dept_no,
    l.from_date,
    l.to_date
FROM
    dept_emp AS d
    JOIN dept_emp_latest_date AS l ON d.emp_no = l.emp_no
    AND d.from_date = l.from_date
    AND l.to_date = d.to_date;
-- используем сабквери (sub-query) вместо вью (view)
SELECT
    l.emp_no,
    d.dept_no,
    l.from_date,
    l.to_date
FROM
    dept_emp AS d
    JOIN (
        SELECT
            emp_no,
            MAX(from_date) AS from_date,
            MAX(to_date) AS to_date
        FROM
            dept_emp
        GROUP BY
            emp_no
    ) AS l ON d.emp_no = l.emp_no
    AND d.from_date = l.from_date
    AND l.to_date = d.to_date;
-- with
WITH dept_latest AS (
    SELECT
        emp_no,
        MAX(from_date) AS from_date,
        MAX(to_date) AS to_date
    FROM
        dept_emp
    GROUP BY
        emp_no
)
SELECT
    l.emp_no,
    d.dept_no,
    l.from_date,
    l.to_date
FROM
    dept_emp AS d
    JOIN dept_latest AS l ON d.emp_no = l.emp_no
    AND d.from_date = l.from_date
    AND l.to_date = d.to_date;
--
CREATE
OR REPLACE VIEW current_title_emp AS WITH title_latest_day AS (
    SELECT
        t.emp_no,
        MAX(t.from_date) AS from_date,
        MAX(t.to_date) AS to_date
    FROM
        titles AS t
    GROUP BY
        t.emp_no
)
SELECT
    t.emp_no,
    t.title,
    t.from_date AS from_date,
    t.to_date AS to_date
FROM
    title_latest_day AS tld
    JOIN titles AS t ON t.emp_no = tld.emp_no
    AND t.from_date = tld.from_date
    AND t.to_date = tld.to_date;
    
-- columns emp_no, full_name, deparment, title, gender, birthdate

SELECT
    e.emp_no,
    CONCAT(e.first_name, ' ', e.last_name) AS full_name,
    d.dept_name AS department,
    cte.title,
    e.birth_date,
    e.gender
FROM
    employees e
    JOIN current_title_emp cte ON cte.emp_no = e.emp_no
    JOIN current_dept_emp cde ON cde.emp_no = e.emp_no
    JOIN departments d ON cde.dept_no = d.dept_no
WHERE e.first_name LIKE '%za%' OR e.last_name LIKE '%%'
LIMIT
    100;
--
SELECT
    *
FROM
    employees e
    JOIN current_dept_emp cde ON e.emp_no = cde.emp_no
LIMIT
    10;
--
SELECT
    cde.emp_no AS id,
    d.dept_name AS Departament,
    cde.from_date,
    cde.to_date,
    e.first_name,
    e.last_name,
    CONCAT(e.first_name, ' ', e.last_name) AS full_nam
FROM
    current_dept_emp cde
    JOIN departments d ON cde.dept_no = d.dept_no
    JOIN employees e ON cde.emp_no = e.emp_no
WHERE
    e.last_name LIKE '%kova'
LIMIT
    10;
