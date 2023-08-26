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
 ---------------   
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
    l.emp_no ,
    d.dept_no ,
    l.from_date ,
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
    d.dept_name,
    e.birth_date,
    e.hire_date,
    TIMESTAMPDIFF(YEAR, e.birth_date, e.hire_date) AS age
FROM
    current_dept_emp AS cde
    JOIN employees AS e ON cde.emp_no = e.emp_no
    JOIN departments AS d ON cde.dept_no = d.dept_no
WHERE
    cde.to_date <> '9999-01-01'
    AND d.dept_name NOT IN ('Development', 'Finance')
LIMIT
    10;


