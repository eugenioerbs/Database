-- CRIAÇÃO DAS TABELAS COM PK E FKS
CREATE TABLE municipio
(cd_municipio INTEGER PRIMARY KEY,
 nm_municipio VARCHAR(50),
 sg_uf        CHAR(2)
);
-- ou, e recomendado
CREATE TABLE municipio
(cd_municipio INTEGER,
 nm_municipio VARCHAR(50),
 sg_uf        CHAR(2),
 PRIMARY KEY (cd_municipio)
);
CREATE TABLE endereco
(cd_endereco    INTEGER,
 ds_logradouro  VARCHAR(50),
 ds_complemento VARCHAR(50),
 nm_bairro      VARCHAR(30),
 nr_cep			 CHAR(8),
 cd_municipio   INTEGER,
 PRIMARY KEY (cd_endereco),
 FOREIGN KEY (cd_municipio) REFERENCES municipio(cd_municipio)
);
-- ou
CREATE TABLE endereco
(cd_endereco    INTEGER PRIMARY KEY,
 ds_logradouro  VARCHAR(50),
 ds_complemento VARCHAR(50),
 nm_bairro      VARCHAR(30),
 nr_cep			 CHAR(8),
 cd_municipio   INTEGER REFERENCES municipio(cd_municipio)
-- ,
-- PRIMARY KEY (cd_endereco)
);

CREATE TABLE categoria
(cd_categoria INTEGER,
 nm_categoria VARCHAR(50),
 PRIMARY KEY(cd_categoria)
);
CREATE TABLE produto
(cd_produto   INTEGER,
 nm_produto   VARCHAR(50),
 ds_produto   VARCHAR(50),
 vl_custo     DECIMAL(8,2),
 vl_venda     DECIMAL(8,2),
 qt_estoque   INTEGER,
 cd_categoria INTEGER,
 PRIMARY KEY(cd_produto),
 FOREIGN KEY(cd_categoria) REFERENCES categoria(cd_categoria)
);
CREATE TABLE especie
(cd_especie   INTEGER,
 nm_especie   VARCHAR(50),
 PRIMARY KEY (cd_especie)
);
CREATE TABLE raca
(cd_raca    INTEGER,
 nm_raca    VARCHAR(50),
 cd_especie INTEGER,
 PRIMARY KEY (cd_raca),
 FOREIGN KEY (cd_especie) REFERENCES especie(cd_especie)
);
CREATE TABLE servico
(cd_servico  INTEGER,
 ds_servico  VARCHAR(50) NOT NULL,
 vl_servico  DECIMAL(8,2) NOT NULL,
 PRIMARY KEY (cd_servico)
);

CREATE TABLE cliente
(cd_cliente    INTEGER, 
 nm_cliente    VARCHAR(50),
 nr_telefone   VARCHAR(15),
 ds_email      VARCHAR(50),
 dt_nascimento DATE,
 cd_endereco   INTEGER,
 PRIMARY KEY(cd_cliente),
 FOREIGN KEY(cd_endereco) REFERENCES endereco(cd_endereco)
);

CREATE TABLE animal
(cd_animal     INTEGER,
 nm_animal     VARCHAR(50),
 ds_animal     VARCHAR(50),
 dt_nascimento DATE,
 tp_porte      CHAR(1),
 cd_raca       INTEGER,
 cd_cliente    INTEGER,
 PRIMARY KEY (cd_animal),
 FOREIGN KEY (cd_raca) REFERENCES raca(cd_raca),
 FOREIGN KEY (cd_cliente) REFERENCES cliente(cd_cliente)
);
CREATE TABLE nota_fiscal
(nr_nota_fiscal INTEGER,
 dt_emissao     DATE,
 vl_total       DECIMAL(8,2),
 cd_cliente     INTEGER,
 PRIMARY KEY (nr_nota_fiscal),
 foreign KEY (cd_cliente) REFERENCES cliente(cd_cliente)
);
CREATE TABLE item_nota_fiscal
(nr_nota_fiscal INTEGER,
 cd_produto     INTEGER,
 qt_produto     INTEGER,
 vl_produto     DECIMAL(8,2),
 PRIMARY KEY (nr_nota_fiscal, cd_produto),
 FOREIGN KEY(cd_produto) REFERENCES produto(cd_produto),
 FOREIGN KEY(nr_nota_fiscal) REFERENCES nota_fiscal(nr_nota_fiscal)
);

CREATE TABLE prestador_servico
(cd_prestador  INTEGER,
 nm_prestador  VARCHAR(50),
 nr_telefone   VARCHAR(15),
 ds_email      VARCHAR(50),
 cd_endereco   INTEGER,
 PRIMARY KEY (cd_prestador),
 FOREIGN KEY (cd_endereco) REFERENCES endereco(cd_endereco)
);
CREATE TABLE servico_prestador
(cd_servico INTEGER,
 cd_prestador INTEGER,
 PRIMARY KEY (cd_servico, cd_prestador),
 FOREIGN KEY (cd_servico) REFERENCES servico(cd_servico),
 FOREIGN KEY (cd_prestador) REFERENCES prestador_servico(cd_prestador)
);

CREATE TABLE agendamento
(nr_agendamento  INTEGER,
 dt_agendamento  DATE,
 hr_agendamento  TIME,
 cd_prestador    INTEGER,
 PRIMARY KEY (nr_agendamento),
 FOREIGN KEY (cd_prestador) REFERENCES prestador_servico(cd_prestador)
);

CREATE TABLE agendamento_servico
(nr_agendamento INTEGER,
 cd_servico     INTEGER,
 qt_servico     INTEGER,
 vl_servico     DECIMAL(6,2),
 PRIMARY KEY (nr_agendamento,cd_servico),
 FOREIGN KEY (nr_agendamento) REFERENCES agendamento(nr_agendamento),
 FOREIGN KEY (cd_servico) REFERENCES servico(cd_servico)
);

-- atenção!
-- recomendo fazer os drop tables na ordem inversa a que nós criamos,
-- ou seja, inicie eliminando as tabelas filhas
-- drop table agendamento_servico;
-- drop table agendamento;
-- drop table servico_prestador;
-- ...