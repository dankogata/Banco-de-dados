CREATE TABLE Cliente(
	idCliente SERIAL primary key,
	Fname varchar(10),
	Minit char(3),
	Lname varchar(20),
	CPF char(11) not null,
	Endereco  varchar(30),
	constraint cpf_unico unique (CPF)
);
CREATE TYPE categorias AS ENUM ('Eletronico','Vestimenta','Brinquedos','Alimentos','Moveis');
CREATE TABLE Produto(
	idProduto serial primary key,
	Pname varchar(10),
	classificacao_kids bool default false,
	categoria categorias not null,
	avaliacao float default 0,
	tamanho varchar(10)
);
CREATE TYPE tipoPagamentos AS ENUM ('Boleto','Cartao','Dois Cartoes');
CREATE TABLE Pagamentos(
	idCliente int,
	idPagamento int,
	tipoPagamento tipoPagamentos,
	limiteDisponivel float,
	primary key(idCliente,idPagamento)
);

CREATE TYPE statusPedidos AS ENUM ('Cancelado','Confirmado','Em processamento');
CREATE TABLE Pedido(
	idPedido serial primary key,
	idPedidoCliente int, 
	statusPedido statusPedidos not null,
	descricaoPedido varchar(255),
	frete float default 10,
	pagamentoDinheiro bool default false, 
	constraint fk_pedido_cliente foreign key (idPedidoCliente) references Cliente(idCliente)	
);


CREATE TABLE estoque(
	idProdEstoque SERIAL primary key,
	localizacaoEstoque varchar(255),
	quantidade int default 0
);	
CREATE TABLE fornecedor(
	idFornecedor SERIAL primary key,
	nomeSocial varchar(255) not null,
	CNPJ char(15) not null,
	contato char(11) not null,
	constraint fornecedor_unico unique (CNPJ)
);
CREATE TABLE vendedor(
	idVendedor SERIAL primary key,	
	nomeSocial varchar(255) not null,
	apelido varchar(255),
	CNPJ char(15),
	CPF char(9),
	localizacao varchar(255),
	contato char(11) not null,
	constraint cnpj_venda_unico unique (CNPJ),
	constraint cpf_venda_unico unique (CPF)	
);

CREATE TABLE produtoVendedor(
	idPVendedor int, 
	idProduto int,
	qtdProduto int default 1, 
	primary key (idPVendedor,idProduto),
	constraint fk_produto_vendedor foreign key(idPVendedor) references vendedor(idVendedor),
	constraint fk_produto_produto foreign key(idProduto) references produto(idProduto)
);

CREATE TYPE poStatus AS ENUM ('Disponivel','Em Estoque');
CREATE TABLE orderPedido(
	idPOproduto int,
	idPOpedido int,
	poQuantidade int default 1,
	poStato poStatus default 'Disponivel',
	primary key (idPOproduto,idPOpedido),
	constraint fk_produto_vendedor foreign key(idPOproduto) references produto(idProduto),
	constraint fk_produto_produto foreign key(idPOpedido) references pedido(idPedido)
);
