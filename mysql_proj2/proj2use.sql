use oficina;

-- mostra todos os funcionarios e seus departamentos
desc funcionario;
desc departamento;
select f.nome, d.nome from funcionario f
	inner join departamento d on idDepartamento=idFdept;

-- MOSTRA NUMERO DE FUNCIONARIOS POR DEPARTAMENTO
select d.nome, count(*) as numero_funcionarios from funcionario f
	inner join departamento d on idDepartamento=idFdept
    group by idDepartamento
    order by count(*);

-- MOSTRANDO SE HÁ ALGUM CLIENTE COM MESMO NOME QUE FUNCIONARIO
-- PARA TESTE ADICIONEI UM CLIENTE COM MESMO NOME DE UM FUNCIONARIO
insert into clientes values
	(33444455522, "Neymar Junior", "Rua slasdasdas 44", "22957304433");
select * from funcionario f 
	inner join clientes c on f.nome=c.nome; 

-- MOSTRANDO CLIENTES E SUAS ORDENS
select * from ordem o
	inner join clientes on idOcliente=CPF
    order by CPF;

-- MOSTRANDO CLIENTES E SEU TOTAL DE ORDENS
select nome, count(*) as total_ordens from ordem o
	inner join clientes on idOcliente=CPF
    group by nome
    order by total_ordens;

-- MOSTRANDO FUNCIONARIOS E SUAS ORDENS
select * from ordem o
	inner join funcionario on idOFunc=idFunc
    order by idOFunc;

-- MOSTRANDO FUNCIONARIOS E SUA QUANTIDADE DE ORDENS
select nome, count(*) as total_ordens from ordem o
	inner join funcionario on idOFunc=idFunc
    group by nome
    order by total_ordens;

-- MOSTRANDO QUAIS FUNCIONARIOS POSSUEM DEPENDENTES E QUANTOS SÃO
select f.nome, count(*) from funcionario f
	inner join dependentes d on idFunc=idDfunc
    group by f.nome;

-- MOSTRANDO QUAIS FUNCIONARIOS POSSUEM DEPENDENTES OU NAO
select f.nome, d.nome from funcionario f
	left join dependentes d on idFunc=idDfunc;

-- MOSTRANDO FUNCIONARIOS E SEUS DEPENDENTES
select * from funcionario
	inner join dependentes on idFunc=idDfunc;