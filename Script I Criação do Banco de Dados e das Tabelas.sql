-- ====================================================================
-- PROJETO BANCO DE DADOS MYSQL - LOJA DE ROUPAS SCAZZO
-- ====================================================================
-- INTEGRANTES DO GRUPO:
-- Ângelo Silva dos Santos | MA: 1230117142
-- Gabriel Duarte Rizzo do Nascimento | MA: 1230112376
-- Felipe Celestrino Monteiro | MA: 1230112049
-- Mateus Alkmim Santos | MA: 1230116481
-- Raphael Bíssimos Costa dos Santos | MA: 1230113376
-- ====================================================================

DROP DATABASE IF EXISTS loja_scazzo;
CREATE DATABASE loja_scazzo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE loja_scazzo;

CREATE TABLE Categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Fornecedores (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    razao_social VARCHAR(100) NOT NULL UNIQUE,
    cnpj VARCHAR(18) NOT NULL UNIQUE,
    contato_telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao TEXT,
    id_categoria INT NOT NULL,
    id_fornecedor INT NOT NULL,
    CONSTRAINT fk_produto_categoria FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria),
    CONSTRAINT fk_produto_fornecedor FOREIGN KEY (id_fornecedor) REFERENCES Fornecedores(id_fornecedor)
);

CREATE TABLE Produto_Variacoes (
    id_variacao INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    tamanho ENUM('P', 'M', 'G', 'GG', 'Único') NOT NULL,
    cor VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL CHECK (preco > 0),
    quantidade_estoque INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_variacao_produto FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto) ON DELETE CASCADE
);

CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_venda_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Itens_Venda (
    id_venda INT NOT NULL,
    id_variacao INT NOT NULL,
    quantidade_comprada INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_venda, id_variacao),
    CONSTRAINT fk_item_venda FOREIGN KEY (id_venda) REFERENCES Vendas(id_venda) ON DELETE CASCADE,
    CONSTRAINT fk_item_variacao FOREIGN KEY (id_variacao) REFERENCES Produto_Variacoes(id_variacao) ON DELETE RESTRICT
);

CREATE TABLE Auditoria_Produtos (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_produto_deletado INT,
    nome_produto_deletado VARCHAR(100),
    usuario_acao VARCHAR(100),
    data_hora_acao DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_cliente_email ON Clientes(email);
CREATE INDEX idx_fk_produto_categoria ON Produtos(id_categoria);
CREATE INDEX idx_fk_venda_cliente ON Vendas(id_cliente);
CREATE INDEX idx_nome_produto ON Produtos(nome_produto);