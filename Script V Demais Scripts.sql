USE loja_scazzo;

UPDATE Clientes SET telefone = '(21) 99999-8888' WHERE id_cliente = 2;

SELECT COUNT(*) AS total_de_clientes FROM Clientes;

SELECT c.nome, SUM(v.valor_total) AS total_gasto
FROM Vendas v JOIN Clientes c ON v.id_cliente = c.id_cliente
GROUP BY c.id_cliente ORDER BY total_gasto DESC;

SELECT nome, sobrenome FROM Clientes
WHERE id_cliente IN (
    SELECT v.id_cliente FROM Vendas v
    JOIN Itens_Venda iv ON v.id_venda = iv.id_venda
    JOIN Produto_Variacoes pv ON iv.id_variacao = pv.id_variacao
    JOIN Produtos p ON pv.id_produto = p.id_produto
    WHERE p.nome_produto = 'Jaqueta Bomber'
);

DELIMITER //
CREATE PROCEDURE sp_realizar_venda(
    IN p_id_cliente INT, IN p_id_variacao INT, IN p_quantidade_comprada INT
)
BEGIN
    DECLARE v_estoque_atual INT;
    DECLARE v_preco_unitario DECIMAL(10,2);
    
    SELECT quantidade_estoque, preco INTO v_estoque_atual, v_preco_unitario
    FROM Produto_Variacoes WHERE id_variacao = p_id_variacao;
    
    START TRANSACTION;
    IF v_estoque_atual >= p_quantidade_comprada THEN
        INSERT INTO Vendas (id_cliente, valor_total) VALUES (p_id_cliente, p_quantidade_comprada * v_preco_unitario);
        SET @venda_id = LAST_INSERT_ID();
        INSERT INTO Itens_Venda (id_venda, id_variacao, quantidade_comprada, preco_unitario) VALUES (@venda_id, p_id_variacao, p_quantidade_comprada, v_preco_unitario);
        UPDATE Produto_Variacoes SET quantidade_estoque = v_estoque_atual - p_quantidade_comprada WHERE id_variacao = p_id_variacao;
        COMMIT;
    ELSE
        ROLLBACK;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE sp_repor_estoque(
    IN p_id_variacao INT, IN p_quantidade_adicionada INT
)
BEGIN
    IF p_quantidade_adicionada > 0 THEN
        UPDATE Produto_Variacoes SET quantidade_estoque = quantidade_estoque + p_quantidade_adicionada
        WHERE id_variacao = p_id_variacao;
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER trg_auditar_produto_deletado
BEFORE DELETE ON Produtos
FOR EACH ROW
BEGIN
    INSERT INTO Auditoria_Produtos (id_produto_deletado, nome_produto_deletado, usuario_acao)
    VALUES (OLD.id_produto, OLD.nome_produto, USER());
END //
DELIMITER ;

DROP USER IF EXISTS 'vendedor_scazzo'@'localhost';
CREATE USER 'vendedor_scazzo'@'localhost' IDENTIFIED BY 'senha123';

GRANT EXECUTE ON PROCEDURE loja_scazzo.sp_realizar_venda TO 'vendedor_scazzo'@'localhost';
GRANT EXECUTE ON PROCEDURE loja_scazzo.sp_repor_estoque TO 'vendedor_scazzo'@'localhost';
GRANT SELECT ON loja_scazzo.VW_ESTOQUE_PRODUTOS TO 'vendedor_scazzo'@'localhost';
GRANT SELECT ON loja_scazzo.Clientes TO 'vendedor_scazzo'@'localhost';

FLUSH PRIVILEGES;