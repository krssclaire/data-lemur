/*
Companies often perform salary analyses to ensure fair compensation 
practices. 
One useful analysis is to check if there are any employees earning more 
than their direct managers.

As a HR Analyst, you're asked to identify all employees who earn more 
than their direct managers. 
The result should include the employee's ID and name.
*/

WITH joined_table AS (
    SELECT 
        mng.employee_id AS employee_id,
        mng.name AS employee_name,
        mng.salary AS employee_salary,
        emp.employee_id AS manager_id,
        emp.name AS manager_name,
        emp.salary AS manager_salary
    FROM employee emp
    INNER JOIN employee mng
        ON emp.employee_id = mng.manager_id
)

SELECT 
    employee_id,
    employee_name
FROM joined_table
WHERE employee_salary > manager_salary