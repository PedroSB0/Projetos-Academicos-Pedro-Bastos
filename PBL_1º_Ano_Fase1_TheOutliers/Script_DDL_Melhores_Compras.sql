-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2025-09-14 17:39:04 BRT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

DROP TABLE MC_VISUALIZAÇÃO CASCADE CONSTRAINTS;

DROP TABLE MC_VIDEO CASCADE CONSTRAINTS;

DROP TABLE MC_SGV_SAC CASCADE CONSTRAINTS;

DROP TABLE MC_PRODUTO CASCADE CONSTRAINTS;

DROP TABLE MC_LOGRADOURO CASCADE CONSTRAINTS;

DROP TABLE MC_FUNCIONARIO CASCADE CONSTRAINTS;

DROP TABLE MC_ESTADO CASCADE CONSTRAINTS;

DROP TABLE MC_END_FUNC CASCADE CONSTRAINTS;

DROP TABLE MC_END_CLI CASCADE CONSTRAINTS;

DROP TABLE MC_DEPTO CASCADE CONSTRAINTS;

DROP TABLE MC_CLIENTE CASCADE CONSTRAINTS;

DROP TABLE MC_CIDADE CASCADE CONSTRAINTS;

DROP TABLE MC_CATEGORIA CASCADE CONSTRAINTS;

DROP TABLE MC_BAIRRO CASCADE CONSTRAINTS;


CREATE TABLE MC_BAIRRO 
    ( 
     CD_BAIRRO      NUMBER (8)  NOT NULL , 
     CD_CIDADE      NUMBER (8)  NOT NULL , 
     NM_BAIRRO      VARCHAR2 (45)  NOT NULL , 
     NM_ZONA_BAIRRO VARCHAR2 (20) 
    ) 
;

COMMENT ON COLUMN MC_BAIRRO.CD_BAIRRO IS 'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_BAIRRO.CD_CIDADE IS 'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_BAIRRO.NM_BAIRRO IS 'Esta coluna ira receber o nome do Bairro. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_BAIRRO.NM_ZONA_BAIRRO IS 'Esta coluna irá receber a localização da zona onde se encontra o bairro. Alguns exemplos: Zona Norte, Zona Sul, Zona Leste, Zona Oeste, Centro.' 
;

ALTER TABLE MC_BAIRRO 
    ADD CONSTRAINT PK_MC_BAIRRO PRIMARY KEY ( CD_BAIRRO ) ;

CREATE TABLE MC_CATEGORIA 
    ( 
     CD_CATEGORIA     NUMBER  NOT NULL , 
     TP_CATEGORIA     CHAR (1)  NOT NULL , 
     SG_CATEGORIA     VARCHAR2 (5) , 
     NM_CATEGORIA     VARCHAR2 (100)  NOT NULL , 
     DS_CATEGORIA     VARCHAR2 (4000) , 
     ST_CATEGORIA     CHAR (1)  NOT NULL , 
     DT_FIM_CATEGORIA TIMESTAMP 
    ) 
;

ALTER TABLE MC_CATEGORIA 
    ADD 
    CHECK (TP_CATEGORIA IN ('P', 'V')) 
;

ALTER TABLE MC_CATEGORIA 
    ADD 
    CHECK (ST_CATEGORIA IN ('A', 'I')) 
;

COMMENT ON COLUMN MC_CATEGORIA.CD_CATEGORIA IS 'id primario da categoria - PK: CategoriaID 

#Todas as datas devem ser armazenadas no formato dd/mm/yyyy hh24:mi:ss

Nome da categoria deve ser significativo e legível para relatórios e buscas

Esta tabela será referenciada por Produto e Vídeo' 
;

COMMENT ON COLUMN MC_CATEGORIA.TP_CATEGORIA IS 'Tipo da categoria: P=Produto, V=Vídeo - TipoCategoria deve ser P ou V' 
;

COMMENT ON COLUMN MC_CATEGORIA.SG_CATEGORIA IS 'Sigla única para a categoria (UK) - UK (Unique Key): Sigla' 
;

COMMENT ON COLUMN MC_CATEGORIA.NM_CATEGORIA IS 'Nome da categoria' 
;

COMMENT ON COLUMN MC_CATEGORIA.DS_CATEGORIA IS 'Breve descrição da categoria' 
;

COMMENT ON COLUMN MC_CATEGORIA.ST_CATEGORIA IS 'Status da categoria: A=Ativo, I=Inativo (CHECK constraint) - Status deve ser A ou I' 
;

COMMENT ON COLUMN MC_CATEGORIA.DT_FIM_CATEGORIA IS 'Data de termino de operação da categoria; se NULO, categoria está ativa' 
;

ALTER TABLE MC_CATEGORIA 
    ADD CONSTRAINT MC_CATEGORIA_PK PRIMARY KEY ( CD_CATEGORIA ) ;

CREATE TABLE MC_CIDADE 
    ( 
     CD_CIDADE NUMBER (8)  NOT NULL , 
     SG_ESTADO CHAR (2)  NOT NULL , 
     NM_CIDADE VARCHAR2 (60)  NOT NULL , 
     CD_IBGE   NUMBER (8) , 
     NR_DDD    NUMBER (3) 
    ) 
;

COMMENT ON COLUMN MC_CIDADE.CD_CIDADE IS 'Esta coluna irá receber o codigo da cidade e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_CIDADE.SG_ESTADO IS 'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_CIDADE.NM_CIDADE IS 'Esta coluna ira receber o nome da Cidade. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_CIDADE.CD_IBGE IS 'Esta coluna irá receber o código do IBGE que fornece informações para geração da NFe.' 
;

COMMENT ON COLUMN MC_CIDADE.NR_DDD IS 'Esta coluna irá receber o número do DDD da cidade para ser utilizado no contato telefônico. Seu conteudo é opcional.' 
;

ALTER TABLE MC_CIDADE 
    ADD CONSTRAINT PK_MC_CIDADE PRIMARY KEY ( CD_CIDADE ) ;

CREATE TABLE MC_CLIENTE 
    ( 
     NR_CLIENTE      NUMBER (10)  NOT NULL , 
     NM_CLIENTE      VARCHAR2 (160)  NOT NULL , 
     QT_ESTRELAS     NUMBER (1)  NOT NULL , 
     VL_MEDIO_COMPRA NUMBER (10,2)  NOT NULL , 
     ST_CLIENTE      CHAR (1)  NOT NULL , 
     DS_EMAIL        VARCHAR2 (100) , 
     NR_TELEFONE     VARCHAR2 (11) , 
     NM_LOGIN        VARCHAR2 (50)  NOT NULL , 
     DS_SENHA        VARCHAR2 (50)  NOT NULL , 
     NR_CPF          VARCHAR2 (14) , 
     NR_CNPJ         VARCHAR2 (19) , 
     DT_NASCIMENTO   DATE , 
     TP_CLIENTE      CHAR (2)  NOT NULL 
    ) 
;

ALTER TABLE MC_CLIENTE 
    ADD 
    CHECK (QT_ESTRELAS BETWEEN 1 AND 5) 
;

ALTER TABLE MC_CLIENTE 
    ADD 
    CHECK (ST_CLIENTE IN ('A', 'I')) 
;

ALTER TABLE MC_CLIENTE 
    ADD CONSTRAINT "TIPO EMAIL" 
    CHECK (DS_EMAIL LIKE '%@%') 
;

ALTER TABLE MC_CLIENTE 
    ADD CONSTRAINT "TIPO TELEFONE" 
    CHECK (REGEXP_LIKE(NR_TELEFONE, '^[0-9]{10,11}$')) 
;

ALTER TABLE MC_CLIENTE 
    ADD 
    CHECK (TP_CLIENTE IN ('PF', 'PJ')) 
;

COMMENT ON COLUMN MC_CLIENTE.NR_CLIENTE IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN MC_CLIENTE.NM_CLIENTE IS 'Essa coluna irá armazenar o nome do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_CLIENTE.QT_ESTRELAS IS 'Essa coluna irá armazenar a quantiade de estrelas do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e ser possível de estar entre 1 e 5 estrelas.' 
;

COMMENT ON COLUMN MC_CLIENTE.VL_MEDIO_COMPRA IS 'Essa coluna irá armazenar o valor  médio de gastos f eito pelo cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório e deve ser calculado diariamente.' 
;

COMMENT ON COLUMN MC_CLIENTE.ST_CLIENTE IS 'Essa coluna irá armazenar o stauts do cliente da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).' 
;

COMMENT ON COLUMN MC_CLIENTE.DS_EMAIL IS 'Essa coluna irá armazenar o email  do cliente da Melhorees Compras. No minimo é esperado um email contendo o caractere (@) em seu conteúdo.' 
;

COMMENT ON COLUMN MC_CLIENTE.NR_TELEFONE IS 'Essa coluna irá armazenar o número do cliente da Melhorees Compras. A mascara de armazenamento deve ser: (<nr_ddd>) 99999-9999 e  deve ser utilizada pré definida.' 
;

COMMENT ON COLUMN MC_CLIENTE.NM_LOGIN IS 'Essa coluna irá armazenar o login de cada cliente na plataforma ecommerce da Melhores Compras. Seu conteúdo deve ser obrigatório e  único para cada cliente.' 
;

COMMENT ON COLUMN MC_CLIENTE.DS_SENHA IS 'Essa coluna irá armazenar a senha de cada cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_CLIENTE.NR_CPF IS 'Este atributo irá receber o número do CPF já com a sua respectiva máscara. Exemplo: 09.08.554-09. Seu conteúdo é opcional pois o cliente por ser pessoa física ou juridica.' 
;

COMMENT ON COLUMN MC_CLIENTE.DT_NASCIMENTO IS 'Este atributo irá receber a data de nascimento ou data de fundação do cliente e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_CLIENTE.TP_CLIENTE IS 'Este atirbuto irá receber o tipo do cliente, que poderá ser PF (para pessao física) ou PJ (para pessoa jurídica).' 
;

ALTER TABLE MC_CLIENTE 
    ADD CONSTRAINT PK_MC_CLIENTE PRIMARY KEY ( NR_CLIENTE ) ;

CREATE TABLE MC_DEPTO 
    ( 
     CD_DEPTO NUMBER (3)  NOT NULL , 
     NM_DEPTO VARCHAR2 (100)  NOT NULL , 
     ST_DEPTO CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE MC_DEPTO 
    ADD 
    CHECK (ST_DEPTO IN ('A', 'I')) 
;

COMMENT ON COLUMN MC_DEPTO.CD_DEPTO IS 'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório.

ADICIONAR CHAVE ESTRANGEIRA EM: CD_GERENTE
CD_DEPTO' 
;

COMMENT ON COLUMN MC_DEPTO.NM_DEPTO IS 'Esta coluna irá receber o nome do  departamento  e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_DEPTO.ST_DEPTO IS 'Esta coluna irá receber o status do  departamento  e seu conteúdo é obrigatório. Os valores possíveis são: (A)tivo e (I)nativo.' 
;

ALTER TABLE MC_DEPTO 
    ADD CONSTRAINT PK_MC_DEPTO PRIMARY KEY ( CD_DEPTO ) ;

CREATE TABLE MC_END_CLI 
    ( 
     NR_CLIENTE         NUMBER (10)  NOT NULL , 
     CD_LOGRADOURO_CLI  NUMBER (10)  NOT NULL , 
     NR_END             NUMBER (8)  NOT NULL , 
     DS_COMPLEMENTO_END VARCHAR2 (80) , 
     DT_INICIO          DATE , 
     DT_TERMINO         DATE , 
     ST_END             CHAR (1)  NOT NULL 
    ) 
;

ALTER TABLE MC_END_CLI 
    ADD 
    CHECK (ST_END IN ('A', 'I')) 
;

COMMENT ON COLUMN MC_END_CLI.NR_CLIENTE IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN MC_END_CLI.CD_LOGRADOURO_CLI IS 'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_END_CLI.NR_END IS 'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.' 
;

COMMENT ON COLUMN MC_END_CLI.DS_COMPLEMENTO_END IS 'Esta coluna irá receber o complemento do endereço do cliente e seu conteúdo pode ser opcional.' 
;

COMMENT ON COLUMN MC_END_CLI.DT_INICIO IS 'Data de início do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_END_CLI.DT_TERMINO IS 'Data de término do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_END_CLI.ST_END IS 'Status do endereço. (A)itvo ou (I)nativo.' 
;

ALTER TABLE MC_END_CLI 
    ADD CONSTRAINT PK_MC_END_CLI PRIMARY KEY ( CD_LOGRADOURO_CLI, NR_CLIENTE ) ;

CREATE TABLE MC_END_FUNC 
    ( 
     CD_FUNCIONARIO     NUMBER (10)  NOT NULL , 
     CD_LOGRADOURO      NUMBER (10)  NOT NULL , 
     NR_END             NUMBER (8)  NOT NULL , 
     DS_COMPLEMENTO_END VARCHAR2 (80) , 
     DT_INICIO          DATE  NOT NULL , 
     DT_TERMINO         DATE , 
     ST_END             CHAR (1)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_END_FUNC.CD_FUNCIONARIO IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_END_FUNC.CD_LOGRADOURO IS 'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_END_FUNC.NR_END IS 'Número do Endereço do Cliente. O número da Rua/Localidade onde o cliente está associado.' 
;

COMMENT ON COLUMN MC_END_FUNC.DT_INICIO IS 'Data de início do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_END_FUNC.DT_TERMINO IS 'Data de término do endereço associado ao cliente.' 
;

COMMENT ON COLUMN MC_END_FUNC.ST_END IS 'Status do endereço. (A)itvo ou (I)nativo.' 
;

ALTER TABLE MC_END_FUNC 
    ADD CONSTRAINT PK_MC_END_FUNC PRIMARY KEY ( CD_LOGRADOURO, CD_FUNCIONARIO ) ;

CREATE TABLE MC_ESTADO 
    ( 
     SG_ESTADO CHAR (2)  NOT NULL , 
     NM_ESTADO VARCHAR2 (30)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_ESTADO.SG_ESTADO IS 'Esta coluna ira receber a siga do Estado. Esse conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_ESTADO.NM_ESTADO IS 'Esta coluna irá receber o nome do estado' 
;

ALTER TABLE MC_ESTADO 
    ADD CONSTRAINT PK_MC_ESTADO PRIMARY KEY ( SG_ESTADO ) ;

CREATE TABLE MC_FUNCIONARIO 
    ( 
     CD_FUNCIONARIO    NUMBER (10)  NOT NULL , 
     CD_DEPTO          NUMBER (3)  NOT NULL , 
     CD_GERENTE        NUMBER (10) , 
     NM_FUNCIONARIO    VARCHAR2 (160)  NOT NULL , 
     DT_NASCIMENTO     DATE  NOT NULL , 
     FL_SEXO_BIOLOGICO CHAR (1)  NOT NULL , 
     DS_GENERO         VARCHAR2 (100) , 
     DS_CARGO          VARCHAR2 (80) , 
     VL_SALARIO        NUMBER (10,2) , 
     DS_EMAIL          VARCHAR2 (80) , 
     ST_FUNC           CHAR (1) , 
     DT_CADASTRAMENTO  DATE , 
     DT_DESLIGAMENTO   DATE 
    ) 
;

ALTER TABLE MC_FUNCIONARIO 
    ADD 
    CHECK (FL_SEXO_BIOLOGICO IN ('F', 'H', 'M')) 
;

ALTER TABLE MC_FUNCIONARIO 
    ADD 
    CHECK (DS_EMAIL LIKE '%@%') 
;

ALTER TABLE MC_FUNCIONARIO 
    ADD 
    CHECK (ST_FUNC IN ('A', 'I')) 
;

COMMENT ON COLUMN MC_FUNCIONARIO.CD_FUNCIONARIO IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.CD_DEPTO IS 'Esta coluna irá receber o codigo do departamento  e seu conteúdo é obrigatório. 
TIPO = FK

ADICIONAR CHAVE ESTRANGEIRA EM: CD_GERENTE
CD_DEPTO' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.CD_GERENTE IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório. TIPO = FK

ADICIONAR CHAVE ESTRANGEIRA EM: CD_GERENTE
CD_DEPTO' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.NM_FUNCIONARIO IS 'Esta coluna irá receber o nome do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.DT_NASCIMENTO IS 'Esta coluna irá receber a data de nascimento  do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.FL_SEXO_BIOLOGICO IS 'Esta coluna irá receber o sexo biológico do funcionário e seu conteúdo é obrigatório.Os valores permitidos aqui seriam: (F)eminino; (M)asculino ou (Hermafrodita)' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.DS_GENERO IS 'Esta coluna irá receber o genero atribuido ao funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.DS_CARGO IS 'Esta coluna irá receber o cargo do funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.VL_SALARIO IS 'Esta coluna irá receber o valor do salário do funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.DS_EMAIL IS 'Esta coluna irá receber o email do funcionário e seu conteúdo é opcional.' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.ST_FUNC IS 'Essa coluna irá armazenar o stauts do funcionário da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.DT_CADASTRAMENTO IS 'Data de cadastramento do Funcionario' 
;

COMMENT ON COLUMN MC_FUNCIONARIO.DT_DESLIGAMENTO IS 'Data de desligamento  do Funcionario. Seu conteúdo é opcional.' 
;

ALTER TABLE MC_FUNCIONARIO 
    ADD CONSTRAINT PK_MC_FUNCIONARIO PRIMARY KEY ( CD_FUNCIONARIO ) ;

CREATE TABLE MC_LOGRADOURO 
    ( 
     CD_LOGRADOURO NUMBER (10)  NOT NULL , 
     CD_BAIRRO     NUMBER (8)  NOT NULL , 
     NM_LOGRADOURO VARCHAR2 (160)  NOT NULL , 
     NR_CEP        NUMBER (8)  NOT NULL 
    ) 
;

COMMENT ON COLUMN MC_LOGRADOURO.CD_LOGRADOURO IS 'Esta coluna irá receber o código do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_LOGRADOURO.CD_BAIRRO IS 'Esta coluna irá receber o codigo do bairro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_LOGRADOURO.NM_LOGRADOURO IS 'Esta coluna irá receber o nome do logradouro e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_LOGRADOURO.NR_CEP IS 'Esta coluna irá receber o numero do CEP do Logradouro e seu conteúdo é obrigatório.' 
;

ALTER TABLE MC_LOGRADOURO 
    ADD CONSTRAINT PK_MC_LOGRADOURO PRIMARY KEY ( CD_LOGRADOURO ) ;

CREATE TABLE MC_PRODUTO 
    ( 
     CD_PRODUTO            NUMBER (10)  NOT NULL , 
     NR_CD_BARRAS_PROD     VARCHAR2 (50) , 
     DS_PRODUTO            VARCHAR2 (80)  NOT NULL , 
     VL_PRECO_UNITARIO     NUMBER (8,2)  NOT NULL , 
     TP_EMBALAGEM          VARCHAR2 (15) , 
     ST_PRODUTO            CHAR (1) , 
     VL_PERC_LUCRO         NUMBER (8,2) , 
     DS_COMPLETA_PROD      VARCHAR2 (4000)  NOT NULL , 
     VL_TOTAL_IMPOSTO_PAGO NUMBER (10,2)  NOT NULL , 
     CD_CATEGORIA          NUMBER  NOT NULL 
    ) 
;

ALTER TABLE MC_PRODUTO 
    ADD 
    CHECK (VL_PRECO_UNITARIO > 0) 
;

ALTER TABLE MC_PRODUTO 
    ADD 
    CHECK (ST_PRODUTO IN ('A', 'I')) 
;

COMMENT ON COLUMN MC_PRODUTO.CD_PRODUTO IS 'Essa coluna irá armazenar a chave primária da tabela de produtos da Melhorees Compras. A cada produto cadastrado será acionada a Sequence  SQ_MC_PRODUTO que se encarregará de gerar o próximo número único do produto.' 
;

COMMENT ON COLUMN MC_PRODUTO.NR_CD_BARRAS_PROD IS 'Essa coluna irá armazenar o número do codigo de barras  do produto. Seu conteúdo deve ser opcional.' 
;

COMMENT ON COLUMN MC_PRODUTO.DS_PRODUTO IS 'Essa coluna irá armazenar a descrição principal do produto. Seu conteúdo deve ser  obrigatorio.' 
;

COMMENT ON COLUMN MC_PRODUTO.VL_PRECO_UNITARIO IS 'Essa coluna irá armazenar o valor unitário do produto. Seu conteúdo deve ser > 0 ' 
;

COMMENT ON COLUMN MC_PRODUTO.TP_EMBALAGEM IS 'Essa coluna irá armazenar o tipo de embalagem do produto. Seu conteúdo pode ser opcional.' 
;

COMMENT ON COLUMN MC_PRODUTO.ST_PRODUTO IS 'Essa coluna irá armazenar o stauts do produto da Melhorees Compras. Os valores permitidos aqui são: A(tivo) e I(nativo).' 
;

COMMENT ON COLUMN MC_PRODUTO.VL_PERC_LUCRO IS 'Essa coluna irá armazenar o percentual  do lucro médio para cada produto. Seu conteúdo deve ser opcional.' 
;

COMMENT ON COLUMN MC_PRODUTO.DS_COMPLETA_PROD IS 'Essa coluna irá armazenar a descrição completa do produto. Seu conteúdo deve ser  obrigatorio.' 
;

ALTER TABLE MC_PRODUTO 
    ADD CONSTRAINT PK_MC_PRODUTO PRIMARY KEY ( CD_PRODUTO ) ;

CREATE TABLE MC_SGV_SAC 
    ( 
     CD_FUNCIONARIO           NUMBER (10)  NOT NULL , 
     NR_SAC                   NUMBER  NOT NULL , 
     NR_CLIENTE               NUMBER (10)  NOT NULL , 
     DS_DETALHADA_SAC         CLOB  NOT NULL , 
     DT_ABERTURA_SAC          DATE  NOT NULL , 
     HR_ABERTURA_SAC          DATE  NOT NULL , 
     DT_ATENDIMENTO           DATE , 
     HR_ATENDIMENTO_SAC       DATE , 
     NR_TEMPO_TOTAL_SAC       DATE , 
     DS_DETALHADA_RETORNO_SAC CLOB , 
     TP_SAC                   CHAR (1)  NOT NULL , 
     ST_SAC                   CHAR (1)  NOT NULL , 
     NR_INDICE_SATISFACAO     NUMBER (2) , 
     CD_PRODUTO               NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT "TIPO DE CHAMADA SAC" 
    CHECK (TP_SAC IN ('D', 'E', 'S')) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT "STATUS SAC" 
    CHECK (ST_SAC IN ('C', 'E', 'F', 'X')) 
;

ALTER TABLE MC_SGV_SAC 
    ADD 
    CHECK (NR_INDICE_SATISFACAO BETWEEN 1 AND 10) 
;

COMMENT ON COLUMN MC_SGV_SAC.CD_FUNCIONARIO IS 'Esta coluna irá receber o codigo do funcionário e seu conteúdo é obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.NR_SAC IS 'Essa coluna irá armazenar a chave primária da tabela de SAC de vídeo  da Melhorees Compras. A cada SAC cadastrado pelo cliente será acionada a Sequence  SQ_MC_SGV_SAC que se encarregará de gerar o próximo número único do chamado SAC feito pelo Cliente.' 
;

COMMENT ON COLUMN MC_SGV_SAC.NR_CLIENTE IS 'Essa coluna irá armazenar o código único do cliente na plataforma ecommerce da Melhores Compras.Seu conteúdo deve ser obrigatório, único e preenhcido a  parrtir da chamada de sequence  SQ_MC_CLIENTE, a qual terá sempre o número disponivel para uso.' 
;

COMMENT ON COLUMN MC_SGV_SAC.DS_DETALHADA_SAC IS 'Essa coluna  irá  receber a descrição completa do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.DT_ABERTURA_SAC IS 'Essa coluna  irá  receber a data e horário do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.HR_ABERTURA_SAC IS 'Essa coluna  irá  receber a hora do SAC aberto pelo cliente. Seu conteudo deve ser obrigatório.' 
;

COMMENT ON COLUMN MC_SGV_SAC.DT_ATENDIMENTO IS 'Essa coluna  irá  receber a data e horário do atendmiento SAC feita pelo funcionário da Melhores Compras. Seu conteudo deve ser opcional..' 
;

COMMENT ON COLUMN MC_SGV_SAC.HR_ATENDIMENTO_SAC IS 'Essa coluna  irá  receber a hora do SAC do atendimento  feito  pelo funcionario da Melhores Compras. Seu conteudo deve ser opcional.' 
;

COMMENT ON COLUMN MC_SGV_SAC.NR_TEMPO_TOTAL_SAC IS 'Essa coluna  irá  receber o tempo total em horas  (HH24) computado desde a abertura até a conclusão dele. A unidade de medida é horas, ou seja, em quantas horas o chamado foi concluído desde a sua abertura.' 
;

COMMENT ON COLUMN MC_SGV_SAC.DS_DETALHADA_RETORNO_SAC IS 'Essa coluna  irá  receber a descrição detalhada do retorno feito pelo funcionário a partir da solicitação do cliente. Seu conteúdo deve ser opcional e preenchido pelo funcionário.' 
;

COMMENT ON COLUMN MC_SGV_SAC.TP_SAC IS 'Essa coluna  irá  receber o TIPO  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (S)ugestão; (D)úvida ou  (E)logio.' 
;

COMMENT ON COLUMN MC_SGV_SAC.ST_SAC IS 'Essa coluna  irá  receber o STATUS  do chamado SAC aberto pelo cliente.  Seu conteúdo deve ser  obrigatório e os possíveis valores são: (E)m Atendimento; (C)ancelado; (F)echado ou (X)Fechado com Insatisfação do cliente.' 
;

COMMENT ON COLUMN MC_SGV_SAC.NR_INDICE_SATISFACAO IS 'Essa coluna  irá  receber o índice de satisfação, , computado como um valor simples de 1 a 10, onde 1 refere-se ao cliente menos satisfeito e 10 o cliente mais satisfeito. Esse índice de satisfação é opcional e informado pelo cliente ao final do atendimento.' 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT PK_MC_SGV_SAC PRIMARY KEY ( NR_SAC, CD_FUNCIONARIO ) ;

CREATE TABLE MC_VIDEO 
    ( 
     ID_VIDEO           NUMBER  NOT NULL , 
     FK_PRODUTO_VIDEO   NUMBER  NOT NULL , 
     FK_CATEGORIA_VIDEO NUMBER  NOT NULL , 
     DS_VIDEO           VARCHAR2 (500)  NOT NULL , 
     CT_VIDEO           VARCHAR2 (4000)  NOT NULL , 
     ST_VIDEO           CHAR (1)  NOT NULL , 
     DT_INICIO_VIDEO    TIMESTAMP  NOT NULL , 
     DT_FIM_VIDEO       TIMESTAMP , 
     CD_PRODUTO         NUMBER (10)  NOT NULL 
    ) 
;

ALTER TABLE MC_VIDEO 
    ADD 
    CHECK (ST_VIDEO IN ('A', 'B', 'I')) 
;

COMMENT ON COLUMN MC_VIDEO.ID_VIDEO IS 'Código sequencial do vídeo (PK) 

Cada vídeo pertence a um produto (1:N)

Um produto pode ter vários vídeos

Só vídeos com status A podem ser exibidos

Datas devem ser armazenadas no formato dd/mm/yyyy hh24:mi:ss

' 
;

COMMENT ON COLUMN MC_VIDEO.FK_PRODUTO_VIDEO IS 'FK para Produto; vídeo deve pertencer a um produto ProdutoID → Produto(ProdutoID)' 
;

COMMENT ON COLUMN MC_VIDEO.FK_CATEGORIA_VIDEO IS 'FK para Categoria (tipo V) CategoriaID → Categoria(CategoriaID) (deve ser do tipo V)' 
;

COMMENT ON COLUMN MC_VIDEO.DS_VIDEO IS 'Breve descrição do vídeo' 
;

COMMENT ON COLUMN MC_VIDEO.CT_VIDEO IS 'Caminho ou URL do vídeo; conteúdo obrigatório' 
;

COMMENT ON COLUMN MC_VIDEO.ST_VIDEO IS 'Status do vídeo: A=Ativo, I=Inativo, B=Bloqueado (CHECK) Status deve ser A, I ou B' 
;

COMMENT ON COLUMN MC_VIDEO.DT_INICIO_VIDEO IS 'Data de início do ciclo de vida do vídeo' 
;

COMMENT ON COLUMN MC_VIDEO.DT_FIM_VIDEO IS 'Data de FIM do ciclo de vida do vídeo' 
;

ALTER TABLE MC_VIDEO 
    ADD CONSTRAINT MC_VIDEO_PK PRIMARY KEY ( ID_VIDEO, FK_PRODUTO_VIDEO, FK_CATEGORIA_VIDEO ) ;

CREATE TABLE MC_VISUALIZAÇÃO 
    ( 
     ID_VISUALIZAÇÃO         NUMBER  NOT NULL , 
     ID_VIDEO_VISUALIZACAO   NUMBER  NOT NULL , 
     ID_CLIENTE_VISUALIZACAO NUMBER (10) , 
     DT_VISUALIZACAO         TIMESTAMP  NOT NULL , 
     IP_VISUALIZACAO         VARCHAR2 (45) , 
     TP_USUARIO              CHAR (1)  NOT NULL , 
     ID_VIDEO                NUMBER  NOT NULL , 
     FK_PRODUTO_VIDEO        NUMBER  NOT NULL , 
     FK_CATEGORIA_VIDEO      NUMBER  NOT NULL 
    ) 
;

ALTER TABLE MC_VISUALIZAÇÃO 
    ADD 
    CHECK (TP_USUARIO IN ('A', 'C')) 
;

COMMENT ON COLUMN MC_VISUALIZAÇÃO.ID_VISUALIZAÇÃO IS 'Identificador da visualização (PK)

Visualização precisa de CHECK para impedir visualização se vídeo não for ativo → isso não dá para garantir só no modelo lógico, mas pode ir como regra de negócio no documento.' 
;

COMMENT ON COLUMN MC_VISUALIZAÇÃO.ID_VIDEO_VISUALIZACAO IS 'FK:

VideoID → Video(VideoID)' 
;

COMMENT ON COLUMN MC_VISUALIZAÇÃO.ID_CLIENTE_VISUALIZACAO IS 'ClienteID → Cliente(ClienteID) (nullable)' 
;

COMMENT ON COLUMN MC_VISUALIZAÇÃO.DT_VISUALIZACAO IS 'Momento exato da visualização' 
;

COMMENT ON COLUMN MC_VISUALIZAÇÃO.IP_VISUALIZACAO IS 'Captura IP do usuário (útil p/ anônimos)' 
;

COMMENT ON COLUMN MC_VISUALIZAÇÃO.TP_USUARIO IS 'C = Cliente cadastrado, A = Anônimo (CHECK)

Regra de consistência: se TipoUsuario = C, então ClienteID deve estar preenchido. Se TipoUsuario = A, ClienteID deve ser NULL. (Essa regra é difícil de forçar só com CHECK, geralmente se resolve com trigger, mas no modelo lógico é suficiente documentar).' 
;

ALTER TABLE MC_VISUALIZAÇÃO 
    ADD CONSTRAINT MC_VISUALIZAÇÃO_PK PRIMARY KEY ( ID_VISUALIZAÇÃO ) ;

ALTER TABLE MC_LOGRADOURO 
    ADD CONSTRAINT FK_MC_BAIRROLOGRADOURO FOREIGN KEY 
    ( 
     CD_BAIRRO
    ) 
    REFERENCES MC_BAIRRO 
    ( 
     CD_BAIRRO
    ) 
;

ALTER TABLE MC_PRODUTO 
    ADD CONSTRAINT FK_MC_CATEGORIA_PRODUTO FOREIGN KEY 
    ( 
     CD_CATEGORIA
    ) 
    REFERENCES MC_CATEGORIA 
    ( 
     CD_CATEGORIA
    ) 
;

ALTER TABLE MC_BAIRRO 
    ADD CONSTRAINT FK_MC_CIDADE_BAIRRO FOREIGN KEY 
    ( 
     CD_CIDADE
    ) 
    REFERENCES MC_CIDADE 
    ( 
     CD_CIDADE
    ) 
;

ALTER TABLE MC_END_CLI 
    ADD CONSTRAINT FK_MC_CLIENTE_END_CLI FOREIGN KEY 
    ( 
     NR_CLIENTE
    ) 
    REFERENCES MC_CLIENTE 
    ( 
     NR_CLIENTE
    ) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT FK_MC_CLIENTE_SGV_SAC FOREIGN KEY 
    ( 
     NR_CLIENTE
    ) 
    REFERENCES MC_CLIENTE 
    ( 
     NR_CLIENTE
    ) 
;

ALTER TABLE MC_FUNCIONARIO 
    ADD CONSTRAINT FK_MC_DEPTO_FUNCIONARIO FOREIGN KEY 
    ( 
     CD_DEPTO
    ) 
    REFERENCES MC_DEPTO 
    ( 
     CD_DEPTO
    ) 
;

ALTER TABLE MC_END_FUNC 
    ADD CONSTRAINT FK_MC_END_FUNC_LOGRADOURO FOREIGN KEY 
    ( 
     CD_LOGRADOURO
    ) 
    REFERENCES MC_LOGRADOURO 
    ( 
     CD_LOGRADOURO
    ) 
;

ALTER TABLE MC_CIDADE 
    ADD CONSTRAINT FK_MC_ESTADO_CIDADE FOREIGN KEY 
    ( 
     SG_ESTADO
    ) 
    REFERENCES MC_ESTADO 
    ( 
     SG_ESTADO
    ) 
;

ALTER TABLE MC_END_FUNC 
    ADD CONSTRAINT FK_MC_FUNC_END FOREIGN KEY 
    ( 
     CD_FUNCIONARIO
    ) 
    REFERENCES MC_FUNCIONARIO 
    ( 
     CD_FUNCIONARIO
    ) 
;

ALTER TABLE MC_FUNCIONARIO 
    ADD CONSTRAINT FK_MC_FUNC_SUPERIOR FOREIGN KEY 
    ( 
     CD_GERENTE
    ) 
    REFERENCES MC_FUNCIONARIO 
    ( 
     CD_FUNCIONARIO
    ) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT FK_MC_FUNCIONARIO_SGV_SAC FOREIGN KEY 
    ( 
     CD_FUNCIONARIO
    ) 
    REFERENCES MC_FUNCIONARIO 
    ( 
     CD_FUNCIONARIO
    ) 
;

ALTER TABLE MC_END_CLI 
    ADD CONSTRAINT FK_MC_LOGRAD_END_CLI FOREIGN KEY 
    ( 
     CD_LOGRADOURO_CLI
    ) 
    REFERENCES MC_LOGRADOURO 
    ( 
     CD_LOGRADOURO
    ) 
;

ALTER TABLE MC_VIDEO 
    ADD CONSTRAINT FK_MC_PRODUTO_MC_VIDEO FOREIGN KEY 
    ( 
     CD_PRODUTO
    ) 
    REFERENCES MC_PRODUTO 
    ( 
     CD_PRODUTO
    ) 
;

ALTER TABLE MC_SGV_SAC 
    ADD CONSTRAINT FK_MC_PRODUTO_SGV_SAC FOREIGN KEY 
    ( 
     CD_PRODUTO
    ) 
    REFERENCES MC_PRODUTO 
    ( 
     CD_PRODUTO
    ) 
;

ALTER TABLE MC_VISUALIZAÇÃO 
    ADD CONSTRAINT FK_MC_VIDEO_VISUALIZACAO FOREIGN KEY 
    ( 
     ID_VIDEO,
     FK_PRODUTO_VIDEO,
     FK_CATEGORIA_VIDEO
    ) 
    REFERENCES MC_VIDEO 
    ( 
     ID_VIDEO,
     FK_PRODUTO_VIDEO,
     FK_CATEGORIA_VIDEO
    ) 
;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             48
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
