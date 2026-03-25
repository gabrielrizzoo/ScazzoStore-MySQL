USE loja_scazzo;

INSERT INTO Categorias (nome_categoria) VALUES ('Camisetas'), ('Calças'), ('Acessórios'), ('Casacos'), ('Vestidos'), ('Calçados');
INSERT INTO Fornecedores (razao_social, cnpj, contato_telefone, email) VALUES
('Malharia & Cia Ltda', '11.222.333/0001-44', '(21) 98877-6655', 'contato@malhariacia.com'),
('Jeans Premium S.A.', '22.333.444/0001-55', '(11) 97766-5544', 'vendas@jeanspremium.com.br'),
('Acessórios Estilo Único', '33.444.555/0001-66', '(31) 96655-4433', 'comercial@estilounico.com'),
('Frio Intenso Confecções', '44.555.666/0001-77', '(41) 95544-3322', 'contato@friointenso.com');

INSERT INTO Clientes (nome, sobrenome, email, telefone, data_cadastro) VALUES
('Ana', 'Souza', 'ana.souza@email.com', '(21) 91111-2222', '2025-03-15 10:30:00'),
('Bruno', 'Carvalho', 'bruno.c@email.com', '(21) 92222-3333', '2025-04-01 14:00:00'),
('Carla', 'Menezes', 'carla.menezes@email.com', '(21) 93333-4444', '2025-05-20 18:45:00'),
('Daniel', 'Lima', 'daniel.lima@email.com', '(21) 94444-5555', '2025-06-10 11:00:00');

INSERT INTO Produtos (nome_produto, descricao, id_categoria, id_fornecedor) VALUES
('Camiseta Básica Gola V', 'Camiseta de algodão com toque macio.', 1, 1),
('Calça Jeans Skinny', 'Calça jeans com elastano para maior conforto.', 2, 2),
('Cinto de Couro', 'Cinto de couro legítimo com fivela de metal.', 3, 3),
('Jaqueta Bomber', 'Jaqueta estilo bomber, ideal para meia estação.', 4, 4);

INSERT INTO Produto_Variacoes (id_produto, tamanho, cor, preco, quantidade_estoque) VALUES
(1, 'P', 'Branca', 59.90, 50), (1, 'M', 'Branca', 59.90, 80), (1, 'M', 'Preta', 59.90, 75), (1, 'G', 'Preta', 62.50, 40),
(2, 'P', 'Azul Escuro', 189.90, 30), (2, 'M', 'Azul Escuro', 189.90, 35), (2, 'G', 'Preta', 199.90, 25),
(3, 'Único', 'Marrom', 89.90, 60),
(4, 'M', 'Verde Militar', 249.90, 20), (4, 'G', 'Verde Militar', 249.90, 8);

INSERT INTO Vendas (id_cliente, data_venda, valor_total) VALUES 
(1, '2025-05-15 15:20:10', 249.80),
(2, '2025-05-22 11:40:00', 89.90),
(1, '2025-06-10 18:05:30', 249.90),
(3, '2025-06-18 12:00:00', 119.80),
(4, '2025-07-01 10:10:00', 439.70);

INSERT INTO Itens_Venda (id_venda, id_variacao, quantidade_comprada, preco_unitario) VALUES (1, 3, 1, 59.90), (1, 6, 1, 189.90);
INSERT INTO Itens_Venda (id_venda, id_variacao, quantidade_comprada, preco_unitario) VALUES (2, 8, 1, 89.90);
INSERT INTO Itens_Venda (id_venda, id_variacao, quantidade_comprada, preco_unitario) VALUES (3, 9, 1, 249.90);
INSERT INTO Itens_Venda (id_venda, id_variacao, quantidade_comprada, preco_unitario) VALUES (4, 1, 2, 59.90);
INSERT INTO Itens_Venda (id_venda, id_variacao, quantidade_comprada, preco_unitario) VALUES (5, 7, 1, 199.90), (5, 9, 1, 249.90);