use company_constraints;
show tables;

select Fname, Lname, Salary, Salary*0.011 AS INSS from employee;
select Fname, Lname, Salary, round(Salary*0.011) AS INSS from employee;

/*definir um aumento para os gerentes que trabalham no projeto associado ao produtox*/

select * 
	from employee e, works_on as w, project as p
	where (e.Ssn=w.Essn and w.Pno=p.Pnumber and p.Pname="Productx"); 

select concat(Fname, Lname) as Complete_name, Salary, round(1.1*Salary, 2) as increamed_salary
	from employee e, works_on as w, project as p
	where (e.Ssn=w.Essn and w.Pno=p.Pnumber and p.Pname="Productx"); 	

select concat(e.Fname, " ", e.Lname) as Nome, e.Address from employee e, department d
	where d.Dname = "Research" and d.Dnumber = e.Dno;

select * from employee;

select concat(Fname, " ", Lname) Complete_name, Address from employee
	where (Address like "%Houston%");
    
select concat(Fname, " ", Lname) Complete_name, Dname, Address as department_name from employee, department
	where (Dno=Dnumber and Address like "%Houston%");
    
select Fname, Lname from employee where(Salary > 30000 and Salary < 40000);

select Fname, Lname from employee where(Salary between 20000 and 40000);

select concat(e.Fname, " ", e.Lname) as empregados_com_dependentes from employee as e
	where exists (select * from dependent as d 
					where E.Ssn = d.Essn);
                    
select concat(e.Fname, " ", e.Lname) as empregados_sem_dependentes from employee as e
	where not exists (select * from dependent as d 
					where E.Ssn = d.Essn);
<<<<<<< HEAD

-- clausulas de ordenação
select * from employee order by Fname, Lname;

select distinct d.Dname, concat(e.Fname, " ", e.Lname) as Manager, Address
	from department as d, employee as e, works_on as w, project p
	where(d.Dnumber = e.Dno and e.Ssn = d.Mgr_ssn and w.Pno=p.Pnumber)
    order by d.Dname;

select d.Dname as department, concat(e.Fname, " ", e.Lname) as Employee, p.Pname as Project_name, Address
	from department as d, employee as e, works_on w, project p 
    where(d.Dnumber = e.Dno and e.Ssn = w.Essn and w.Pno = p.Pnumber)
    order by d.Dname desc, e.Fname asc, e.Lname asc;

-- agrupamento

select count(*) from employee, department
	where Dno=Dnumber and Dname="Research";
    
select count(*) as number_of_employees, round(avg(salary), 2) from employee
	group by Dno;

select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber=Pno
	group by Pnumber, Pname;

select sum(salary) as total_sal, max(salary) as max_sal, min(salary) as mini_sal, avg(salary) as Avg_sal from employee;

select sum(salary) as total_sal, max(salary) as max_sal, min(salary) as mini_sal, avg(salary) as Avg_sal 
	from(employee join department on Dno=Dnumber)
    where Dname="Research";

select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber=Pno
    group by Pnumber, Pname;

select Pnumber, Pname, count(*)
	from project, works_on
    where Pnumber=Pno
    group by Pnumber, Pname
    having count(*)>=2;
    

-- CASE STATEMENT E JOIN

select Fname, Salary, Dno from employee;

update employee set Salary=
	case
		when Dno = 5 then Salary+2000
        when Dno = 5 then Salary+1500
        when Dno = 5 then Salary+3000
        else Salary+0
	end;

select * from employee, works_on where Ssn=Essn;
select * from employee JOIN works_on on Ssn=Essn;
select * from employee JOIN department on Ssn=Mgr_ssn;

select Fname, Lname, Address
	from  (employee join department on Dno=Dnumber) 	
    where Dname = "Research";

show tables;
select * from department_locations;
select * from department;

select Dname as Department, Dept_create_date as StartDate, Dlocation as Location 
	from department JOIN department_locations using (Dnumber)
    order by StartDate;
    
-- JOIN COM 3 OU MAIS TABELAS
select * from employee 
	inner join works_on on Ssn=Essn
    inner join project on Pno=Pnumber
    order by Pnumber;

select concat(Fname, "", Lname) as complete_name, Dno as department_number, Pname as project_name, Pno as project_number,
	Plocation as location from employee
    inner join works_on on Ssn=Essn
    inner join project on Pno=Pnumber
    where Pname like "Product%"
    order by Pnumber;

select * from department
	inner join department_locations using(Dnumber)
    inner join employee on Ssn=Mgr_ssn;


-- outer join
select * from employee;
select * from dependent;

select * from employee left outer join dependent on Ssn=Essn;

select * from employee right outer join dependent on Ssn=Essn;
=======
>>>>>>> 8fcd2321d6a2f4cd3e1d1b66118759fbcf8597f8
