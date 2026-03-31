# 🛒 Projeto SGV - Sistema de Gerenciamento de Vídeos (E-commerce)

## 📝 Descrição do Projeto
Este projeto acadêmico foca no desenvolvimento de uma solução de banco de dados relacional para a empresa **Melhores Compras**. O objetivo principal é gerenciar a integração de vídeos informativos aos produtos da plataforma de e-commerce.

O desafio consistiu em corrigir e expandir um modelo lógico incompleto, transformando-o em um modelo físico funcional que respeita **18 regras de negócio (RN) críticas**.

## 🛠️ Principais Funcionalidades Modeladas
* **Gestão de Produtos e Categorias:** Controle de ciclo de vida de produtos com status de atividade e categorização única.
* **Sistema de Vídeos Multimídia:** Associação de múltiplos vídeos a um produto, com controle de status (Ativo, Inativo, Bloqueado) e categorias específicas.
* **Rastreamento de Visualizações:** Registro detalhado de interações (data/hora) tanto para usuários logados quanto anônimos.
* **Módulo de SAC (Atendimento):** Gerenciamento de chamados de sugestão ou reclamação, incluindo métricas de tempo de atendimento e índice de satisfação (1-10).

## 🚀 Destaques Técnicos Aplicados
* **Integridade de Dados:** Implementação rigorosa de `CHECK CONSTRAINTS` (ex: status 'A', 'I', 'P') e `UNIQUE KEYS` (ex: EAN13, Siglas).
* **Padronização:** Uso de boas práticas para nomenclatura de tabelas (prefixos do projeto), colunas e comentários detalhados em todos os objetos.
* **Automação:** Configuração de `SEQUENCES` ou `IDENTITY` para chaves primárias numéricas.
* **Ciclo de Vida:** Modelagem de datas de início e término (`NULL` representando validade indeterminada) para produtos, categorias e vídeos.

## 🗂️ Estrutura do Repositório
* `/modelagem`: Arquivos do modelo lógico e relacional.
* `/scripts`: Scripts SQL de criação das tabelas, restrições e relacionamentos.
* `/documentacao`: Estudo de caso completo e dicionário de dados.


## 📁 Acesso ao Projeto
Clique no link abaixo para visualizar os arquivos e a modelagem completa:
👉 [Acessar Pasta do Projeto SGV](./PBL_1º_Ano_Fase1_TheOutliers)
