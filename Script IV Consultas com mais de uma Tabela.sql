USE loja_scazzo;

SELECT
    v.id_venda, v.data_venda, v.valor_total,
    CONCAT(c.nome, ' ', c.sobrenome) AS cliente
FROM Vendas v
INNER JOIN Clientes c ON v.id_cliente = c.id_cliente
ORDER BY v.data_venda DESC;

SELECT
    p.nome_produto, pv.tamanho, pv.cor, pv.preco
FROM Produtos p
INNER JOIN Categorias c ON p.id_categoria = c.id_categoria
INNER JOIN Produto_Variacoes pv ON p.id_produto = pv.id_produto
WHERE c.nome_categoria = 'Camisetas';

SELECT
    c.id_categoria, c.nome_categoria
FROM Categorias c
LEFT JOIN Produtos p ON c.id_categoria = p.id_categoria
WHERE p.id_produto IS NULL;

SELECT
    p.nome_produto, pv.tamanho, pv.cor, pv.quantidade_estoque,
    f.razao_social AS fornecedor, f.contato_telefone
FROM Produto_Variacoes pv
JOIN Produtos p ON pv.id_produto = pv.id_produto
JOIN Fornecedores f ON p.id_fornecedor = f.id_fornecedor
WHERE pv.quantidade_estoque < 10
ORDER BY pv.quantidade_estoque ASC;