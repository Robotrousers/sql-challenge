
--create departments
CREATE TABLE departments (
	dept_no VARCHAR NOT NULL,
	dept_name VARCHAR NOT NULL
);

--create dept_emp
CREATE TABLE dept_emp (
	emp_no INT,
	dept_no VARCHAR NOT NULL
);


--oops
drop table dept_manager
	
--create dept_manager
CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
	emp_no INT
);

--create employees
CREATE TABLE employees (
	emp_no INT,
	dept_title_id VARCHAR NOT NULL,
	birth_date DATE,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE
);

--create salaries
CREATE TABLE salaries (
	emp_no INT,
	salary INT
);



--creat titles
CREATE TABLE titles (
	title_id VARCHAR NOT NULL,
	title VARCHAR NOT NULL
);

SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM employees;
SELECT * FROM salaries;
SELECT * FROM titles;

--1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, last_name, first_name, sex, salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no;


--2.List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
--CITE: between code - https://stackoverflow.com/questions/1630239/sql-between-vs-and

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
JOIN departments as d ON dm.dept_no = d.dept_no
JOIN employees as e ON dm.emp_no = e.emp_no
ORDER BY d.dept_no;

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
ORDER BY de.dept_no;

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.






--6.List each employee in the Sales department, including their employee number, last name, and first name.






--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.






--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).



