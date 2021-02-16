CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "sex" varchar   NOT NULL,
    "hire_date" varchar   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

select * from employees

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

select * from employees
select * from salaries

CREATE TABLE "department" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_department" PRIMARY KEY (
        "dept_no"
     )
);

select * from department

CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL
);

select * from dept_manager

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL
);

select * from dept_emp

--#1 List employee number, last name, first name, sex, and salary

select e.emp_no, e.last_name,e.first_name,e.sex,s.salary
from salaries as s
inner join employees as e on
e.emp_no=s.emp_no;

--#2 List first name, last name, and hire date for employees who were hired in 1986
	--convert hire date from string value to date format

create view emp_hire_date as
select to_date(hire_date,'MM/DD/YYYY'), last_name, first_name
from employees

select * from emp_hire_date

select first_name, last_name, to_date
from emp_hire_date
where to_date between '1986-01-01' and '1986-12-31'

--#3 List the manager for each department; department number, department name, manager's employee number, last_name, first_name

select dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name 
from dept_manager as dm
join department as d on d.dept_no=dm.dept_no
join employees as e on e.emp_no=dm.emp_no;

--#4 List the department for each employee with the following information; employee number, last name, first name and department name

Create view emp_by_dept as
select e.emp_no, e.last_name, e.first_name, de.dept_no, d.dept_name
from employees as e
left join dept_emp as de on e.emp_no=de.emp_no
left join department as d on de.dept_no=d.dept_no

select * from "emp_by_dept";

--#5 List the first name, last name, and sex for employees whose first name is 'Hercules' and last names begin with 'B'

select first_name, last_name, sex
from employees
where first_name='Hercules'
and last_name like 'B%';

--#6 List all employees all employees in sales departments by employee number, last name, first name, and department name

select * from emp_by_dept
where dept_name='Sales';

--#7 List all employees in the sales and development departments; employee number, last name, first name, and department name

select * from emp_by_dept
where dept_name='Sales'
or dept_name='Development'
 
--#8 In decending order, list the frequency count of employee last names, i.e. how many employees share each last name

select last_name, count(*)as "name_count"
from employees
group by last_name
order by "name_count" desc;
