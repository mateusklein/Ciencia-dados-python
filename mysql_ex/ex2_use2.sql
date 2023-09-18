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
