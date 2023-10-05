use company_constraints;
show tables;


insert into employee values ("John", "B", "Smith", 123456789, "1965-01-09", "731-Fordem-Houston-TX", "M", 30000, Null, 5);


insert into employee values ("Jose", "S", "Andre", 123456782, "1972-01-10", "223-Fordem-Houston-TX", "M", 20000, 123456789, 5),
                            ("Ana", "B", "Andrade", 123456783, "1995-04-11", "712-Fordem-Houston-TX", "F", 10000, 123456782, 4),
                            ("Jorge", "R", "Sdasdas", 123456784, "1991-05-09", "744-Fordem-Houston-TX", "M", 30000, 123456783, 4),
                            ("Lucas", "T", "Aasdasd", 123456785, "1992-06-12", "009-Fordem-Houston-TX", "M", 30000, 123456782, 5),
                            ("Armando", "G", "Cgagsa", 123456786, "1980-07-10", "002-Fordem-Houston-TX", "M", 33000, Null, 5),
                            ("Joana", "H", "Sasdas", 123456787, "1990-08-08", "733-Fordem-Houston-TX", "F", 40000, 123456786, 4),
                            ("Leticia", "N", "Sfafa", 123456788, "1979-09-03", "734-Fordem-Houston-TX", "F", 25000, 123456786, 5);

insert into dependent values (123456786, "Alice", "F", "1994-04-05", "Daughter"),
							 (123456788, "Mario", "M", "1999-04-05", "Son"),
						     (123456782, "Henrique", "M", "1998-04-05", "Son"),
                             (123456782, "Maria", "F", "1999-04-05", "Daughter"),
                             (123456786, "Marta", "F", "1999-04-05", "Daughter"),
                             (123456786, "Laura", "F", "1981-04-05", "Spouse");
                             
insert into department values ("Research", 5, 123456786, "2006-02-12", "2000-01-01"),
							  ("Administration", 4, 123456789, "2001-02-12", "1998-01-01"),
							  ("Headquarters", 1, 123456782, "1996-02-12", "1992-01-01");

insert into department_locations values (1, "Houston"),
									   (4, "Stafford"),
                                       (1, "Bellaire"),
                                       (5, "Sugarland"),
                                       (5, "Houston");
                                       
insert into project values ("ProductX", 1, "Bellaire", 5),
						   ("ProductY", 2, "Sugarland", 5),
                           ("ProductZ", 3, "Houston", 5),
                           ("Computerization", 10, "Stafford", 4),
                           ("Reorganization", 20, "Houston", 1),
                           ("Newbenefits", 30, "Stafford", 4);
                           
insert into works_on values (123456789, 10, 32.5),
							(123456788, 1, 40.5),
                            (123456786, 2, 20.5),
                            (123456782, 30, 33.5),
                            (123456783, 20, 30.0),
                            (123456785, 1, 28.0),
                            (123456787, 2, 22.5),
                            (123456784, 20, 43.5);
                            
select * from employee;
select * from dependent;
select * from department;
select * from department_locations;
select * from project;
select * from works_on;

select Ssn, Fname, Dname from employee e, department d where(e.Ssn = d.Mgr_ssn);

select Relationship, Fname, Dependent_name from employee, dependent where Essn=Ssn;

select Bdate, address from employee where Fname="John" and Minit="B" and Lname="Smith";

select * from department where Dname="Research";

select Fname, Lname, address from employee, department where Dname="Research" and Dnumber=Dno;

select Dname, l.Dlocation as Department_name from department as d, department_locations as l where d.Dnumber = l.Dnumber;

select concat(Fname, " ",Lname) as Employee from employee; 