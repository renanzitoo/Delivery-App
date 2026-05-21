CREATE TABLE `Cliente` (
  `id_cliente` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(150) UNIQUE NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` varchar(20),
  `endereco` varchar(200) NOT NULL
);

CREATE TABLE `Restaurante` (
  `id_restaurante` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `cnpj` char(14) UNIQUE NOT NULL,
  `telefone` varchar(20),
  `endereco` varchar(200) NOT NULL,
  `categoria` varchar(50)
);

CREATE TABLE `Produto` (
  `id_produto` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `preco` decimal(10,2) NOT NULL,
  `estoque` int NOT NULL,
  `disponivel` boolean DEFAULT true,
  `id_restaurante` int NOT NULL
);

CREATE TABLE `Pedido` (
  `id_pedido` int PRIMARY KEY AUTO_INCREMENT,
  `data_pedido` datetime NOT NULL,
  `status` varchar(30) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `id_cliente` int NOT NULL,
  `id_restaurante` int NOT NULL
);

CREATE TABLE `ItemPedido` (
  `id_item` int PRIMARY KEY AUTO_INCREMENT,
  `quantidade` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  `id_pedido` int NOT NULL,
  `id_produto` int NOT NULL
);

CREATE TABLE `Pagamento` (
  `id_pagamento` int PRIMARY KEY AUTO_INCREMENT,
  `forma_pagamento` varchar(30) NOT NULL,
  `status_pagamento` varchar(30) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `data_pagamento` datetime,
  `id_pedido` int UNIQUE NOT NULL
);

CREATE TABLE `Entregador` (
  `id_entregador` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `telefone` varchar(20),
  `placa_veiculo` varchar(10),
  `tipo_veiculo` varchar(30)
);

CREATE TABLE `Entrega` (
  `id_entrega` int PRIMARY KEY AUTO_INCREMENT,
  `status_entrega` varchar(30) NOT NULL,
  `tempo_estimado` int,
  `data_saida` datetime,
  `data_entrega` datetime,
  `id_pedido` int UNIQUE NOT NULL,
  `id_entregador` int NOT NULL
);

ALTER TABLE `Produto` ADD FOREIGN KEY (`id_restaurante`) REFERENCES `Restaurante` (`id_restaurante`);

ALTER TABLE `Pedido` ADD FOREIGN KEY (`id_cliente`) REFERENCES `Cliente` (`id_cliente`);

ALTER TABLE `Pedido` ADD FOREIGN KEY (`id_restaurante`) REFERENCES `Restaurante` (`id_restaurante`);

ALTER TABLE `ItemPedido` ADD FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`);

ALTER TABLE `ItemPedido` ADD FOREIGN KEY (`id_produto`) REFERENCES `Produto` (`id_produto`);

ALTER TABLE `Pagamento` ADD FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`);

ALTER TABLE `Entrega` ADD FOREIGN KEY (`id_pedido`) REFERENCES `Pedido` (`id_pedido`);

ALTER TABLE `Entrega` ADD FOREIGN KEY (`id_entregador`) REFERENCES `Entregador` (`id_entregador`);
