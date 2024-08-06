--create departments
CREATE TABLE departments (
	dept_no VARCHAR(10) NOT NULL PRIMARY KEY,
	dept_name VARCHAR(50) NOT NULL
);

--creat titles
CREATE TABLE titles (
    title_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

--create employees
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    dept_title_id VARCHAR(10) NOT NULL,
    birth_date DATE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
	sex VARCHAR(10) NOT NULL,
	hire_date DATE,
    FOREIGN KEY (dept_title_id) REFERENCES titles(title_id)
);

--create salaries
CREATE TABLE salaries (
    emp_no INT PRIMARY KEY,
    salary INT,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);
	
--create dept_emp
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no VARCHAR(10),
	PRIMARY KEY (emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

--create dept_manager
CREATE TABLE dept_manager (
    dept_no VARCHAR(10),
    emp_no INT,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM titles;
SELECT * FROM salaries;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;

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
SELECT t.title, d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
JOIN departments as d ON dm.dept_no = d.dept_no
JOIN employees as e ON dm.emp_no = e.emp_no
JOIN titles as t ON e.dept_title_id = t.title_id
ORDER BY d.dept_no;

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT d.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees as e
JOIN dept_emp as de ON e.emp_no = de.emp_no
JOIN departments as d ON de.dept_no = d.dept_no
ORDER BY de.dept_no;

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments as d
JOIN dept_emp as de ON de.dept_no = d.dept_no
JOIN employees as e ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales';

--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments as d
JOIN dept_emp as de ON de.dept_no = d.dept_no
JOIN employees as e ON e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
ORDER BY d.dept_name;

--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT e.last_name, COUNT(e.last_name)
FROM departments as d
JOIN dept_emp as de ON de.dept_no = d.dept_no
JOIN employees as e ON e.emp_no = de.emp_no
GROUP BY e.last_name
ORDER BY COUNT(e.last_name) DESC;
