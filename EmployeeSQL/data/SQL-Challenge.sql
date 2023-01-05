

CREATE TABLE departments(
	dept_no VARCHAR (30) PRIMARY KEY,
	dept_name VARCHAR (30)
);



CREATE TABLE titles(
	title_id VARCHAR (30) PRIMARY KEY,
	title VARCHAR (30)
);



CREATE TABLE employees(
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR (30) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR (30) NOT NULL,
	last_name VARCHAR (30) NOT NULL,
	sex VARCHAR (30) NOT NULL,
	hire_date DATE NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);


CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR (30) NOT NULL,	
  	PRIMARY KEY (emp_no, dept_no),
 	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
 	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);



CREATE TABLE dept_manager(
	dept_no VARCHAR (30) NOT NULL,
	emp_no INTEGER NOT NULL,
 	PRIMARY KEY (emp_no,dept_no),
 	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
 	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);



CREATE TABLE salaries(
	emp_no INTEGER PRIMARY KEY,
	salary INTEGER NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);


--Check all tables are working
SELECT * FROM departments LIMIT(10);
SELECT * FROM titles LIMIT(10);
SELECT * FROM employees LIMIT(10);
SELECT * FROM dept_emp LIMIT(10);
SELECT * FROM dept_manager LIMIT(10);
SELECT * FROM salaries LIMIT(10);


--Q1 List the employee number, last name, first name, sex, and salary of each employee
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees 
JOIN salaries ON employees.emp_no = salaries.emp_no
LIMIT (10);


--Q2 List the first name, last name, and hire date for the employees who were hired in 1986 
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees 
WHERE extract(year from hire_date) = 1986
LIMIT (10);


--Q3 List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN employees ON dept_manager.emp_no = employees.emp_no
LIMIT (10);

--Q4 List the department number for each employee along with that employee’s employee number, last name, 
--first name, and department name
SELECT Dept_Emp.Dept_No,employees.emp_no, employees.last_name, employees.first_name, departments.dept_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no 
LIMIT (10);

--Q5 List first name, last name, and sex of each employee whose first name is Hercules 
--and whose last name begins with the letter B
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees WHERE first_name = 'Hercules' AND last_name LIKE 'B%'
LIMIT (10);

--Q6 List each employee in the Sales department, including their employee number, last name, and first name
SELECT employees.emp_no, employees.last_name, employees.first_name 
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' 
LIMIT (10);

--Q7 List each employee in the Sales and Development departments, including their employee number, 
--last name, first name, and department name 
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'
LIMIT (10);


--Q8 List the frequency counts, in descending order, of all the employee last names 
--(Listed employees sharing each last name)
--Created under alias 'Surname Count' for clarity 
SELECT employees.last_name, COUNT(last_name) AS "Surname Count"
FROM employees
GROUP BY last_name
ORDER BY "Surname Count" DESC;