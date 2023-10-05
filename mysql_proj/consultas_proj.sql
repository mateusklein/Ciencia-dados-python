use ecommerce;

select count(*) from clients;
select * from clients c, orders o where c.idClient=idOrderClient;

select concat(Fname, " ", Lname) as Cliente, idOrder as Request, orderStatus from clients c, orders o where c.idClient=idOrderClient;

select idClient, count(*) from clients c, orders o 
where c.idClient=idOrderClient
group by idClient;

select * from clients left outer join orders on idClient=idOrderClient;

-- Quantos pedidos foram feitos por cada cliente?
select idClient, count(*) from clients c, orders o 
where c.idClient=idOrderClient
group by idClient;

-- Algum vendedor também é fornecedor?
-- ADICIONANDO UM SELLER QUE JA ESTA NA LISTA DE SUPPLIER PARA TESTAR
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contact)
	values ("Loja Informatica", null, 2345667999190, null, "SP", "8899955254");

select a.socialName as name_supplier, b.socialName as name_seller, a.CNPJ from supplier a
inner join seller b
on a.CNPJ=b.CNPJ;

-- Relação de produtos fornecedores e estoques;
select Pname, socialName, storageLocation, p.quantity from productsupplier 
	inner join supplier on idPsSupplier=idSupplier 
    inner join product on idProduct=idPsProduct
    inner join storagelocation on idPsProduct=idLproduct
    inner join productstorage as p on idLstorage=idProdStorage;

-- Relação de nomes dos fornecedores e nomes dos produtos;
select socialName, Pname from productsupplier 
	inner join supplier on idPsSupplier=idSupplier 
    inner join product on idProduct=idPsProduct;

-- ORDENS E SITUAÇÃO DA ENTREGA
select idOrder, orderDescription, status_entrega, cod_entrega from entrega 
	inner join orders on idOrder = id_entrega
    order by idOrder;

-- CONTANDO QUANTAS VENDAS TEMOS POR TIPO DE PAGAMENTO
insert into orders (idOrderClient, orderStatus, orderDescription, tipo_pgto, valor_total, valor1, valor2)
	values (1, null, "compra via aplicativo", "CARTAO", 150, 150, NULL),
			(2, null, "compra via aplicativo", "CARTAO", 200, 200, null),
            (5, "Confirmado", null, "BOLETO", 50, 50, NULL),
            (6, null, "compra via web site", "PIX", 150, 150, NULL);
select * from orders;

select tipo_pgto, count(*) from orders group by tipo_pgto;

-- MOSTRANDO VENDEDORES E QUAIS SÃO SEUS PRODUTOS
select socialName, Pname from Seller 
	inner join productSeller as a on idPseller=idSeller
    inner join product as b on a.idProduct=b.idProduct;

-- MOSTRANDO VENDEDORES QUE POSSUEM PRODUTOS
select * from Seller 
	inner join productSeller as a on idPseller=idSeller;

select * from Seller, productSeller
	WHERE idPseller=idSeller;