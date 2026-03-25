# 🛍️ ScazzoDB - Sistema de Gerenciamento de Loja de Roupas

Modelagem e implementação de um banco de dados relacional em MySQL para a loja de roupas fictícia Scazzo. O projeto abrange desde a estruturação de tabelas até a simulação de regras de negócio avançadas utilizando Stored Procedures, Triggers, Views e controle de acessos.

*Projeto acadêmico desenvolvido durante o 5º período do curso de Ciência da Computação, focado na prática de banco de dados em cenários reais.*

## 🚀 Funcionalidades e Lógica de Negócio

Este projeto vai além da simples criação de tabelas, simulando o funcionamento e as regras de negócio de um sistema comercial em produção:

* **Controle de Estoque e Vendas:** Utilização de *Stored Procedures* (`sp_realizar_venda` e `sp_repor_estoque`) com controle transacional (`COMMIT`/`ROLLBACK`) para garantir consistência nas vendas e atualização automática do estoque.
* **Auditoria e Segurança:** Implementação de um *Trigger* (`trg_auditar_produto_deletado`) que registra automaticamente o usuário e a data de qualquer exclusão de produto no sistema.
* **Relatórios Gerenciais:** Criação de *Views* dedicadas para análise de estoque por variações (`VW_ESTOQUE_PRODUTOS`), sumário detalhado de vendas (`VW_VENDAS_SUMARIO`) e balanço de faturamento mensal (`VW_RELATORIO_FINANCEIRO`).
* **Controle de Acesso (RBAC):** Simulação de um ambiente de produção com a criação do usuário/role `vendedor_scazzo`, limitando privilégios estritamente à execução de vendas e consultas de estoque.

## 🗄️ Estrutura do Banco de Dados

O banco de dados `loja_scazzo` utiliza codificação `utf8mb4` e possui a seguinte estrutura principal de tabelas:
* `Clientes` e `Fornecedores`
* `Categorias`, `Produtos` e `Produto_Variacoes` (gerenciando grade de tamanhos e cores)
* `Vendas` e `Itens_Venda`
* `Auditoria_Produtos`

## ⚙️ Como executar o projeto

Para testar o banco de dados e simular as operações da loja, execute os scripts na seguinte ordem em seu ambiente MySQL:

1.  `Script I Criação do Banco de Dados e das Tabelas.sql`: Cria o schema, as tabelas com suas constraints (Primary Keys, Foreign Keys) e os índices de otimização.
2.  `Script II Inserção de Registros nas Respectivas Tabelas.sql`: Popula o banco com dados fictícios (clientes, fornecedores, produtos e histórico de vendas) para testes.
3.  `Script III Criação de Views.sql`: Gera as visualizações pré-compiladas de relatórios.
4.  `Script IV Consultas com mais de uma Tabela.sql`: Contém *queries* soltas de exemplo (utilizando `INNER JOIN`, `LEFT JOIN` e subqueries) para extração de dados analíticos.
5.  `Script V Demais Scripts.sql`: Aplica a inteligência de negócio gerando as *Procedures*, *Triggers* e regras de usuário.

## 👥 Integrantes

Trabalho desenvolvido em grupo pelos alunos:
* **Gabriel Duarte Rizzo do Nascimento** - *Desenvolvimento Banco de Dados* - [Seu GitHub/LinkedIn]
* **Ângelo Silva dos Santos** - [[Link]](https://github.com/AngeloSilv)
* **Raphael Bíssimos Costa dos Santos** - [[Link]](https://github.com/HunterBr2099)
* **Felipe Celestrino Monteiro** - [Link]
* **Mateus Alkmim Santos** - [Link]
