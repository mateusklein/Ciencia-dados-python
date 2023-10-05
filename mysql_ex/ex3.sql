create database if not exists manipulation;
use manipulation;

create table bank_accounts(
	id_account Int 	auto_increment primary key,
    ag_num int not null,
    ac_num int not null,
    saldo float,
    CONSTRAINT identification_account_constraint UNIQUE (Ag_num, Ac_num)
);

alter table bank_accounts add limite_credito float not null default 500.00;
alter table bank_accounts add email varchar(60);
alter table bank_accounts drop email;

desc bank_accounts;

create table bank_client(
	id_client INT auto_increment,
    client_account int,
    cpf char(11) NOT NULL,
	rg char(9) NOT NULL,
    nome varchar(50) NOT NULL,
    endereco varchar(100) NOT NULL,
    renda_mensal float,
    primary key (id_client, client_account),
    CONSTRAINT fk_account_client foreign key (client_account) references bank_accounts(Id_account)
    ON update cascade
);

create table bank_transactions(
	id_transaction INT auto_increment primary key,
    ocorrencia datetime, 
    status_transaction VARCHAR(20),
    valor_transferido float,
    source_account int,
    destination_account int,
    constraint fk_source_transaction foreign key (source_account) 
    references bank_accounts(id_account),
    constraint fk_destination_transaction foreign key (destination_account) 
    references bank_accounts(id_account)
);
