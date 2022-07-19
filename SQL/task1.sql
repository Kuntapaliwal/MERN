-- Active: 1656669061278@@127.0.0.1@3307@org
show databases;
-- Write a query to display the names (first_name, last_name) using alias name “ First Name ", " Last Name ".
SELECT first_name as First_Name,
    last_name as Last_Name
from employees;
-- Write a query to get unique department ID from employee table.
SELECT DISTINCT department_id
from employees;
-- Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary).
SELECT CONCAT(first_name, " ", last_name) as names,
    salary,
    salary * 0.15 as Calculated_PF
from employees;
-- Write a query to get the maximum and minimum salary from employees table.
SELECT MIN(salary) as min_salary,
    MAX(salary) as max_salary
from employees;
-- Write a query to get the average salary and number of employees in the employees table.
SELECT AVG(salary) as avg_salary,
    COUNT(*) as no_of_employees
from employees;
-- Write a query get all first name from employees table in upper case.
SELECT UPPER(first_name) as firstName
from employees;
-- Write a query to get the first 3 characters of first name from employees table.
SELECT SUBSTRING(first_name, 1, 3) as first_3_Letters
from employees;
-- Write a query to select first 10 records from a table.
SELECT *
from employees
LIMIT 10;
-- Write a query to get monthly salary (round 2 decimal places) of each and every employee.
SELECT ROUND(salary / 12, 2)
from employees;
-- Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.
SELECT CONCAT(first_name, " ", last_name) as name,
    department_id
from employees
where DEPARTMENT_ID = 30
    OR DEPARTMENT_ID = 100
ORDER BY DEPARTMENT_ID ASC;
SELECT first_name,
    last_name,
    department_id
FROM employees
WHERE department_id IN (30, 100)
ORDER BY department_id ASC;
-- 2nd task
-- Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.
SELECT CONCAT(first_name, " ", last_name) as name,
    salary
from employees
where salary NOT IN(10000, 15000);
-- Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100.
SELECT CONCAT(first_name, " ", last_name) as name,
    salary
from employees
where salary NOT IN(10000, 15000)
    AND DEPARTMENT_ID = 30
    OR DEPARTMENT_ID = 100;
-- or
SELECT CONCAT(first_name, " ", last_name) as name,
    salary
from employees
where salary NOT IN(10000, 15000)
    AND DEPARTMENT_ID IN(30, 100);
-- Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.
SELECT CONCAT(first_name, " ", last_name) as name,
    hire_date
from employees
where year(HIRE_DATE) LIKE "1987";
-- Write a query to display the first_name of all employees who have both "b" and "c" in their first name.
SELECT first_name
from employees
where first_name LIKE '%b%'
    AND first_name LIKE '%c%';
-- Write a query to display the last name, job, and salary for all employees whose job is that of a Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000.
SELECT last_name,
    job_id,
    salary
from employees
where job_id = 'IT_PROG'
    OR job_id = 'SH_CLERK'
    AND salary <> 4500
    AND salary <> 10000
    AND SALARY <> 15000;
-- or
SELECT last_name,
    job_id,
    salary
FROM employees
WHERE job_id IN ('IT_PROG', 'SH_CLERK')
    AND salary NOT IN (4500, 10000, 15000);
-- Write a query to display the last name of employees having 'e' as the third character.
SELECT last_name
from employees
where LAST_NAME LIKE '__e%';
-- Write a query to display the last name of employees whose names have exactly 6 characters.
SELECT last_name
FROM employees
WHERE last_name LIKE '______';
-- Write a query to select all record from employees where last name in 'BLAKE', 'SCOTT', 'KING' and 'FORD'.
SELECT *
FROM employees
WHERE last_name IN('BLAKE', 'SCOTT', 'KING', 'FORD');
-- subquery
SELECT CONCAT(first_name, " ", last_name) as name,
    salary
from employees
where salary > (
        SELECT AVG(salary)
        from employees
    );
SELECT CONCAT(first_name, " ", last_name) as name,
    salary
from employees
where salary =(
        select MIN(salary)
        from employees
    );
SELECT employee_id,
    first_name,
    last_name,
    salary
from employees e
where salary >(
        select AVG(salary)
        from employees d
        where d.department_id = e.department_id
    );
-- 3rd task
-- Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'.
SELECT CONCAT(FIRST_NAME, " ", LAST_NAME) AS NAME,
    SALARY
FROM employees
WHERE SALARY > (
        SELECT SALARY
        FROM employees
        WHERE LAST_NAME = 'Bull'
    );
-- Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
SELECT CONCAT(first_name, " ", last_name) as name
from employees e
where e.DEPARTMENT_ID IN (
        SELECT DEPARTMENT_ID
        from departments
        where DEPARTMENT_NAME LIKE "IT"
    ) -- Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA-based department.
SELECT CONCAT(first_name, " ", last_name) as name
from employees e
where MANAGER_ID IN (
        SELECT EMPLOYEE_ID
        from employees
        where DEPARTMENT_ID IN (
                select DEPARTMENT_ID
                from departments
                where LOCATION_ID IN (
                        select location_id
                        from locations
                        where COUNTRY_ID LIKE 'US'
                    )
            )
    );
-- Write a query to find the name (first_name, last_name) of the employees who are managers.
select CONCAT(first_name, " ", last_name)
from employees
where EMPLOYEE_ID IN (
        select MANAGER_ID
        from employees
    );
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary.
select CONCAT(first_name, " ", last_name) as name,
    salary
from employees
where SALARY > (
        select AVG(salary)
        from employees
    );
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their jobs.
select CONCAT(first_Name, " ", last_name) as name,
    salary
from employees e
where salary = (
        select MIN_SALARY
        from jobs
        where e.job_id = jobs.job_id
    );
-- how 7th this one is different from other....
-- Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary and works in any of the IT departments.
select CONCAT(first_Name, " ", last_name) as name,
    salary
from employees
where salary >(
        select AVG(salary)
        from employees
    )
    AND department_id IN (
        select department_id
        from departments
        where DEPARTMENT_NAME LIKE 'IT%'
    );
-- Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earnings of Mr. Bell.
select CONCAT(first_Name, " ", last_name) as name,
    salary
from employees
where salary >(
        select salary
        from employees
        WHERE LAST_NAME LIKE "Bell"
    );
-- Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
SELECT *
FROM employees
WHERE salary = (
        SELECT MIN(salary)
        FROM employees
    );
-- Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
SELECT CONCAT(first_name, " ", LAST_NAME) as name,
    SALARY
FROM employees
WHERE salary > (
        SELECT AVG(salary)
        FROM employees
    );
-- Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary from the lowest to highest.
SELECT CONCAT(first_name, " ", LAST_NAME) as name,
    SALARY
from employees
where SALARY > ALL(
        SELECT salary
        from employees
        where JOB_ID LIKE 'SH_CLERK'
    )
ORDER BY SALARY ASC;
-- Write a query to find the name (first_name, last_name) of the employees who are not managers.
SELECT CONCAT(first_name, " ", LAST_NAME) as name
from employees
where EMPLOYEE_ID NOT IN (
        SELECT MANAGER_ID
        from employees
    );
-- Write a query to display the employee ID, first name, last name, and department names of all employees.
SELECT FIRST_NAME,
    LAST_NAME,
(
        SELECT department_name
        from departments
        where DEPARTMENT_ID = e.DEPARTMENT_ID
    ) as DEPARTMENT_NAME
from employees e;
-- Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments.
select EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY
from employees e
where salary >(
        select AVG(SALARY)
        from employees
        where DEPARTMENT_ID In (
                SELECT DEPARTMENT_ID
                from departments
            )
    );
-- Write a query to fetch even numbered records from employees table.
SELECT *
from employees
where EMPLOYEE_ID %2 = 0;
-- Write a query to find the 5th maximum salary in the employees table.
select *
from employees
ORDER BY SALARY DESC
limit 1 offset 4;
-- Write a query to find the 4th minimum salary in the employees table.
select distinct(salary)
from employees
ORDER BY SALARY ASC
limit 3, 1;
-- Write a query to select the last 10 records from a table.
select *
from employees
ORDER BY -- Write a query to list the department ID and name of all the departments where no employee is working.
select DEPARTMENT_ID,
    department_name
from departments
where man -- Write a query to get 3 maximum salaries.
select DISTINCT(salary)
from employees
ORDER BY salary DESc
LIMIT 3;
-- Write a query to get 3 minimum salaries.
select DISTINCT(salary)
from employees
ORDER BY salary ASC
LIMIT 3;
-- Write a query to get nth max salaries of employees.
select DISTINCT(salary)
from employees
ORDER BY salary DESC
LIMIT n -1, 1;
select CONCAT(first_Name, " ", last_name) as name,
    salary
from employees
where salary >(
        select AVG(salary)
        from employees
        WHERE department_id IN (
                select department_id
                from departments
                where DEPARTMENT_NAME LIKE 'IT%'
            )
    );
--  1.   Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
select location_id,
    street_address,
    city,
    state_province,
    country_name
from locations l
    INNER JOIN countries c using (COUNTRY_ID);
--2. Write a query to find the name (first_name, last name), department ID, and department name of all the employees.
select CONCAT(first_name, " ", last_name) as name,
    department_id,
    department_name
from employees e
    INNER JOIN departments using(DEPARTMENT_ID);
--3. Write a query to find the name (first_name, last_name), job, department ID, and name of the employees who work in London.
select CONCAT(first_name, " ", last_name) as name,
    job_id,
    department_id,
    department_name
from employees
    INNER JOIN jobs using(job_id)
    INNER JOIN departments d USING (DEPARTMENT_ID)
    INNER JOIN locations using(location_id)
where CITY LIKE 'London';
-- 4. Write a query to find the employee id, name (last_name) along with their manager_id, and name (last_name).
select e1.employee_id,
    CONCAT(e1.first_name, " ", " ", e2.last_name) as name,
    e2.manager_id,
    e2.last_name as manager_name
from employees e1
    JOIN employees e2 on e1.EMPLOYEE_ID = e2.MANAGER_ID;
--5. Write a query to find the name (first_name, last_name) and hire date of the employees who were hired after 'Jones'.
SELECT CONCAT(first_name, " ", last_name) as name,
    hire_date
from employees
where hire_date >(
        select HIRE_DATE
        from employees
        where last_name LIKE 'Jones'
    );
--6. Write a query to get the department name and number of employees in the department.
select department_name,
    COUNT(*) as no_of_employees
from departments d
    INNER JOIN employees e on(e.DEPARTMENT_ID = d.DEPARTMENT_ID)
GROUP BY d.DEPARTMENT_NAME,
    d.DEPARTMENT_ID;
--7. Write a query to find the employee ID, job title, number of days between the ending date and the starting date for all jobs in department 90.
SELECT employee_id,
    j.job_id,
(end_date - start_date) as days
from job_history
    Natural JOIN jobs j
where DEPARTMENT_ID = 90;
--8. Write a query to display the department ID and name and first name of the manager.
select d.department_id,
    d.department_name,
    m.first_name as manger_name
from departments d
    INNER Join employees m using(manager_id);
--9.  Write a query to display the department name, manager name, and city.
select department_name,
    city,
    first_name as manger
from employees e
    INNER JOIN departments m using(DEPARTMENT_ID)
    INNER JOIN locations using(LOCATION_ID)
GROUP BY DEPARTMENT_NAME;
--10. Write a query to display the job title and average salary of employees.
select job_id,
    AVG(salary) as avg_salary
from jobs
    INNER JOIN employees using(job_id)
GROUP BY JOB_TITLE;
--11. Write a query to display job title, employee name, and the difference between the salary of the employee and minimum salary for the job.
select job_id,
    first_name,
    salary - min_salary as difference
from jobs
    INNER JOIN employees using(JOB_ID);
--12.  Write a query to display the job history of any employee who is currently drawing more than 10000 of salary.
select EMPLOYEE_ID,
    START_DATE,
    END_DATE,
    j.JOB_ID
from job_history j
    LEFT JOIN employees using(EMPLOYEE_ID)
where salary > 10000;
--13.  Write a query to display department name, name (first_name, last_name), hire date, the salary of the manager for all managers whose experience is more than 15 years.
select department_name,
    CONCAT(first_name, " ", last_name) as name,
    hire_date,
    salary
from employees e
    JOIN departments d using(DEPARTMENT_ID)
where e.EMPLOYEE_ID = d.MANAGER_ID
    AND datediff(now(), HIRE_DATE) > 365 * 15;
--1.  Write a query to list the number of jobs available in the employees table.
select *
from employees
GROUP BY JOB_ID;
--2.  Write a query to get the total salaries payable to employees.
select SUM(salary)
from employees;
--3.  Write a query to get the minimum salary from the employees table.
select MIN(salary)
from employees;
--4. Write a query to get the maximum salary of an employee working as a Programmer.
select MAX(salary)
from employees
where JOB_ID LIKE 'IT_PROG';
--5. Write a query to get the average salary and number of employees working in department 90.
SELECT AVG(salary) as avg_salary,
    count(*)
from employees
where DEPARTMENT_ID = 90;
--6. Write a query to get the highest, lowest, sum, and average salary of all employees
select max(salary),
    MIN(salary),
    sum(salary),
    AVG(salary)
from employees;
--7. Write a query to get the number of employees with the same job.
SELECT COUNT(*)
from employees
GROUP BY job_id;
--8.  Write a query to get the difference between the highest and lowest salaries.
select MAX(salary) - MIN(salary)
from employees;
--9. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager.
SELECT manager_id,
    MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY MIN(salary) DESC;
--10. Write a query to get the department ID and the total salary payable in each department.
SELECT department_id,
    sum(salary)
from employees
GROUP BY department_id;
--11. Write a query to get the average salary for each job ID excluding programmer.
SELECT job_id,
    AVG(salary)
FROM employees
WHERE job_id <> 'IT_PROG'
GROUP BY job_id;
--12. Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
SELECT job_id,
    SUM(salary),
    AVG(salary),
    MAX(salary),
    MIN(salary)
FROM employees
WHERE department_id = '90'
GROUP BY job_id;
--13. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
SELECT job_id,
    MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;
--14. Write a query to get the average salary for all departments employing more than 10 employees.
SELECT department_id,
    AVG(salary),
    COUNT(*)
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;
use hr;
use classicmodels;
-- stored routines
-- 1. IN
DELIMITER / / CREATE PROCEDURE getofficeByCountry(in countryName varchar(255)) BEGIN
select *
from offices
WHERE country = countryname;
END / / DELIMITER;
call getofficeByCountry('UK');
call getofficeByCountry('USA');
call getofficeByCountry();
-- 1. OUT
DELIMITER / / CREATE PROCEDURE getOrderCountByStatus(In orderStatus Varchar(255), OUT total INT) BEGIN
SELECT count(orderNumber) INTO total
from orders
where status = orderStatus;
END / / DELIMITER;
CALL getOrderCountByStatus('shipped', @total);
SELECT @total;
CALL getOrderCountByStatus('cancelled', @total_cancelled);
SELECT @total_cancelled;
CALL getOrderCountByStatus('in process', @total_in_process);
SELECT @total_in_process as order_in_progress;
DELIMITER / / CREATE PROCEDURE setCounter(InOut counter int, IN step INT) BEGIN
SET counter = counter + step;
END / / DELIMITER;
SET @myCounter = 1;
CALL setCounter(@myCounter, 2);
CALL setCounter(@myCounter, 3);
CALL setCounter(@myCounter, 4);
SELECT @myCounter;
use classicmodels;
DROP PROCEDURE getEmployees;
-- Create a stored procedure named getEmployees() to display the following employee and their office info: name, city, state, and country.
DELIMITER / / CREATE PROCEDURE getEmployees() BEGIN
select CONCAT(firstName, " ", lastName) as first_name,
    city,
    state,
    country
from employees
    join offices using(officeCode);
End / / DELIMITER;
CALL getEmployees();
-- Create a stored procedure named getPayments() that prints the following customer and payment info:customerName, checkNumber, paymentDate, and amount.
use classicmodels;
DROP PROCEDURE getPayments;
DELIMITER / / CREATE PROCEDURE getPayments() BEGIN
select customerName,
    checkNumber,
    PaymentDate,
    amount
from payments
    join customers using(customerNumber);
End / / DELIMITER;
CALL getPayments();
--1.  Write a query to find customers whose payments are greater than the average payment using a subquery.
select customerName,
    amount
from customers
    JOIN payments using(customerNumber)
where amount >(
        SELECT avg(amount)
        from payments
    );
--2. Use a subquery with NOT IN operator to find the customers who have not placed any orders.
select customerName
from customers
where customerNumber NOT IN (
        SELECT customerNumber
        from orders
    );
--3. Write a subquery that finds the maximum, minimum, and average number of items in sale orders from orderdetails
select MAX(orderNumber),
    MIN(orderNumber),
    avg(orderNumber)
from orderdetails;
-- 4. Unlike a standalone subquery,
-- a correlated subquery is a subquery that uses the data
-- from the outer query.In other words,
--     a correlated subquery depends on the outer query.A correlated subquery is evaluated once for each row in the outer query.See the products table: Use a correlated subquery to
-- select products whose buy prices are greater than the average buy price of all products in each product line.For each row in the products (
--         or p1
--     ) table,
--     the correlated subquery needs to execute once to get the average buy price of all products in the productline of that row.If the buy price of the current row is greater than the average buy price returned by the correlated subquery,
--     the query includes the row in the result
-- set.
--5.  Let’s take a look at the orders and orderdetails tables:Write a query that finds sales orders whose total values are greater than 60K as follows:
--10. Use the previous query as the derived table to know the number of customers in each group: platinum, gold, and silver.
-- 2nd task discussion 3
--1.  Write a query to display a list of customers who locate in the same city by joining the customers table to itself.
SELECT a.customerName,
    a.city,
    a.state
from customers a
    JOIN customers b using(city)
where a.customerName <> b.customerName;
--2. Write a query to get:
-- The productCode and productName from the products table.
-- The textDescription of product lines from the productlines table.
select productCode,
    productName,
    textDescription
from products
    JOIN productLines using(productLine);
--3.  Write a query that returns order number, order status, and total sales from the orders and orderdetails tables as follows:
select o.orderNumber,
    o.status,
    sum(quantityOrdered * priceEach)
from orders o
    Join orderDetails od using(orderNumber)
GROUP BY orderNumber;
--4. Write a query to fetch the complete details of orders from the orders, orderDetails, and products table, and sort them by orderNumber and orderLineNumber as follows:
select o.orderNumber,
    o.orderDate,
    od.orderLineNumber,
    p.productName,
    od.quantityOrdered,
    od.priceEach
from orders o
    JOIN orderDetails od USING(orderNumber)
    JOIN products p using(productCode)
ORDER BY orderNumber,
    orderLineNumber;
--5. Write a query to perform INNER JOIN of four tables:
--6. Display the details sorted by orderNumber, orderLineNumber as per the following
--7.  Each customer can have zero or more orders while each order must belong to one customer. Write a query to find all the customers and their orders as follows:
-- 8. Write a query that uses th LEFT JOIN to find customers who have no order:
-- procedeure logics....DUAL
--1.  Write a stored function called computeTax that calculates income tax based on the salary for every worker in the Worker table as follows:
-- 10% - salary <= 75000
-- 20% - 75000 < salary <= 150000
- - 30 % - salary > 150000 -- Write a query that displays all the details of a worker including their computedTax.
DELIMITER / / drop FUNCTION computeTax;
create FUNCTION computeTax (salary int) RETURNS int deterministic BEGIN
declare tax int;
if salary <= 75000 then
set tax = salary *.1;
ELSEIF salary > 75000
AND salary <= 150000 then
SET tax = salary *.2;
else
SET tax = salary *.3;
END if;
return tax;
END / / DELIMITER;
SELECT *,
    computeTax(76000)
FROM WORKER;
--2. Define a stored procedure that takes a salary as input and returns the calculated income tax amount for the input salary. Print the computed tax for an input salary from a calling program. (Hint - Use the computeTax stored function inside the stored procedure)
delimiter / / create procedure calIncomeTax(IN salary int, out incomeTax decimal(10, 2)) begin
set incomeTax = computeTax(salary);
end / / delimiter;
call calIncomeTax(5000, @income);
select @income;
--1.  Write a stored procedure that takes an INT as input and returns the factorial of the number, if the number is prime. Else, it returns a comma-separated string of the divisors of the number.
-- Example:
-- Input = 5, Output = 120
-- Input = 4, Output = "1, 2, 4, "
DELIMITER / / create PROCEDURE getFactorial(In number int) BEGIN
declare x int;
declare y int;
DECLARE str VARCHAR(225);
SET x = 1;
SET y = 1;
SET str = "1, ";
WHILE x < number -1 DO
SET x = x + 1;
SET y = y * x;
IF(number mod x = 0) THEN
SET y = 0;
SET str = CONCAT(str, x, ", ");
END IF;
END WHILE;
SET y = y * number;
SET str = CONCAT(str, number);
IF(y = 0) THEN
SELECT str;
ELSE
SELECT y;
END IF;
END / / DELIMITER;
CALL getFactorial(5);
CALL getFactorial(8);
--2.  Write a stored procedure that takes an INT as input and returns "YES" if the number is pallindrome or "NO" if the number is not pallindrome.
-- Example:
-- Input = 141, Output = "YES"
-- Input = 123, Output = "NO"
DELIMITER / / drop PROCEDURE palindrome;
CREATE PROCEDURE palindrome(in number int, out isPalindrome varchar(100)) BEGIN
DECLARE digits INT;
DECLARE reverse INT;
DECLARE copy INT;
SET copy = number;
SET digits = 0;
SET reverse = 0;
WHILE(number > 0) DO
SET digits = number mod 10;
SET reverse = reverse * 10 + digits;
SET number = number / 10;
END WHILE;
IF reverse = copy THEN
SET isPalindrome = "Yes";
ELSE
SET isPalindrome = "No";
END IF;
END / / DELIMITER;
call palindrome(1221, @isPalindrome);
SELECT @isPalindrome;
/ / triggers DELIMITER / / CREATE TRIGGER after_worker_insert
AFTER
INSERT on worker for each row BEGIN
INSERt INTO title
VALUES(new.worker_id, "new joinee", now());
END / / DELIMITER;
INSERT into worker
VALUES(10, 'kp', 'paliwal', 1000, now(), 'account');
show triggers;