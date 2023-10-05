create schema if not exists oficina;
use oficina;

create table clientes(
	cpf VARCHAR(11) primary key,
    nome VARCHAR(45) not null,
    endereco VARCHAR(100) not null,
    contato varchar(11) not null 
);
desc clientes;

insert into clientes values
	(11111111111, "Marcos Machado", "Rua sla 3", "22933334433"),
    (22222222211, "Zinedine Zidane", "Rua exemplo 3", "65433334442"),
    (33333333333, "Roberto Carlos", "Rua okok 3", "98433334441"),
    (44444455511, "Ronaldinho Gaucho", "Rua ddddddd 3", "22933334444"),
    (55555555533, "Lionel Messi", "Rua exddsadas 3", "22933334445"),
    (99988899923, "Cristiano Ronaldo", "Rua exadagfsd 3", "22933334336"),
    (12122233312, "Leonardo Lins", "Rua dasdasdasdasd 3333", "22933334337"),
    (23233322212, "Danilo Gentili", "Rua ebfbffdds 44", "22933334338"),
    (45344455533, "Marina Rui", "Rua edscdcdc 45", "2933334339"),
    (67433322231, "Nichole Bahls", "Rua ecdcdcdcdcdcd 55", "22933334321"),
    (89522233321, "Anderson Silva", "Rua eksadmadkmaskdma 45", "22933334355"),
    (19655566677, "Ronaldo Fenomeno", "Rua exdsadasdasdasdas 55", "22933334366"),
    (90700099988, "Brad Pitt", "Rua easdasdasdasdasd 5666", "22933334377"),
    (34822233312, "Katy Perry", "Rua exadagasdadasdasdfsd 999887", "22933334388");

select * from clientes;

create table departamento(
	idDepartamento INT primary key auto_increment,
    nome varchar(45) not null
);
desc departamento;

insert into departamento values
	(1, "PESQUISA"),
    (2, "MARKETING"),
    (3, "TI");
select * from departamento;

create table funcionario(
	idFunc INT NOT NULL,
    idSupervisor INT NOT NULL,
    idFDept INT not null,
    Nome VARCHAR(45) not null,
    DataNasc varchar(45),
    Endereco varchar(100),
    constraint pk_func primary key (idFunc, idSupervisor),
    constraint fk_func_dept foreign key (idFDept) references departamento(idDepartamento)
);
desc funcionario;
insert into funcionario values 
	(1, 2, 1, "Emerson Sheik", "1990-01-01", "Rua sla 20"),
    (2, 2, 1, "Bruno Henrique", "1992-02-05", "Rua exafsadasf 2321"),
    (3, 4, 2, "Fabio Santos", "1998-02-08", "Rua sdfssaf 22"),
    (4, 4, 2, "Neymar Junior", "1994-03-04", "Rua slasdasdas 44"),
    (5, 2, 1, "Marcos Silva", "1995-01-01", "Rua asadasfasf 55"),
    (6, 8, 3, "Julio Cesar", "1996-01-01", "Rua gthdafas 45"),
    (7, 8, 3, "Marcos Rocha", "1997-01-01", "Rua sadafdvf 4555"),
    (8, 8, 3, "Cleyson Pereira", "1998-01-01", "Rua saasdasdasd 99");
select * from funcionario;

create table ordem(
	idOrdem INT primary key auto_increment,
    idOFunc INT not null, 
    idOCliente VARCHAR(11) not null,
    decricao varchar(100) default null,
    constraint fk_ordem_func foreign key (idOFunc) references funcionario(idFunc),
    constraint fk_ordem_cliente foreign key (idOCliente) references clientes(CPF)
);
desc ordem;
insert into ordem values
	(1, 1, 11111111111, "esadasdasdasdasdas"),
    (2, 2, 22222222211, "esadasdasdasdasdas"),
    (3, 3, 33333333333, "esadasdasdasdasdas"),
    (4, 4, 99988899923, "esadasdasdasdasdas"),
    (5, 5, 23233322212, "esadasdasdasdasdas"),
    (6, 6, 90700099988, "esadasdasdasdasdas"),
    (7, 7, 34822233312, "esadasdasdasdasdas"),
    (8, 8, 55555555533, "esadasdasdasdasdas"),
    (9, 1, 33333333333, "esadasdasdasdasdas"),
    (10, 2, 44444455511, "esadasdasdasdasdas"),
    (11, 3, 12122233312, "esadasdasdasdasdas"),
    (12, 4, 19655566677, "esadasdasdasdasdas");
select * from ordem;

create table dependentes(
	idDfunc INT not null,
    Nome VARCHAR(45) not null,
    Tipo varchar(45) not null,
    DataNasc varchar(45) not null,
    primary key(idDfunc, Nome),
    constraint fk_dependentes_func foreign key (idDfunc) references funcionario(idFunc)
);
desc dependentes;
insert into dependentes values
	(1, "Julia Maisa", "Filha", "2010-01-02"),
    (3, "Maria Maria", "Esposa", "1999-08-09"),
    (6, "Jorge Neto", "Filho", "2016-01-04"),
    (8, "Claudia Rossi", "Filha", "2020-01-05"),
    (1, "Janaina Silva", "Esposa", "1990-05-10"),
    (5, "Marina Oliveira", "Filha", "2020-01-02");
select * from dependentes;