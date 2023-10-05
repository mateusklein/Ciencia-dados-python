create schema if not exists company_constraints;
use company_constraints;

select * from information_schema.table_constraints
	where constraint_schema = "company_constraints";

create table employee(
	Fname varchar(15) NOT NULL,
    Minit char,
    Lname varchar(15) not null,
    Ssn char(9) NOT NULL,
    Bdate date,
    Address varchar(30),
    Sex char,
    Salary decimal(10, 2),
    Super_ssn char(9),
    Dno int NOT NULL,
    constraint chk_salary_employee check (Salary > 2000.0),
    constraint pk_employee PRIMARY KEY (Ssn)
);
desc employee;

alter table employee
	add constraint fk_employee
    foreign key	(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

create table department(
	Dname varchar(15) not null,
    Dnumber int not null,
	Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_date_dept check (Dept_create_date < Mgr_start_date),
    constraint pk_dept primary key (dnumber),
    constraint unique_name_dept unique (Dname),
    Foreign key (Mgr_ssn) references employee(Ssn)
);

alter table department drop constraint department_ibfk_1;
alter table department 
	add constraint fk_dept foreign key(Mgr_ssn) references employee(Ssn)
    on update cascade;

create table department_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    constraint pk_dept_locations primary key (Dnumber, Dlocation),
    constraint fk_dept_locations foreign key (Dnumber) references department(Dnumber)
);

alter table department_locations drop constraint fk_dept_locations;
alter table department_locations
	add constraint fk_dept_locations foreign key(Dnumber) references department(Dnumber)
    on delete cascade
    on update cascade;

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
    constraint unique_project unique(Pname),
    constraint fk_project foreign key (Dnum) references department(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3, 1) not null,
    primary key (Essn, Pno),
    constraint fk_employee_worsk_on foreign key (Essn) references employee(Ssn),
    constraint fk_project_worsk_on foreign key (Pno) references project(Pnumber)
);

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex char,
    Bdate date,
    Relationship varchar(8),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);