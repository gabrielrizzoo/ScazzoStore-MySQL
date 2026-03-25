USE loja_scazzo;

CREATE OR REPLACE VIEW VW_ESTOQUE_PRODUTOS AS
SELECT
    p.id_produto,
    p.nome_produto,
    c.nome_categoria,
    pv.id_variacao,
    pv.tamanho,
    pv.cor,
    pv.preco,
    pv.quantidade_estoque,
    f.razao_social AS fornecedor
FROM Produtos p
JOIN Categorias c ON p.id_categoria = c.id_categoria
JOIN Produto_Variacoes pv ON p.id_produto = pv.id_produto
JOIN Fornecedores f ON p.id_fornecedor = f.id_fornecedor
ORDER BY p.nome_produto, pv.tamanho, pv.cor;

CREATE OR REPLACE VIEW VW_VENDAS_SUMARIO AS
SELECT
    v.id_venda,
    v.data_venda,
    CONCAT(cl.nome, ' ', cl.sobrenome) AS cliente,
    v.valor_total,
    GROUP_CONCAT(CONCAT(p.nome_produto, ' (', pv.tamanho, ', ', pv.cor, ')') SEPARATOR '; ') AS itens_comprados
FROM Vendas v
JOIN Clientes cl ON v.id_cliente = cl.id_cliente
JOIN Itens_Venda iv ON v.id_venda = iv.id_venda
JOIN Produto_Variacoes pv ON iv.id_variacao = pv.id_variacao
JOIN Produtos p ON pv.id_produto = p.id_produto
GROUP BY v.id_venda, v.data_venda, cliente, v.valor_total;

CREATE OR REPLACE VIEW VW_RELATORIO_FINANCEIRO AS
SELECT
    YEAR(data_venda) AS ano,
    MONTH(data_venda) AS mes,
    COUNT(id_venda) AS total_de_vendas,
    SUM(valor_total) AS faturamento_mensal
FROM Vendas
GROUP BY YEAR(data_venda), MONTH(data_venda)
ORDER BY ano, mes;