-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/wa0cnI
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "dept_name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(5)   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(5)   NOT NULL,
    "emp_no" INTEGER   NOT NULL
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR(6)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "sex" VARCHAR(1)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

CREATE TABLE "titles" (
    "title_id" VARCHAR(6)   NOT NULL,
    "title" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_departments_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_titles_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

-- 1. List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON
employees.emp_no = salaries.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM "hire_date") = 1986;

/* 3. List the manager of each department with the following information: 
department number, department name, the manager's employee number, last name, first name.*/
--SELECT table.column, table.column
--FROM table
--INNER JOIN other table ON
--table.column = table.column;
SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.first_name, employees.last_name
FROM departments
INNER JOIN dept_manager ON
departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON
dept_manager.emp_no = employees.emp_no;

/* 4. List the department of each employee with the following information: 
employee number, last name, first name, and department name.*/
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no;

/* 5. List first name, last name, and sex for employees
whose first name is "Hercules" and last names begin with "B."*/
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

/* 6. List all employees in the Sales department, 
including their employee number, last name, first name, and department name.*/
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales';

/* 7. List all employees in the Sales and Development departments, 
including their employee number, last name, first name, and department name.*/
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp ON
employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON
dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

/* 8. In descending order, list the frequency count of employee last names, 
i.e., how many employees share each last name.*/
SELECT last_name, COUNT(last_name) AS "last_name_count"
FROM employees
GROUP BY last_name
ORDER BY "last_name_count" DESC;







