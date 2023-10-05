-- criação do banco de dados para o cenario de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient INT auto_increment primary key,
	Fname varchar(10),
	Minit char(3),
    Lname varchar(20),
    cpf VARCHAR(11),
    cnpj VARCHAR(14),
    Address varchar(100),
    Bdate date,
    constraint unique_cpf_client unique(CPF),
    tipo ENUM("PF","PJ") NOT NULL
);
alter table clients auto_increment=1;
ALTER TABLE clients
ADD CONSTRAINT check_tipo_conta
CHECK (
    (tipo = 'PF' AND cpf IS NOT NULL AND cnpj IS NULL) OR
    (tipo = 'PJ' AND cnpj IS NOT NULL AND cpf IS NULL)
);
select * from clients;
desc clients;

-- criar tabela produto
create table product(
	idProduct INT auto_increment primary key,
	Pname varchar(40) not null,
    Classification_kids bool default false,
    Category enum("Eletronico", "Vestimenta", "Brinquedos", "Alimentos", "Moveis") not null,
    Avaliacao float default 0,
    Size varchar(10)
);
desc product;

-- para ser continuado: terminar de implementar a tabela e criar a conexao com tabelas necessarias
-- reflita essa modificacao no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento

-- criar tabela pedido
create table orders(
	idOrder int auto_increment primary key,
	idOrderClient int,
	orderStatus enum("Cancelado","Confirmado","Em processamento") default "Em Processamento",
    orderDescription varchar(255),
    tipo_pgto ENUM("BOLETO", "PIX", "CARTAO", "DOIS CARTOES") not null default "BOLETO",
    valor_total float default 0,
    valor1 int,
    valor2 int,
    constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);
ALTER TABLE orders
ADD CONSTRAINT check_tipo_pgto
CHECK (
    (tipo_pgto = 'DOIS CARTOES' AND valor1 IS NOT NULL AND valor2 IS NOT NULL) OR
    ((tipo_pgto = 'PIX' OR tipo_pgto = 'BOLETO' OR tipo_pgto = 'CARTAO') AND (valor_total=valor1) IS NOT NULL AND valor2 IS NULL)
);
desc orders;

create table entrega(
	id_entrega int,
	cod_entrega varchar(20) primary key,
    status_entrega varchar(30),
    constraint fk_entrega_orders foreign key (id_entrega) references orders(idOrder)
);

-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela forncedor
create table supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
);
desc supplier;

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    abstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
);
desc seller;

create table productSeller(
	idPseller int,        
    idProduct int,
    prodQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduct) references product(idProduct)  
);	
desc productSeller;

create table productOrder(
	idPOproduct int,        
    idOorder int,
    poQuantity int default 1,
    poStatus enum("Disponivel","Sem estoque") default "Disponivel",
    primary key (idPOproduct, idOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idOorder) references orders(idOrder)  
);
desc productOrder;

create table storageLocation(
	idLproduct int,        
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)  
);
desc storageLocation;

create table productSupplier(
	idPsSupplier int,        
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)  
);
desc productSupplier;

show tables;

use information_schema;
desc table_constraints;

select * from referential_constraints where constraint_schema = "ecommerce";
insert into clients (Fname, Minit, Lname, CPF, CNPJ, Address, tipo)
	values ("Maria", "M", "Silva", 12346789011, null, "Rua silva de prata 29, carangolas - Cidade das flores", "PF"),
			("Mateus", "O", "Pimentel", 11223321233, null, "Av paulista 2, sao paulo - SP", "PF"),
            ("Ricardo", "F", "Silva", null, 55564323412110, "Av jorginho 223, maringa - Parana", "PJ"),
            ("Julia", "S", "Franca", null, 09844422313190, "Rua estados unidos 22, sao paulo - SP", "PJ"),
            ("Roberta", "G", "Assis", 14455676512, null, "Estrada sei la 2223, pirituba - Cidade das flores", "PF"),
            ("Isabela", "M", "Cruz", 35409875412, null, "Rua exemplo 43, carangolas - Cidade das flores", "PF");
select * from clients;

insert into product (Pname, classification_kids, category, avaliacao, size)
	values ("Fone de ouvido", false, "Eletronico", 4, null),
			("Barbie", true, "Brinquedos", 3, null),
            ("Body Carteres", true, "Vestimenta", 5, null),
            ("Microfone Vedo", false, "Eletronico", 4, null),
            ("Sofa retratil", false, "Moveis", 3, "3x57x80");
select * from product;
            
insert into orders (idOrderClient, orderStatus, orderDescription, tipo_pgto, valor_total, valor1, valor2)
	values (1, null, "compra via aplicativo", "CARTAO", 150, 150, NULL),
			(2, null, "compra via aplicativo", "DOIS CARTOES", 200, 80, 120),
            (3, "Confirmado", null, "BOLETO", 50, 50, NULL),
            (4, null, "compra via web site", "PIX", 150, 150, NULL);
select * from orders;

insert into entrega (id_entrega, cod_entrega, status_entrega)
	values(1, "DD12345BR", "CHEGANDO AO DESTINATARIO"),
		  (2, "AB12550BR", "SAINDO DO ESTOQUE"),
          (3, "BA14345BR", "NOTA GERADA"),
          (4, "CD12845BR", "EM TRANSITO");
select * from entrega;

insert into productOrder (idPOproduct, idOorder, poQuantity, poStatus)
	values 	(1,1,2,null),
			(2,1,1,null),
            (3,2,1,null);
select * from productOrder;

insert into productStorage (storageLocation, quantity)
	values ("Rio de janeiro", 1000),
			("Rio de janeiro", 500),
            ("Sao Paulo", 10),
            ("Sao Paulo", 100),
            ("Sao Paulo", 10),
            ("Brasilia", 60);
select * from productStorage;

insert into storageLocation (idLproduct, idLstorage, location)
	values (1,2,"RJ"),
		   (2,6,"GO");
select * from storageLocation;
           
insert into supplier (socialName, CNPJ, contact)
	values ("Almeida e filhos", 2345667999190, "1222223333"),
		   ("Eletronicos Silva", 22345654004109, "1123453212"),
		   ("Eletronicos Valma", 11234678999193, "2122234456");
select * from supplier;

insert into productSupplier (idPsSupplier, idPsProduct, quantity)
	values (1,1,500),
		   (1,2,400),
           (2,3,633),
           (3,3,5),
           (2,2,10);
select * from productSupplier;

insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact)
	values ("Tech eletronics", null, 12234444321212, null, "RJ", "9890983453"),
		   ("Boutique Durgas", null, null, 333222221, "RJ", "3390988909"),
           ("Kids World", null, 22234444321216, null, "SP", "1123456543");
select * from seller;

insert into productSeller (idPseller, idProduct, prodQuantity)
	values (1,1,80),
		   (2,2,10);
select * from productSeller;