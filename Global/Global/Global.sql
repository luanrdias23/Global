DROP TABLE tg_bairro CASCADE CONSTRAINTS;

DROP TABLE tg_cidade CASCADE CONSTRAINTS;

DROP TABLE tg_contato_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_endereco_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_estado CASCADE CONSTRAINTS;

DROP TABLE tg_logradouro CASCADE CONSTRAINTS;

DROP TABLE tg_noticia CASCADE CONSTRAINTS;

DROP TABLE tg_noticia_acessada CASCADE CONSTRAINTS;

DROP TABLE tg_telefone_usuario CASCADE CONSTRAINTS;

DROP TABLE tg_tipo_contato CASCADE CONSTRAINTS;

DROP TABLE tg_usuario CASCADE CONSTRAINTS;

CREATE TABLE tg_bairro (
    id_bairro   NUMBER(10) NOT NULL,
    id_cidade   NUMBER(10) NOT NULL,
    nm_bairro   VARCHAR2(30) NOT NULL,
    nm_zona     VARCHAR2(15) NOT NULL,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_bairro
    ADD CHECK ( nm_zona IN ( 'Zona Leste', 'Centro', 'Zona Norte', 'Zona Oeste', 'Zona Sul' ) );


ALTER TABLE tg_bairro ADD CONSTRAINT tg_bairro_pk PRIMARY KEY ( id_bairro );

CREATE TABLE tg_cidade (
    id_cidade   NUMBER(10) NOT NULL,
    id_estado   NUMBER(10) NOT NULL,
    sg_cidade   CHAR(2) NOT NULL,
    cd_ibge     NUMBER(8) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nm_cidade   VARCHAR2(30) NOT NULL,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_cidade ADD CONSTRAINT tg_estado_pk PRIMARY KEY ( id_cidade );

CREATE TABLE tg_contato_usuario (
    id_contato  NUMBER(10) NOT NULL,
    id_usuario  NUMBER(10) NOT NULL,
    id_tipo     NUMBER(10) NOT NULL,
    nm_contato  VARCHAR2(30) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3),
    nr_telefone NUMBER(10),
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_contato_usuario ADD CONSTRAINT tg_contato_paciente_pk PRIMARY KEY ( id_contato );

CREATE TABLE tg_endereco_usuario (
    id_endereco    NUMBER(10) NOT NULL,
    id_logradouro  NUMBER(10) NOT NULL,
    id_usuario     NUMBER(10) NOT NULL,
    nr_logradouro  NUMBER(7),
    ds_complemento VARCHAR2(30),
    ds_ponto_ref   VARCHAR2(30),
    dt_inicio      DATE NOT NULL,
    dt_fim         DATE,
    dt_cadastro    DATE NOT NULL
);

ALTER TABLE tg_endereco_usuario ADD CONSTRAINT tg_endereco_paciente_pk PRIMARY KEY ( id_endereco );

CREATE TABLE tg_estado (
    id_estado   NUMBER(10) NOT NULL,
    sg_estado   CHAR(2) NOT NULL,
    nm_estado   VARCHAR2(30) NOT NULL,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_estado ADD CONSTRAINT tg_estado_pkv1 PRIMARY KEY ( id_estado );

CREATE TABLE tg_logradouro (
    id_logradouro NUMBER(10) NOT NULL,
    id_bairro     NUMBER(10) NOT NULL,
    nm_logradouro VARCHAR2(30) NOT NULL,
    nr_cep        NUMBER(8) NOT NULL,
    dt_cadastro   DATE NOT NULL
);

ALTER TABLE tg_logradouro ADD CONSTRAINT tg_logradouro_pk PRIMARY KEY ( id_logradouro );

CREATE TABLE tg_noticia (
    id_noticia   NUMERIC (10) NOT NULL,
    nm_titulo    VARCHAR2(200) NOT NULL,
    nm_subtitulo VARCHAR2(200) NOT NULL,
    dt_noticia   DATE NOT NULL,
    ds_imagem    VARCHAR2(400) NOT NULL,
    ds_link      VARCHAR2(400) NOT NULL
);

ALTER TABLE tg_noticia ADD CONSTRAINT tg_noticia_pk PRIMARY KEY (id_noticia);


CREATE TABLE tg_noticia_acessada (
    id_noticia_acess NUMBER(10) NOT NULL,
    id_usuario       NUMBER(10) NOT NULL,
    id_noticia       NUMBER(10) NOT NULL,
    dt_acesso        DATE NOT NULL
);

ALTER TABLE tg_noticia_acessada ADD CONSTRAINT tg_noticia_acessada_pk PRIMARY KEY ( id_noticia_acess );

CREATE TABLE tg_telefone_usuario (
    id_telefone NUMBER(10) NOT NULL,
    id_usuario  NUMBER(10) NOT NULL,
    nr_ddi      NUMBER(3) NOT NULL,
    nr_ddd      NUMBER(3) NOT NULL,
    nr_telefone NUMBER(10) NOT NULL,
    tp_telefone VARCHAR2(20) NOT NULL,
    st_telefone CHAR(1) NOT NULL,
    dt_cadastro DATE NOT NULL
);
ALTER TABLE tg_telefone_usuario ADD CONSTRAINT tg_telefone_usuario_pk PRIMARY KEY ( id_telefone );

CREATE TABLE tg_tipo_contato (
    id_tipo     NUMBER(10) NOT NULL,
    nm_tipo     VARCHAR2(30) NOT NULL,
    dt_inico    DATE NOT NULL,
    dt_fim      DATE,
    dt_cadastro DATE NOT NULL
);

ALTER TABLE tg_tipo_contato ADD CONSTRAINT tg_tipo_contato_pk PRIMARY KEY ( id_tipo );

CREATE TABLE tg_usuario (
    id_usuario    NUMBER(10) NOT NULL,
    nm_usuario    VARCHAR2(30) NOT NULL,
    nr_cpf        NUMBER(12) NOT NULL,
    nm_rg         VARCHAR2(15),
    dt_nascimento DATE NOT NULL,
    fl_genero     CHAR(1) NOT NULL,
    dt_cadastro   DATE NOT NULL,
    nm_email      VARCHAR2(100) NOT NULL,
    nm_senha      VARCHAR2(100) NOT NULL
);

ALTER TABLE tg_usuario
    ADD CHECK ( fl_genero IN ( 'M', 'F' ) );

ALTER TABLE tg_usuario ADD CONSTRAINT tg_paciente_pk PRIMARY KEY ( id_usuario );

ALTER TABLE tg_usuario ADD CONSTRAINT uk UNIQUE ( nr_cpf );

ALTER TABLE tg_usuario ADD CONSTRAINT ukv2 UNIQUE ( nm_rg );

ALTER TABLE tg_logradouro
    ADD CONSTRAINT fk_bairro_logradouro FOREIGN KEY ( id_bairro )
        REFERENCES tg_bairro ( id_bairro );


ALTER TABLE tg_bairro
    ADD CONSTRAINT pk_cidade_bairro FOREIGN KEY (id_cidade)
        REFERENCES tg_cidade (id_cidade);



ALTER TABLE tg_cidade
    ADD CONSTRAINT pk_estado_cidade FOREIGN KEY ( id_estado )
        REFERENCES tg_estado ( id_estado );

ALTER TABLE tg_endereco_usuario
    ADD CONSTRAINT pk_logradouro_endereco FOREIGN KEY ( id_logradouro )
        REFERENCES tg_logradouro ( id_logradouro );

ALTER TABLE tg_noticia_acessada
    ADD CONSTRAINT pk_noticia_acessada FOREIGN KEY ( id_noticia )
        REFERENCES tg_noticia ( id_noticia );

ALTER TABLE tg_contato_usuario
    ADD CONSTRAINT pk_tipo_contato FOREIGN KEY ( id_tipo )
        REFERENCES tg_tipo_contato ( id_tipo );

ALTER TABLE tg_contato_usuario
    ADD CONSTRAINT pk_usuario_contato FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_endereco_usuario
    ADD CONSTRAINT pk_usuario_endereco FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_noticia_acessada
    ADD CONSTRAINT pk_usuario_noticia_acessada FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );

ALTER TABLE tg_telefone_usuario
    ADD CONSTRAINT pk_usuario_telefone FOREIGN KEY ( id_usuario )
        REFERENCES tg_usuario ( id_usuario );







 INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (1, 'AC', 'Acre', TO_DATE('2023-02-10', 'YYYY-MM-DD'));
    

    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (2, 'AL', 'Alagoas', TO_DATE('2021-10-24', 'YYYY-MM-DD'));
    

    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (3, 'AP', 'Amapá', TO_DATE('2023-09-13', 'YYYY-MM-DD'));
    

    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (4, 'AM', 'Amazonas', TO_DATE('2023-01-19', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (5, 'BA', 'Bahia', TO_DATE('2022-04-06', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (6, 'CE', 'Ceará', TO_DATE('2022-08-16', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (7, 'DF', 'Distrito Federal', TO_DATE('2023-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (8, 'ES', 'Espírito Santo', TO_DATE('2022-12-03', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (9, 'GO', 'Goiás', TO_DATE('2021-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (10, 'MA', 'Maranhão', TO_DATE('2021-06-01', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (11, 'MT', 'Mato Grosso', TO_DATE('2020-02-06', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (12, 'MS', 'Mato Grosso do Sul', TO_DATE('2022-11-24', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (13, 'MG', 'Minas Gerais', TO_DATE('2023-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (14, 'PA', 'Pará', TO_DATE('2023-04-24', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (15, 'PB', 'Paraíba', TO_DATE('2021-04-26', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (16, 'PR', 'Paraná', TO_DATE('2020-09-28', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (17, 'PE', 'Pernambuco', TO_DATE('2022-09-27', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (18, 'PI', 'Piauí', TO_DATE('2020-05-28', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (19, 'RJ', 'Rio de Janeiro', TO_DATE('2021-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (20, 'RN', 'Rio Grande do Norte', TO_DATE('2021-03-23', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (21, 'RS', 'Rio Grande do Sul', TO_DATE('2022-06-20', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (22, 'RO', 'Rondônia', TO_DATE('2023-07-29', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (23, 'RR', 'Roraima', TO_DATE('2022-04-26', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (24, 'SC', 'Santa Catarina', TO_DATE('2020-07-16', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (25, 'SP', 'São Paulo', TO_DATE('2022-03-22', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (26, 'SE', 'Sergipe', TO_DATE('2021-02-16', 'YYYY-MM-DD'));


    INSERT INTO tg_estado (id_estado, sg_estado, nm_estado, dt_cadastro)
    VALUES (27, 'TO', 'Tocantins', TO_DATE('2021-05-09', 'YYYY-MM-DD'));
    
    -- inserindo as cidades 
    
    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (1, 1, 'ZX', 6780953, 75, 'Rio Branco', TO_DATE('2020-04-06', 'YYYY-MM-DD'));
        

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (2, 1, 'EQ', 6794861, 65, 'Cruzeiro do Sul', TO_DATE('2021-02-11', 'YYYY-MM-DD'));
        

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (3, 1, 'TN', 2612102, 63, 'Sena Madureira', TO_DATE('2020-06-20', 'YYYY-MM-DD'));
        

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (4, 1, 'DY', 3357160, 54, 'Tarauacá', TO_DATE('2023-03-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (5, 1, 'CK', 1953265, 62, 'Feijó', TO_DATE('2022-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (6, 2, 'QI', 7355899, 97, 'Maceió', TO_DATE('2020-06-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (7, 2, 'DB', 3626375, 82, 'Arapiraca', TO_DATE('2021-06-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (8, 2, 'MW', 2601081, 28, 'Palmeira dos Índios', TO_DATE('2022-11-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (9, 2, 'VY', 4873067, 72, 'Rio Largo', TO_DATE('2023-07-22', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (10, 2, 'JK', 101502, 12, 'Penedo', TO_DATE('2022-02-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (11, 3, 'NI', 712368, 58, 'Macapá', TO_DATE('2020-01-28', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (12, 3, 'OX', 7143900, 33, 'Santana', TO_DATE('2023-11-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (13, 3, 'XZ', 1120723, 72, 'Laranjal do Jari', TO_DATE('2023-09-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (14, 3, 'PG', 7914450, 8, 'Oiapoque', TO_DATE('2020-09-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (15, 3, 'US', 8942646, 1, 'Mazagão', TO_DATE('2023-06-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (16, 4, 'YV', 7866291, 20, 'Manaus', TO_DATE('2022-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (17, 4, 'HU', 186736, 34, 'Parintins', TO_DATE('2021-03-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (18, 4, 'WR', 6231010, 99, 'Itacoatiara', TO_DATE('2020-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (19, 4, 'EU', 8351983, 59, 'Manacapuru', TO_DATE('2020-10-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (20, 4, 'BX', 2961427, 50, 'Coari', TO_DATE('2022-07-21', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (21, 5, 'AP', 2016722, 48, 'Salvador', TO_DATE('2023-05-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (22, 5, 'DB', 2010661, 74, 'Feira de Santana', TO_DATE('2022-12-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (23, 5, 'MR', 6850056, 47, 'Vitória da Conquista', TO_DATE('2020-09-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (24, 5, 'CO', 6589073, 95, 'Camaçari', TO_DATE('2023-06-20', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (25, 5, 'XM', 1562185, 73, 'Itabuna', TO_DATE('2023-08-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (26, 6, 'HG', 9290815, 77, 'Fortaleza', TO_DATE('2021-08-16', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (27, 6, 'YF', 2747233, 79, 'Caucaia', TO_DATE('2022-08-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (28, 6, 'MM', 4066245, 91, 'Juazeiro do Norte', TO_DATE('2020-11-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (29, 6, 'GR', 4375917, 38, 'Maracanaú', TO_DATE('2020-12-11', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (30, 6, 'PG', 4162398, 54, 'Sobral', TO_DATE('2023-07-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (31, 7, 'TW', 8814906, 58, 'Brasília', TO_DATE('2023-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (32, 8, 'LG', 175927, 27, 'Vitória', TO_DATE('2021-04-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (33, 8, 'QD', 3641393, 67, 'Vila Velha', TO_DATE('2021-04-07', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (34, 8, 'JY', 3154024, 3, 'Cariacica', TO_DATE('2020-09-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (35, 8, 'IF', 2495092, 99, 'Serra', TO_DATE('2020-05-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (36, 8, 'TN', 3772941, 15, 'Linhares', TO_DATE('2022-06-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (37, 9, 'FH', 6674330, 87, 'Goiânia', TO_DATE('2021-07-07', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (38, 9, 'VP', 9277077, 43, 'Aparecida de Goiânia', TO_DATE('2021-05-24', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (39, 9, 'ND', 2771019, 69, 'Anápolis', TO_DATE('2021-07-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (40, 9, 'XP', 2225317, 78, 'Rio Verde', TO_DATE('2020-02-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (41, 9, 'AP', 9206487, 35, 'Luziânia', TO_DATE('2023-07-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (42, 10, 'IK', 398255, 95, 'São Luís', TO_DATE('2020-05-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (43, 10, 'VZ', 2868447, 28, 'Imperatriz', TO_DATE('2021-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (44, 10, 'DE', 1725763, 34, 'Timon', TO_DATE('2022-10-28', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (45, 10, 'HQ', 7043706, 41, 'Caxias', TO_DATE('2022-05-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (46, 10, 'LG', 9864845, 83, 'Codó', TO_DATE('2020-05-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (47, 11, 'HP', 7836266, 20, 'Cuiabá', TO_DATE('2020-02-24', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (48, 11, 'VE', 163324, 35, 'Várzea Grande', TO_DATE('2020-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (49, 11, 'DH', 5608284, 0, 'Rondonópolis', TO_DATE('2023-06-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (50, 11, 'MP', 6672998, 72, 'Cáceres', TO_DATE('2021-03-15', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (51, 11, 'FX', 2616206, 80, 'Sinop', TO_DATE('2023-02-16', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (52, 12, 'JA', 4430416, 68, 'Campo Grande', TO_DATE('2022-08-21', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (53, 12, 'YU', 3259445, 87, 'Dourados', TO_DATE('2021-01-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (54, 12, 'CD', 5892525, 59, 'Três Lagoas', TO_DATE('2021-01-11', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (55, 12, 'ZU', 5493902, 30, 'Corumbá', TO_DATE('2021-11-15', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (56, 12, 'XQ', 1429963, 15, 'Ponta Porã', TO_DATE('2021-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (57, 13, 'IP', 1147155, 10, 'Belo Horizonte', TO_DATE('2023-08-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (58, 13, 'HP', 9650398, 64, 'Contagem', TO_DATE('2023-10-19', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (59, 13, 'UQ', 2206128, 13, 'Uberlândia', TO_DATE('2021-02-22', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (60, 13, 'YR', 7098544, 97, 'Juiz de Fora', TO_DATE('2022-02-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (61, 13, 'WN', 6119444, 69, 'Betim', TO_DATE('2021-11-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (62, 14, 'FC', 7329176, 99, 'Belém', TO_DATE('2022-05-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (63, 14, 'TS', 3393601, 41, 'Ananindeua', TO_DATE('2020-11-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (64, 14, 'AB', 4151320, 99, 'Santarém', TO_DATE('2021-05-12', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (65, 14, 'PR', 3505562, 98, 'Marabá', TO_DATE('2021-08-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (66, 14, 'DI', 2672652, 42, 'Castanhal', TO_DATE('2023-06-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (67, 15, 'KD', 3446820, 19, 'João Pessoa', TO_DATE('2021-02-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (68, 15, 'KA', 8592128, 66, 'Campina Grande', TO_DATE('2020-11-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (69, 15, 'QG', 2840902, 89, 'Santa Rita', TO_DATE('2023-05-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (70, 15, 'ED', 4273564, 66, 'Patos', TO_DATE('2022-06-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (71, 15, 'EU', 5371220, 20, 'Bayeux', TO_DATE('2020-09-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (72, 16, 'WM', 7930141, 48, 'Curitiba', TO_DATE('2023-01-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (73, 16, 'XO', 6216739, 87, 'Londrina', TO_DATE('2022-07-30', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (74, 16, 'RV', 5127267, 12, 'Maringá', TO_DATE('2020-03-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (75, 16, 'BH', 9737732, 99, 'Ponta Grossa', TO_DATE('2023-08-07', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (76, 16, 'GN', 8414440, 25, 'Cascavel', TO_DATE('2023-04-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (77, 17, 'XQ', 3324792, 86, 'Recife', TO_DATE('2020-09-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (78, 17, 'SP', 8301440, 69, 'Jaboatão dos Guararapes', TO_DATE('2022-05-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (79, 17, 'SC', 1912565, 76, 'Olinda', TO_DATE('2021-05-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (80, 17, 'FI', 1287263, 52, 'Caruaru', TO_DATE('2023-05-31', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (81, 17, 'SO', 8685120, 51, 'Petrolina', TO_DATE('2023-02-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (82, 18, 'IS', 5915457, 59, 'Teresina', TO_DATE('2021-11-17', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (83, 18, 'WS', 1804042, 0, 'Parnaíba', TO_DATE('2023-11-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (84, 18, 'WM', 220728, 55, 'Picos', TO_DATE('2023-03-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (85, 18, 'LX', 7411860, 54, 'Floriano', TO_DATE('2022-01-24', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (86, 18, 'FM', 8709154, 38, 'Campo Maior', TO_DATE('2021-09-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (87, 19, 'FM', 1786026, 93, 'Rio de Janeiro', TO_DATE('2021-05-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (88, 19, 'FA', 2714211, 85, 'São Gonçalo', TO_DATE('2020-12-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (89, 19, 'LI', 859689, 81, 'Duque de Caxias', TO_DATE('2021-07-08', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (90, 19, 'HD', 3322518, 94, 'Nova Iguaçu', TO_DATE('2020-08-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (91, 19, 'CY', 6740051, 33, 'Niterói', TO_DATE('2021-09-22', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (92, 20, 'MZ', 3798087, 35, 'Natal', TO_DATE('2022-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (93, 20, 'NZ', 8408920, 6, 'Mossoró', TO_DATE('2022-12-31', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (94, 20, 'TU', 8208044, 69, 'Parnamirim', TO_DATE('2020-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (95, 20, 'QK', 1216174, 74, 'São Gonçalo do Amarante', TO_DATE('2022-12-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (96, 20, 'NM', 2889957, 68, 'Ceará-Mirim', TO_DATE('2022-05-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (97, 21, 'VY', 9036172, 47, 'Porto Alegre', TO_DATE('2023-10-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (98, 21, 'YL', 2323927, 21, 'Caxias do Sul', TO_DATE('2020-04-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (99, 21, 'CM', 4864424, 47, 'Pelotas', TO_DATE('2021-09-29', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (100, 21, 'XB', 7201560, 9, 'Canoas', TO_DATE('2022-11-23', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (101, 21, 'LZ', 366223, 65, 'Santa Maria', TO_DATE('2020-02-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (102, 22, 'ST', 7009533, 30, 'Porto Velho', TO_DATE('2021-05-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (103, 22, 'QK', 9588827, 76, 'Ji-Paraná', TO_DATE('2021-10-13', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (104, 22, 'JI', 9387255, 81, 'Ariquemes', TO_DATE('2020-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (105, 22, 'UX', 7152135, 16, 'Vilhena', TO_DATE('2020-04-19', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (106, 22, 'CU', 8574727, 77, 'Cacoal', TO_DATE('2021-08-25', 'YYYY-MM-DD'));

    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (107, 23, 'DM', 5936735, 19, 'Boa Vista', TO_DATE('2022-10-10', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (108, 23, 'BN', 1127236, 16, 'Rorainópolis', TO_DATE('2020-03-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (109, 23, 'QR', 1397771, 59, 'Mucajaí', TO_DATE('2021-10-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (110, 23, 'PW', 183478, 97, 'Alto Alegre', TO_DATE('2020-10-01', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (111, 23, 'UR', 936391, 24, 'Pacaraima', TO_DATE('2021-06-21', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (112, 24, 'IC', 2029822, 2, 'Florianópolis', TO_DATE('2021-12-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (113, 24, 'HB', 9789733, 43, 'Joinville', TO_DATE('2020-12-06', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (114, 24, 'SN', 1428515, 92, 'Blumenau', TO_DATE('2020-09-05', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (115, 24, 'LG', 2023375, 55, 'São José', TO_DATE('2023-10-26', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (116, 24, 'VW', 8232118, 87, 'Criciúma', TO_DATE('2021-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (117, 25, 'LJ', 514126, 37, 'São Paulo', TO_DATE('2021-03-04', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (118, 25, 'HE', 1635397, 46, 'Guarulhos', TO_DATE('2020-03-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (119, 25, 'GU', 5788873, 92, 'Campinas', TO_DATE('2022-11-13', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (120, 25, 'SG', 6644409, 13, 'São Bernardo do Campo', TO_DATE('2020-04-09', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (121, 25, 'KG', 5963448, 18, 'Santo André', TO_DATE('2020-12-14', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (122, 26, 'UJ', 116393, 26, 'Aracaju', TO_DATE('2020-09-06', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (123, 26, 'IL', 3740129, 65, 'Nossa Senhora do Socorro', TO_DATE('2021-04-27', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (124, 26, 'ET', 4059505, 69, 'Lagarto', TO_DATE('2022-12-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (125, 26, 'QS', 6156977, 52, 'Itabaiana', TO_DATE('2020-07-11', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (126, 26, 'CX', 9697977, 19, 'Estância', TO_DATE('2020-08-25', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (127, 27, 'DA', 397691, 6, 'Palmas', TO_DATE('2023-04-26', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (128, 27, 'HG', 729687, 58, 'Araguaína', TO_DATE('2023-05-03', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (129, 27, 'BG', 9081271, 21, 'Gurupi', TO_DATE('2023-09-16', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (130, 27, 'GB', 5607674, 14, 'Porto Nacional', TO_DATE('2021-05-18', 'YYYY-MM-DD'));


    INSERT INTO tg_cidade (id_cidade, id_estado, sg_cidade, cd_ibge, nr_ddd, nm_cidade, dt_cadastro)
    VALUES (131, 27, 'VL', 3718787, 32, 'Paraíso do Tocantins', TO_DATE('2020-11-05', 'YYYY-MM-DD'));

    -- inserindo na tabela bairro


    INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
    VALUES (1, 1, 'Ferreira dos Dourados', 'Zona Leste', TO_DATE('2020-07-12', 'YYYY-MM-DD'));
        

    INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
    VALUES (2, 1, 'Pires', 'Centro', TO_DATE('2021-12-10', 'YYYY-MM-DD'));
        

    INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
    VALUES (3, 1, 'da Costa do Sul', 'Zona Norte', TO_DATE('2020-04-05', 'YYYY-MM-DD'));
        

        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (4, 1, 'Caldeira', 'Zona Oeste', TO_DATE('2021-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (5, 1, 'da Conceição', 'Zona Sul', TO_DATE('2021-02-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (6, 2, 'Aragão de Cunha', 'Zona Leste', TO_DATE('2020-11-25', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (7, 2, 'Jesus do Sul', 'Centro', TO_DATE('2022-08-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (8, 2, 'Caldeira', 'Zona Norte', TO_DATE('2023-03-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (9, 2, 'Sales', 'Zona Oeste', TO_DATE('2020-04-18', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (10, 2, 'Rezende de Correia', 'Zona Sul', TO_DATE('2020-04-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (11, 3, 'Martins de Rezende', 'Zona Leste', TO_DATE('2023-07-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (12, 3, 'Cardoso Paulista', 'Centro', TO_DATE('2021-04-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (13, 3, 'Costela', 'Zona Norte', TO_DATE('2023-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (14, 3, 'da Luz', 'Zona Oeste', TO_DATE('2020-12-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (15, 3, 'Teixeira de Goiás', 'Zona Sul', TO_DATE('2023-07-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (16, 4, 'Farias de Cavalcanti', 'Zona Leste', TO_DATE('2022-02-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (17, 4, 'Gomes', 'Centro', TO_DATE('2023-02-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (18, 4, 'Santos da Serra', 'Zona Norte', TO_DATE('2020-07-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (19, 4, 'Vieira de Minas', 'Zona Oeste', TO_DATE('2021-12-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (20, 4, 'Duarte', 'Zona Sul', TO_DATE('2022-01-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (21, 5, 'da Luz das Flores', 'Zona Leste', TO_DATE('2023-11-09', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (22, 5, 'Silva', 'Centro', TO_DATE('2021-07-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (23, 5, 'Cardoso', 'Zona Norte', TO_DATE('2020-02-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (24, 5, 'Ribeiro', 'Zona Oeste', TO_DATE('2023-09-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (25, 5, 'Duarte', 'Zona Sul', TO_DATE('2021-05-25', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (26, 6, 'Martins', 'Zona Leste', TO_DATE('2022-03-02', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (27, 6, 'Rezende', 'Centro', TO_DATE('2021-02-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (28, 6, 'da Rocha Alegre', 'Zona Norte', TO_DATE('2021-09-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (29, 6, 'Monteiro', 'Zona Oeste', TO_DATE('2020-05-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (30, 6, 'Porto', 'Zona Sul', TO_DATE('2021-08-06', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (31, 7, 'Cunha', 'Zona Leste', TO_DATE('2020-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (32, 7, 'Cardoso da Prata', 'Centro', TO_DATE('2020-05-08', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (33, 7, 'da Paz de Martins', 'Zona Norte', TO_DATE('2020-01-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (34, 7, 'Nascimento', 'Zona Oeste', TO_DATE('2023-01-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (35, 7, 'Moreira Verde', 'Zona Sul', TO_DATE('2021-03-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (36, 8, 'Rodrigues', 'Zona Leste', TO_DATE('2022-06-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (37, 8, 'Peixoto do Oeste', 'Centro', TO_DATE('2021-06-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (38, 8, 'Moraes do Sul', 'Zona Norte', TO_DATE('2021-11-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (39, 8, 'Viana', 'Zona Oeste', TO_DATE('2022-11-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (40, 8, 'Lima', 'Zona Sul', TO_DATE('2021-01-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (41, 9, 'Silveira do Amparo', 'Zona Leste', TO_DATE('2022-01-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (42, 9, 'da Cunha', 'Centro', TO_DATE('2023-08-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (43, 9, 'da Paz', 'Zona Norte', TO_DATE('2023-09-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (44, 9, 'Peixoto', 'Zona Oeste', TO_DATE('2022-02-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (45, 9, 'Ramos', 'Zona Sul', TO_DATE('2023-04-21', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (46, 10, 'Rocha', 'Zona Leste', TO_DATE('2020-07-09', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (47, 10, 'Correia', 'Centro', TO_DATE('2021-09-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (48, 10, 'Araújo', 'Zona Norte', TO_DATE('2022-03-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (49, 10, 'Gomes', 'Zona Oeste', TO_DATE('2023-06-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (50, 10, 'da Luz Alegre', 'Zona Sul', TO_DATE('2023-01-06', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (51, 11, 'Rocha Alegre', 'Zona Leste', TO_DATE('2021-12-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (52, 11, 'Lopes de Costa', 'Centro', TO_DATE('2023-01-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (53, 11, 'Monteiro', 'Zona Norte', TO_DATE('2022-07-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (54, 11, 'Ribeiro', 'Zona Oeste', TO_DATE('2022-02-21', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (55, 11, 'da Cunha do Campo', 'Zona Sul', TO_DATE('2023-05-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (56, 12, 'Alves', 'Zona Leste', TO_DATE('2023-03-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (57, 12, 'da Rosa', 'Centro', TO_DATE('2020-02-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (58, 12, 'Pinto de Novaes', 'Zona Norte', TO_DATE('2020-04-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (59, 12, 'Castro do Norte', 'Zona Oeste', TO_DATE('2023-02-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (60, 12, 'Cardoso', 'Zona Sul', TO_DATE('2022-04-02', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (61, 13, 'Caldeira de Azevedo', 'Zona Leste', TO_DATE('2022-11-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (62, 13, 'Barros de Silveira', 'Centro', TO_DATE('2022-09-29', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (63, 13, 'Lima', 'Zona Norte', TO_DATE('2022-06-13', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (64, 13, 'da Mota da Praia', 'Zona Oeste', TO_DATE('2023-04-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (65, 13, 'da Rocha', 'Zona Sul', TO_DATE('2021-03-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (66, 14, 'Melo de Goiás', 'Zona Leste', TO_DATE('2022-12-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (67, 14, 'Nascimento Paulista', 'Centro', TO_DATE('2022-01-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (68, 14, 'Novaes dos Dourados', 'Zona Norte', TO_DATE('2023-02-24', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (69, 14, 'Farias', 'Zona Oeste', TO_DATE('2021-12-16', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (70, 14, 'Correia', 'Zona Sul', TO_DATE('2023-03-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (71, 15, 'da Mota', 'Zona Leste', TO_DATE('2022-06-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (72, 15, 'da Rocha de Alves', 'Centro', TO_DATE('2023-08-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (73, 15, 'da Cruz de Goiás', 'Zona Norte', TO_DATE('2023-08-08', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (74, 15, 'Vieira', 'Zona Oeste', TO_DATE('2023-11-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (75, 15, 'Pinto de Fernandes', 'Zona Sul', TO_DATE('2022-12-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (76, 16, 'Nogueira dos Dourados', 'Zona Leste', TO_DATE('2023-07-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (77, 16, 'Caldeira do Campo', 'Centro', TO_DATE('2021-12-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (78, 16, 'Ribeiro da Praia', 'Zona Norte', TO_DATE('2023-01-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (79, 16, 'da Costa', 'Zona Oeste', TO_DATE('2023-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (80, 16, 'Carvalho', 'Zona Sul', TO_DATE('2023-11-10', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (81, 17, 'Aragão de Cavalcanti', 'Zona Leste', TO_DATE('2021-01-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (82, 17, 'Pereira da Serra', 'Centro', TO_DATE('2021-07-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (83, 17, 'Porto', 'Zona Norte', TO_DATE('2022-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (84, 17, 'da Costa', 'Zona Oeste', TO_DATE('2022-10-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (85, 17, 'Caldeira', 'Zona Sul', TO_DATE('2023-02-25', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (86, 18, 'da Paz de Goiás', 'Zona Leste', TO_DATE('2022-06-18', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (87, 18, 'da Luz de Rocha', 'Centro', TO_DATE('2022-02-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (88, 18, 'Castro', 'Zona Norte', TO_DATE('2022-04-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (89, 18, 'Novaes', 'Zona Oeste', TO_DATE('2023-02-03', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (90, 18, 'da Luz de da Paz', 'Zona Sul', TO_DATE('2022-09-21', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (91, 19, 'Gonçalves', 'Zona Leste', TO_DATE('2023-11-13', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (92, 19, 'Aragão Grande', 'Centro', TO_DATE('2020-01-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (93, 19, 'Cunha da Serra', 'Zona Norte', TO_DATE('2023-06-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (94, 19, 'Fernandes Paulista', 'Zona Oeste', TO_DATE('2021-08-11', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (95, 19, 'Carvalho da Serra', 'Zona Sul', TO_DATE('2020-12-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (96, 20, 'Alves de Nogueira', 'Zona Leste', TO_DATE('2022-11-27', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (97, 20, 'da Rosa', 'Centro', TO_DATE('2022-07-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (98, 20, 'Viana da Serra', 'Zona Norte', TO_DATE('2021-08-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (99, 20, 'da Mota', 'Zona Oeste', TO_DATE('2022-09-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (100, 20, 'Porto', 'Zona Sul', TO_DATE('2022-08-03', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (101, 21, 'Nogueira Paulista', 'Zona Leste', TO_DATE('2021-04-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (102, 21, 'Rodrigues', 'Centro', TO_DATE('2020-01-01', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (103, 21, 'Pinto', 'Zona Norte', TO_DATE('2023-04-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (104, 21, 'Jesus Paulista', 'Zona Oeste', TO_DATE('2020-01-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (105, 21, 'Pires', 'Zona Sul', TO_DATE('2022-09-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (106, 22, 'Cardoso', 'Zona Leste', TO_DATE('2023-11-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (107, 22, 'Melo', 'Centro', TO_DATE('2023-10-18', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (108, 22, 'Porto', 'Zona Norte', TO_DATE('2022-10-14', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (109, 22, 'Moreira de Minas', 'Zona Oeste', TO_DATE('2022-05-23', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (110, 22, 'Pires do Galho', 'Zona Sul', TO_DATE('2023-10-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (111, 23, 'da Conceição', 'Zona Leste', TO_DATE('2020-08-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (112, 23, 'da Luz Verde', 'Centro', TO_DATE('2020-01-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (113, 23, 'Nogueira', 'Zona Norte', TO_DATE('2020-05-29', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (114, 23, 'Moraes da Prata', 'Zona Oeste', TO_DATE('2020-08-31', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (115, 23, 'da Mota', 'Zona Sul', TO_DATE('2020-08-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (116, 24, 'Lima', 'Zona Leste', TO_DATE('2023-04-22', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (117, 24, 'Barbosa de Aragão', 'Centro', TO_DATE('2021-06-04', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (118, 24, 'Cardoso', 'Zona Norte', TO_DATE('2020-05-26', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (119, 24, 'Moraes', 'Zona Oeste', TO_DATE('2023-01-02', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (120, 24, 'Oliveira', 'Zona Sul', TO_DATE('2021-12-28', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (121, 25, 'da Mata', 'Zona Leste', TO_DATE('2021-11-30', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (122, 25, 'Almeida', 'Centro', TO_DATE('2020-04-05', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (123, 25, 'Aragão', 'Zona Norte', TO_DATE('2023-05-29', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (124, 25, 'da Costa', 'Zona Oeste', TO_DATE('2023-08-20', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (125, 25, 'Ramos de Rezende', 'Zona Sul', TO_DATE('2020-03-16', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (126, 26, 'Rezende Alegre', 'Zona Leste', TO_DATE('2020-03-07', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (127, 26, 'da Mota Paulista', 'Centro', TO_DATE('2021-10-19', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (128, 26, 'Ribeiro Alegre', 'Zona Norte', TO_DATE('2021-07-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (129, 26, 'Pereira', 'Zona Oeste', TO_DATE('2023-08-13', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (130, 26, 'Almeida', 'Zona Sul', TO_DATE('2021-08-12', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (131, 27, 'da Conceição', 'Zona Leste', TO_DATE('2023-03-10', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (132, 27, 'Gonçalves', 'Centro', TO_DATE('2022-10-15', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (133, 27, 'Viana', 'Zona Norte', TO_DATE('2020-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (134, 27, 'Lima de da Cruz', 'Zona Oeste', TO_DATE('2020-01-08', 'YYYY-MM-DD'));


        INSERT INTO tg_bairro (id_bairro, id_cidade, nm_bairro, nm_zona, dt_cadastro)
        VALUES (135, 27, 'Moraes da Praia', 'Zona Sul', TO_DATE('2023-02-01', 'YYYY-MM-DD'));
        
        -- inserindo os Logradouros 


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (1, 1, 'Jardim da Cruz', 53769514, TO_DATE('2023-04-12', 'YYYY-MM-DD'));
        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (2, 1, 'Jardim de da Paz', 43818474, TO_DATE('2020-08-26', 'YYYY-MM-DD'));
        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (3, 2, 'Setor de Fernandes', 10940608, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
        

        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (4, 2, 'Recanto Valentina Ramos', 43150006, TO_DATE('2022-08-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (5, 2, 'Praia da Conceição', 51453929, TO_DATE('2021-10-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (6, 2, 'Vereda Melo', 19348888, TO_DATE('2022-04-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (7, 2, 'Trecho Farias', 70813646, TO_DATE('2023-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (8, 3, 'Quadra de Santos', 57644070, TO_DATE('2020-11-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (9, 3, 'Residencial Almeida', 39773173, TO_DATE('2021-06-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (10, 3, 'Via Laís Pinto', 55811094, TO_DATE('2020-06-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (11, 4, 'Praça João Miguel Castro', 41418134, TO_DATE('2021-08-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (12, 4, 'Travessa de da Rosa', 27592174, TO_DATE('2021-11-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (13, 4, 'Loteamento Nascimento', 57293811, TO_DATE('2023-07-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (14, 4, 'Setor Gomes', 33655788, TO_DATE('2021-05-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (15, 5, 'Setor de Castro', 99453939, TO_DATE('2022-04-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (16, 5, 'Lagoa Gomes', 87618925, TO_DATE('2021-01-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (17, 5, 'Jardim de Silveira', 83616453, TO_DATE('2021-08-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (18, 5, 'Conjunto de Araújo', 52212667, TO_DATE('2020-04-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (19, 5, 'Aeroporto Nunes', 36273436, TO_DATE('2021-09-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (20, 6, 'Sítio Agatha Costa', 57951974, TO_DATE('2022-05-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (21, 6, 'Morro de Viana', 10137295, TO_DATE('2022-01-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (22, 6, 'Praça Joana Gonçalves', 78773257, TO_DATE('2020-07-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (23, 6, 'Trecho Souza', 12688051, TO_DATE('2021-07-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (24, 6, 'Estação Cardoso', 65867623, TO_DATE('2021-01-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (25, 7, 'Condomínio de Gomes', 17803742, TO_DATE('2021-10-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (26, 7, 'Parque de Nunes', 74283192, TO_DATE('2023-09-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (27, 7, 'Feira Barros', 28767258, TO_DATE('2022-04-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (28, 8, 'Trecho Gustavo Henrique', 46221548, TO_DATE('2022-08-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (29, 8, 'Fazenda Evelyn Nunes', 95016912, TO_DATE('2022-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (30, 8, 'Campo Laura Dias', 85219067, TO_DATE('2022-10-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (31, 8, 'Campo de Pires', 38838569, TO_DATE('2023-06-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (32, 8, 'Distrito da Mata', 47774589, TO_DATE('2020-10-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (33, 9, 'Quadra Jesus', 92512870, TO_DATE('2021-09-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (34, 9, 'Lago Barbosa', 67043436, TO_DATE('2021-03-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (35, 9, 'Núcleo Gabrielly Lima', 91328534, TO_DATE('2021-10-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (36, 9, 'Residencial Nogueira', 19780467, TO_DATE('2023-06-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (37, 10, 'Fazenda Fernanda Farias', 5829687, TO_DATE('2022-03-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (38, 11, 'Lagoa de Costa', 46490592, TO_DATE('2023-01-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (39, 11, 'Alameda Mariana Costa', 64048128, TO_DATE('2020-04-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (40, 11, 'Área de Teixeira', 82901229, TO_DATE('2023-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (41, 11, 'Vale de Barros', 88866518, TO_DATE('2023-10-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (42, 11, 'Favela Novaes', 16926139, TO_DATE('2021-06-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (43, 12, 'Alameda Pires', 93209298, TO_DATE('2020-02-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (44, 13, 'Pátio Maria Vitória Novaes', 66900573, TO_DATE('2022-11-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (45, 13, 'Trevo Julia Fernandes', 80968918, TO_DATE('2022-07-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (46, 13, 'Vereda Camila Ribeiro', 78908152, TO_DATE('2023-05-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (47, 13, 'Recanto da Conceição', 71757987, TO_DATE('2023-01-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (48, 14, 'Campo Castro', 29141606, TO_DATE('2021-02-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (49, 14, 'Estrada Laís Teixeira', 74920969, TO_DATE('2020-12-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (50, 14, 'Parque de Cavalcanti', 24651990, TO_DATE('2023-06-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (51, 14, 'Praia de Alves', 87197683, TO_DATE('2022-08-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (52, 14, 'Viaduto Ana Laura Fogaça', 6803732, TO_DATE('2020-11-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (53, 15, 'Viela Duarte', 71214846, TO_DATE('2020-07-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (54, 15, 'Viaduto Ramos', 34554473, TO_DATE('2021-08-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (55, 16, 'Praia de Dias', 1631747, TO_DATE('2020-08-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (56, 17, 'Sítio de Cavalcanti', 47239814, TO_DATE('2023-05-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (57, 17, 'Campo Camila Cardoso', 30049660, TO_DATE('2022-12-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (58, 18, 'Loteamento de Carvalho', 41313452, TO_DATE('2023-09-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (59, 18, 'Vila Pedro Lucas da Rosa', 6881502, TO_DATE('2021-01-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (60, 18, 'Vila Moura', 28628934, TO_DATE('2021-05-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (61, 19, 'Parque de Rodrigues', 48705426, TO_DATE('2021-05-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (62, 19, 'Pátio de Aragão', 87777436, TO_DATE('2022-05-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (63, 19, 'Vereda Luana Ramos', 21895184, TO_DATE('2023-06-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (64, 19, 'Fazenda Larissa Cardoso', 86410699, TO_DATE('2021-06-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (65, 19, 'Lagoa de Fernandes', 48555509, TO_DATE('2020-10-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (66, 20, 'Passarela de Silveira', 34625950, TO_DATE('2023-04-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (67, 20, 'Loteamento de Gonçalves', 69367132, TO_DATE('2022-10-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (68, 20, 'Passarela Correia', 67111780, TO_DATE('2023-09-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (69, 21, 'Pátio de Nascimento', 6258521, TO_DATE('2020-12-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (70, 22, 'Feira de Viana', 14346188, TO_DATE('2023-03-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (71, 22, 'Avenida Sabrina da Mota', 65059640, TO_DATE('2021-11-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (72, 22, 'Chácara de Carvalho', 11075512, TO_DATE('2020-12-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (73, 23, 'Vereda Caroline da Rosa', 50247717, TO_DATE('2020-12-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (74, 23, 'Trecho Nogueira', 89682935, TO_DATE('2022-03-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (75, 23, 'Vereda de Fogaça', 43359677, TO_DATE('2021-11-04', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (76, 24, 'Chácara Pedro Lucas da Cruz', 76835975, TO_DATE('2021-09-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (77, 24, 'Via de Souza', 40448748, TO_DATE('2022-08-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (78, 25, 'Morro de Moura', 60146941, TO_DATE('2021-06-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (79, 26, 'Trecho de Peixoto', 3696762, TO_DATE('2020-02-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (80, 26, 'Viaduto de Almeida', 74929319, TO_DATE('2021-10-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (81, 26, 'Rodovia Martins', 15889793, TO_DATE('2020-08-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (82, 26, 'Largo da Mata', 81051148, TO_DATE('2020-11-04', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (83, 26, 'Área da Conceição', 42217337, TO_DATE('2021-05-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (84, 27, 'Parque da Rosa', 63921676, TO_DATE('2023-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (85, 28, 'Núcleo Costela', 1524410, TO_DATE('2021-06-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (86, 29, 'Vila Lucca Nunes', 88634569, TO_DATE('2021-08-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (87, 29, 'Loteamento Beatriz Rocha', 24797050, TO_DATE('2020-01-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (88, 30, 'Praia Correia', 54289853, TO_DATE('2020-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (89, 30, 'Residencial da Mata', 75178779, TO_DATE('2022-08-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (90, 31, 'Núcleo Castro', 55953547, TO_DATE('2022-07-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (91, 31, 'Sítio da Conceição', 16830929, TO_DATE('2020-02-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (92, 31, 'Chácara de Martins', 298662, TO_DATE('2020-02-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (93, 31, 'Distrito de Oliveira', 21610659, TO_DATE('2020-06-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (94, 32, 'Ladeira da Mata', 40198264, TO_DATE('2020-08-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (95, 32, 'Ladeira Santos', 83819933, TO_DATE('2023-07-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (96, 32, 'Lago Viana', 99166344, TO_DATE('2023-09-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (97, 32, 'Distrito Marina Monteiro', 86295114, TO_DATE('2022-10-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (98, 32, 'Sítio Lorenzo Correia', 62907781, TO_DATE('2020-09-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (99, 33, 'Rua de Nascimento', 86911715, TO_DATE('2022-10-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (100, 33, 'Trecho de da Costa', 39157857, TO_DATE('2020-06-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (101, 34, 'Parque de da Cruz', 2364721, TO_DATE('2021-10-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (102, 34, 'Recanto da Cunha', 48025709, TO_DATE('2021-08-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (103, 34, 'Residencial Felipe Freitas', 76943777, TO_DATE('2022-06-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (104, 34, 'Vereda de Costa', 59477875, TO_DATE('2021-03-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (105, 34, 'Núcleo de Pinto', 8858614, TO_DATE('2021-02-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (106, 35, 'Ladeira Nunes', 73642364, TO_DATE('2021-03-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (107, 35, 'Lago Miguel Sales', 1473084, TO_DATE('2022-07-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (108, 35, 'Praia Alexia Mendes', 22905451, TO_DATE('2022-02-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (109, 36, 'Viaduto Davi Lucas da Rocha', 73603024, TO_DATE('2021-10-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (110, 36, 'Condomínio Teixeira', 6891853, TO_DATE('2020-03-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (111, 37, 'Residencial Azevedo', 82276002, TO_DATE('2020-06-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (112, 38, 'Sítio Larissa Araújo', 37708716, TO_DATE('2020-04-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (113, 38, 'Vale Ana Beatriz da Paz', 21094393, TO_DATE('2022-01-31', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (114, 38, 'Largo Pedro Lucas Costela', 39068690, TO_DATE('2020-08-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (115, 39, 'Praia Laura Gomes', 97907761, TO_DATE('2020-01-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (116, 40, 'Condomínio Carvalho', 55849005, TO_DATE('2020-01-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (117, 40, 'Feira Matheus Mendes', 10198475, TO_DATE('2023-10-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (118, 40, 'Trecho de Moreira', 58052122, TO_DATE('2021-02-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (119, 40, 'Largo Fernanda Souza', 84820613, TO_DATE('2022-10-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (120, 41, 'Lagoa de Souza', 31400021, TO_DATE('2023-08-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (121, 41, 'Parque Silva', 83898658, TO_DATE('2020-02-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (122, 41, 'Aeroporto Lucca da Paz', 65395854, TO_DATE('2021-05-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (123, 42, 'Feira Duarte', 42677559, TO_DATE('2021-08-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (124, 42, 'Alameda João Gabriel Pinto', 30067113, TO_DATE('2021-04-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (125, 42, 'Loteamento Lopes', 42681508, TO_DATE('2020-03-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (126, 42, 'Feira de Farias', 58991086, TO_DATE('2022-08-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (127, 43, 'Pátio Porto', 88878490, TO_DATE('2020-03-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (128, 44, 'Travessa de Moraes', 88524874, TO_DATE('2021-05-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (129, 45, 'Travessa Camila Oliveira', 53029338, TO_DATE('2023-09-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (130, 45, 'Campo de Ribeiro', 25181467, TO_DATE('2022-08-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (131, 45, 'Praia Maria Eduarda Dias', 53675921, TO_DATE('2022-05-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (132, 45, 'Viaduto Cavalcanti', 76281355, TO_DATE('2023-05-11', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (133, 45, 'Morro da Mota', 92845506, TO_DATE('2023-01-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (134, 46, 'Estrada Ramos', 6941836, TO_DATE('2022-12-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (135, 46, 'Fazenda de Lopes', 90079134, TO_DATE('2020-03-20', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (136, 46, 'Vale Calebe Cardoso', 78257620, TO_DATE('2020-08-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (137, 46, 'Trevo Correia', 48347745, TO_DATE('2022-02-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (138, 46, 'Praça Castro', 92205789, TO_DATE('2022-03-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (139, 47, 'Alameda Araújo', 333469, TO_DATE('2020-10-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (140, 47, 'Feira de da Luz', 43083008, TO_DATE('2020-10-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (141, 47, 'Trecho Leandro Gomes', 33119516, TO_DATE('2021-02-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (142, 48, 'Residencial Maria Azevedo', 87920709, TO_DATE('2020-03-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (143, 48, 'Parque de Gomes', 12510697, TO_DATE('2022-04-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (144, 48, 'Trecho de Moraes', 45251134, TO_DATE('2023-11-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (145, 48, 'Favela de Melo', 34805140, TO_DATE('2020-05-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (146, 49, 'Vereda Maria Julia Melo', 74070588, TO_DATE('2022-04-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (147, 49, 'Rodovia Oliveira', 15457418, TO_DATE('2020-11-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (148, 49, 'Travessa de da Luz', 41536703, TO_DATE('2022-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (149, 49, 'Distrito Gomes', 1990002, TO_DATE('2023-07-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (150, 49, 'Ladeira Nicole Peixoto', 36810654, TO_DATE('2021-07-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (151, 50, 'Vale Sales', 47809209, TO_DATE('2021-05-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (152, 50, 'Trevo Julia Sales', 12383989, TO_DATE('2021-05-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (153, 51, 'Lagoa Pedro Aragão', 41732019, TO_DATE('2022-05-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (154, 52, 'Via Milena Gomes', 49238397, TO_DATE('2023-11-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (155, 52, 'Ladeira Nicolas Costela', 1849809, TO_DATE('2020-03-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (156, 52, 'Loteamento de Moraes', 24778546, TO_DATE('2023-02-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (157, 52, 'Morro Júlia Monteiro', 81835221, TO_DATE('2020-11-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (158, 53, 'Estação Oliveira', 28278823, TO_DATE('2021-09-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (159, 53, 'Trecho Mendes', 90483903, TO_DATE('2020-06-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (160, 53, 'Ladeira Moura', 14996220, TO_DATE('2022-09-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (161, 54, 'Viaduto Pereira', 5179707, TO_DATE('2020-11-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (162, 55, 'Via da Mata', 43804668, TO_DATE('2023-02-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (163, 55, 'Lago Catarina Rocha', 26425050, TO_DATE('2020-08-26', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (164, 55, 'Praça Moreira', 7320784, TO_DATE('2021-10-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (165, 56, 'Via Melo', 2724383, TO_DATE('2022-07-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (166, 56, 'Setor de Martins', 18217680, TO_DATE('2023-09-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (167, 57, 'Recanto de Moreira', 28127514, TO_DATE('2020-04-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (168, 57, 'Rua Barros', 3069073, TO_DATE('2022-08-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (169, 57, 'Praia das Neves', 28896791, TO_DATE('2022-06-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (170, 57, 'Lago Vieira', 10892033, TO_DATE('2023-02-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (171, 57, 'Vale Bryan Sales', 72844421, TO_DATE('2021-10-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (172, 58, 'Colônia Eloah Caldeira', 23478350, TO_DATE('2022-07-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (173, 58, 'Favela Yasmin Pinto', 65232936, TO_DATE('2022-01-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (174, 58, 'Quadra de Carvalho', 8480405, TO_DATE('2021-08-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (175, 59, 'Condomínio Enzo Pinto', 30717249, TO_DATE('2023-07-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (176, 60, 'Fazenda de Lopes', 41090940, TO_DATE('2020-12-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (177, 60, 'Rodovia de Moreira', 51144431, TO_DATE('2023-07-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (178, 60, 'Núcleo Lima', 45527055, TO_DATE('2020-09-25', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (179, 60, 'Jardim de Sales', 67562261, TO_DATE('2022-09-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (180, 60, 'Parque das Neves', 38387082, TO_DATE('2020-05-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (181, 61, 'Chácara Stella da Mata', 11073667, TO_DATE('2022-10-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (182, 61, 'Chácara Fogaça', 50663166, TO_DATE('2022-08-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (183, 61, 'Aeroporto Lopes', 7604503, TO_DATE('2023-08-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (184, 62, 'Passarela de Nunes', 71738503, TO_DATE('2021-07-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (185, 62, 'Vale Novaes', 63869991, TO_DATE('2021-08-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (186, 63, 'Setor de Cardoso', 99603789, TO_DATE('2021-06-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (187, 63, 'Vila Cunha', 60065964, TO_DATE('2022-05-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (188, 63, 'Praia Fernandes', 14742470, TO_DATE('2020-02-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (189, 64, 'Conjunto de Vieira', 10266553, TO_DATE('2021-02-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (190, 64, 'Residencial de Jesus', 68526928, TO_DATE('2022-12-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (191, 64, 'Núcleo de Cunha', 77617310, TO_DATE('2021-12-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (192, 64, 'Morro da Luz', 12140698, TO_DATE('2020-01-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (193, 65, 'Via Enzo Gabriel Barros', 89141811, TO_DATE('2020-07-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (194, 65, 'Jardim de Oliveira', 77734167, TO_DATE('2022-11-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (195, 65, 'Setor de Cavalcanti', 55032568, TO_DATE('2021-04-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (196, 66, 'Setor de Nascimento', 81973521, TO_DATE('2022-01-14', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (197, 66, 'Vale Cavalcanti', 49224360, TO_DATE('2023-09-27', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (198, 66, 'Quadra Rafael Rocha', 87752582, TO_DATE('2021-06-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (199, 67, 'Colônia Alice Gonçalves', 54702033, TO_DATE('2021-10-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (200, 67, 'Travessa da Luz', 2929060, TO_DATE('2022-01-05', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (201, 68, 'Sítio Eduarda Rodrigues', 77221763, TO_DATE('2023-01-16', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (202, 68, 'Feira Pires', 71881815, TO_DATE('2021-08-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (203, 68, 'Avenida Nascimento', 97538512, TO_DATE('2020-09-19', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (204, 69, 'Distrito de da Cunha', 56731193, TO_DATE('2022-12-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (205, 69, 'Colônia de Souza', 18610624, TO_DATE('2023-05-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (206, 69, 'Lagoa das Neves', 21322681, TO_DATE('2020-01-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (207, 69, 'Viela Aragão', 38079808, TO_DATE('2023-09-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (208, 70, 'Rua Laura Castro', 91438362, TO_DATE('2021-08-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (209, 70, 'Colônia de Rezende', 625784, TO_DATE('2023-07-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (210, 70, 'Sítio Maria Costela', 91177282, TO_DATE('2022-04-08', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (211, 71, 'Alameda de Cavalcanti', 88119417, TO_DATE('2023-10-17', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (212, 71, 'Campo de Viana', 23519266, TO_DATE('2021-09-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (213, 71, 'Esplanada Carvalho', 3479131, TO_DATE('2020-04-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (214, 71, 'Chácara de Ribeiro', 59556829, TO_DATE('2022-08-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (215, 71, 'Lago Nathan da Mota', 67285085, TO_DATE('2022-05-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (216, 72, 'Núcleo de Novaes', 28621620, TO_DATE('2022-09-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (217, 72, 'Campo de da Cruz', 48332143, TO_DATE('2020-01-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (218, 72, 'Praia Melissa Almeida', 64955137, TO_DATE('2023-07-10', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (219, 73, 'Vale de da Mota', 78285553, TO_DATE('2021-09-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (220, 73, 'Vila de Moreira', 22954599, TO_DATE('2020-10-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (221, 73, 'Campo Fogaça', 84333859, TO_DATE('2023-10-02', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (222, 73, 'Avenida de Castro', 87286784, TO_DATE('2020-11-13', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (223, 73, 'Lagoa Maria Cecília Rezende', 23987199, TO_DATE('2020-07-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (224, 74, 'Feira Theo Almeida', 20188688, TO_DATE('2023-03-03', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (225, 74, 'Praça Nascimento', 41707569, TO_DATE('2020-01-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (226, 74, 'Condomínio de Araújo', 40615387, TO_DATE('2023-04-01', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (227, 74, 'Morro de Fogaça', 48191343, TO_DATE('2021-11-22', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (228, 75, 'Vila Cardoso', 68442867, TO_DATE('2021-12-31', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (229, 75, 'Viela Ana Júlia Rodrigues', 41154470, TO_DATE('2023-06-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (230, 75, 'Parque de da Rosa', 733083, TO_DATE('2021-05-15', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (231, 76, 'Estação de Nogueira', 80028731, TO_DATE('2023-04-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (232, 77, 'Área de Rocha', 99112445, TO_DATE('2022-03-21', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (233, 78, 'Jardim Heitor Dias', 76436715, TO_DATE('2023-08-24', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (234, 78, 'Área Rodrigues', 92861851, TO_DATE('2023-02-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (235, 79, 'Viela de Santos', 42221350, TO_DATE('2021-12-29', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (236, 79, 'Fazenda Marcelo Dias', 68080526, TO_DATE('2020-04-30', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (237, 79, 'Travessa Cunha', 61053637, TO_DATE('2023-06-09', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (238, 80, 'Área de Correia', 46427281, TO_DATE('2022-11-07', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (239, 80, 'Campo de Fogaça', 80246945, TO_DATE('2023-03-23', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (240, 80, 'Via de da Cruz', 60375822, TO_DATE('2021-02-28', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (241, 80, 'Ladeira Alexia Novaes', 50491400, TO_DATE('2021-06-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (242, 81, 'Conjunto Laís Melo', 7868687, TO_DATE('2022-02-12', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (243, 81, 'Colônia Jesus', 92947382, TO_DATE('2022-05-18', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (244, 81, 'Conjunto da Conceição', 66432165, TO_DATE('2021-02-06', 'YYYY-MM-DD'));


        INSERT INTO tg_logradouro (id_logradouro, id_bairro, nm_logradouro, nr_cep, dt_cadastro)
        VALUES (245, 81, 'Trevo de Freitas', 15232040, TO_DATE('2020-09-19', 'YYYY-MM-DD'));

        -- inserindo os usuarios 


        INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
        VALUES (1, 'Isabella Nunes', 67122920050, '511386395', TO_DATE('1982-12-28', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-07-12', 'YYYY-MM-DD'), 'davi-luiz52@example.net', 'zQa#E4HoV9');
    
        INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (2, 'Marcela da Mata', 64877341156, '258574258', TO_DATE('1990-05-23', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'pribeiro@example.net', 'ja8C1R#b)n');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (3, 'Srta. Laís Pereira', 1230254153, '942296991', TO_DATE('1989-12-12', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-10-24', 'YYYY-MM-DD'), 'scampos@example.net', 'H)8*SwrTJ&');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (4, 'Henrique da Luz', 50533475809, '174695393', TO_DATE('1945-11-27', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-11-02', 'YYYY-MM-DD'), 'freitasisaac@example.net', '+fs1EzQxrQ');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (5, 'Murilo Cardoso', 89796515665, '828367878', TO_DATE('1945-07-11', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-03-07', 'YYYY-MM-DD'), 'ana-livia00@example.org', 'AU$1zRwbxQ');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (6, 'Leandro Lopes', 48381424490, '5672846', TO_DATE('1955-05-19', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-10-20', 'YYYY-MM-DD'), 'carvalhoevelyn@example.com', 'k68f9Bwl#1');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (7, 'Arthur Caldeira', 88713372008, '39515305', TO_DATE('1967-05-23', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'fpinto@example.net', '(9d&PBlm8#');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (8, 'Larissa Nunes', 74468185043, '543103211', TO_DATE('1950-01-09', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-04-25', 'YYYY-MM-DD'), 'correialorena@example.org', 'a^F!5O4tXy');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (9, 'Sr. Vitor Carvalho', 85224566982, '747057680', TO_DATE('2003-06-28', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-10-14', 'YYYY-MM-DD'), 'da-luzbeatriz@example.com', 'o4+SAGi*)f');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (10, 'Sophie Rodrigues', 41155212251, '312656695', TO_DATE('1980-01-04', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-10-09', 'YYYY-MM-DD'), 'luiz-fernando94@example.net', '((45iRPoxO');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (11, 'Dr. Breno Gonçalves', 56416030997, '568130725', TO_DATE('1971-03-10', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-05-06', 'YYYY-MM-DD'), 'marcelogoncalves@example.net', '_$xFXYf(^0');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (12, 'Benjamin da Conceição', 37100755984, '828927075', TO_DATE('1970-03-14', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-03-20', 'YYYY-MM-DD'), 'cgoncalves@example.com', '5&XrOm*D#m');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (13, 'Luigi Rocha', 24627801104, '921702611', TO_DATE('1959-08-27', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-06-04', 'YYYY-MM-DD'), 'earagao@example.com', 'HH5@wQoAb)');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (14, 'Vitor Hugo da Cunha', 51326427323, '983913417', TO_DATE('1998-03-06', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-11-12', 'YYYY-MM-DD'), 'sarah02@example.net', ')7)gHza55Z');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (15, 'Laura Sales', 90920985539, '562377858', TO_DATE('1973-08-30', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-10-02', 'YYYY-MM-DD'), 'oalmeida@example.net', '!XhH#QdF0A');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (16, 'Sr. Samuel Farias', 47246847444, '12679360', TO_DATE('1981-04-27', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-11-09', 'YYYY-MM-DD'), 'paulo89@example.org', '$8NS2AMhRJ');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (17, 'Cauê da Cunha', 83555744043, '120654246', TO_DATE('1968-03-20', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-12-12', 'YYYY-MM-DD'), 'enzolopes@example.net', '99O3R4ykV*');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (18, 'Dr. Danilo Mendes', 35511481105, '641868235', TO_DATE('1950-08-08', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-10-19', 'YYYY-MM-DD'), 'cda-mata@example.org', '^b2SQkoBw+');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (19, 'Bruno Almeida', 19030232903, '343698553', TO_DATE('1946-05-25', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-09-18', 'YYYY-MM-DD'), 'da-rosamaria-cecilia@example.net', '@UnO9!Jn@K');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (20, 'Thiago Santos', 96638018899, '961759108', TO_DATE('1970-04-27', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-08-30', 'YYYY-MM-DD'), 'sporto@example.net', '&xRdFCUdV6');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (21, 'Emanuel Nascimento', 98572404512, '728678232', TO_DATE('1981-07-12', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-01-03', 'YYYY-MM-DD'), 'jcaldeira@example.com', 'M%15sJ$hwt');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (22, 'Sr. Miguel Santos', 69382830349, '44956729', TO_DATE('1962-08-20', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-12-07', 'YYYY-MM-DD'), 'evelyncardoso@example.net', '^8Mewm_NZ^');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (23, 'Dra. Luana Barros', 11869485849, '851583141', TO_DATE('1972-03-05', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-10-18', 'YYYY-MM-DD'), 'fernandescaua@example.net', 'RdO6Qydz1(');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (24, 'Isabelly Ferreira', 13705611138, '983095935', TO_DATE('1990-03-06', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-09-17', 'YYYY-MM-DD'), 'almeidathomas@example.com', '*)U54Cd*ph');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (25, 'Srta. Melissa Gomes', 58117082447, '854972250', TO_DATE('1965-10-01', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-03-29', 'YYYY-MM-DD'), 'luiz-henrique99@example.org', 'W0nC45Sdq)');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (26, 'Sophie Oliveira', 93306752846, '613052781', TO_DATE('1986-11-28', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-09-17', 'YYYY-MM-DD'), 'mendesgustavo@example.com', 'A&57V@lN*x');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (27, 'Levi Cavalcanti', 80803406037, '455745815', TO_DATE('2005-04-27', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-06-02', 'YYYY-MM-DD'), 'luiz-henrique17@example.org', '%R4%V!WzcY');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (28, 'Lucca Melo', 9254529717, '231846724', TO_DATE('1963-04-26', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-04-26', 'YYYY-MM-DD'), 'nathanrezende@example.org', 'hR9TBhMcF&');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (29, 'João Miguel Barbosa', 31145183861, '196969700', TO_DATE('1945-12-05', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-07-19', 'YYYY-MM-DD'), 'novaesigor@example.com', 'O@T2pBxhPW');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (30, 'Ana Beatriz Rocha', 19489465146, '422710717', TO_DATE('2005-09-25', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-01-27', 'YYYY-MM-DD'), 'pedro-henrique04@example.org', 'b8tTW7*P&j');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (31, 'Dra. Sabrina Sales', 27970946787, '656162517', TO_DATE('1954-07-20', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-07-19', 'YYYY-MM-DD'), 'almeidaisabelly@example.org', '!gv^d#I^E9');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (32, 'Sra. Brenda da Paz', 51530265501, '150502108', TO_DATE('1957-02-10', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-04-14', 'YYYY-MM-DD'), 'cunhapedro-henrique@example.net', 'O&C08Feppa');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (33, 'Lucca Viana', 62067805314, '837700746', TO_DATE('1944-10-17', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-05-23', 'YYYY-MM-DD'), 'maria-vitoriaalmeida@example.com', 'u)1DOrkHpz');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (34, 'Dr. Benjamin da Cunha', 94891791910, '339733266', TO_DATE('1963-07-12', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'pedrosilveira@example.net', 'FDs7LZe!@V');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (35, 'Kamilly Silveira', 18858529686, '644821235', TO_DATE('1951-10-25', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-09-26', 'YYYY-MM-DD'), 'raquel19@example.net', '*x5xFW^j)k');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (36, 'Sr. Leonardo Costa', 50048358435, '362821969', TO_DATE('1983-12-11', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-03-12', 'YYYY-MM-DD'), 'diego31@example.org', '#0fHVGEfEl');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (37, 'Sra. Evelyn Barros', 67561357729, '888668282', TO_DATE('1982-11-22', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-04-14', 'YYYY-MM-DD'), 'renannunes@example.com', 'Ov@1G4o58V');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (38, 'Sr. Alexandre Carvalho', 65427207403, '936117501', TO_DATE('1960-11-15', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-09-02', 'YYYY-MM-DD'), 'enzo-gabrielcardoso@example.net', 'AjL0vPve)1');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (39, 'Marcos Vinicius Silveira', 57519613115, '846096365', TO_DATE('1950-10-05', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-03-06', 'YYYY-MM-DD'), 'castrolucas@example.com', '_SxD&yPs13');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (40, 'Gabriela Jesus', 41434657564, '976740165', TO_DATE('1963-01-23', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-05-29', 'YYYY-MM-DD'), 'melolara@example.org', '*bArW@h67K');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (41, 'Sr. João Pedro da Paz', 40818637885, '330223241', TO_DATE('1959-08-14', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-08-12', 'YYYY-MM-DD'), 'ana-carolina17@example.org', '%0KzKfGj$M');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (42, 'Srta. Giovanna Fernandes', 28176766248, '106079898', TO_DATE('1965-07-07', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-12-09', 'YYYY-MM-DD'), 'da-conceicaodavi-lucas@example.net', '&F+9VcxYSw');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (43, 'Dr. Ian Nunes', 31014145530, '83596448', TO_DATE('1958-09-30', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-01-25', 'YYYY-MM-DD'), 'arthurcostela@example.com', '#W0Kfee&T6');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (44, 'Natália Santos', 43752778951, '24447446', TO_DATE('1956-11-07', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-03-30', 'YYYY-MM-DD'), 'costaalicia@example.com', 'mRB6_AGyO&');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (45, 'Dr. Guilherme Barbosa', 98052255894, '675579796', TO_DATE('1956-08-21', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-12-08', 'YYYY-MM-DD'), 'fsouza@example.com', '#V29QuzpUj');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (46, 'Sra. Isabel Freitas', 73709470455, '383477883', TO_DATE('1945-05-26', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-11-03', 'YYYY-MM-DD'), 'vinicius92@example.net', 'M3qI5zKo)I');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (47, 'Vicente Moraes', 36610013592, '465979869', TO_DATE('1967-10-09', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-02-27', 'YYYY-MM-DD'), 'laramartins@example.com', 'D%E&1N^iW+');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (48, 'Stephany da Mota', 26638588854, '145140577', TO_DATE('1964-10-29', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-06-24', 'YYYY-MM-DD'), 'joao-miguel82@example.net', '!e%5(#RrK*');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (49, 'Dr. Benjamin Azevedo', 59288439646, '131621150', TO_DATE('2004-07-29', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-07-22', 'YYYY-MM-DD'), 'lcosta@example.net', '76tH6Mpg_p');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (50, 'Fernanda Farias', 11396954541, '319337962', TO_DATE('1975-09-29', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-08-03', 'YYYY-MM-DD'), 'pedro-miguelnovaes@example.org', 'b^9QuILnGF');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (51, 'Francisco Caldeira', 9676697909, '711355845', TO_DATE('1963-10-25', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-06-01', 'YYYY-MM-DD'), 'cardosoemanuella@example.net', '+5u3%6Fb@H');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (52, 'Cauê Fogaça', 20931419991, '752303748', TO_DATE('1992-06-29', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-03-11', 'YYYY-MM-DD'), 'ana20@example.net', '_8j23Zrs+c');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (53, 'Leonardo Monteiro', 17255385238, '212610582', TO_DATE('1946-07-16', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-11-09', 'YYYY-MM-DD'), 'oribeiro@example.net', 'S^(0gBat&5');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (54, 'Luiz Felipe Viana', 92032583486, '844229343', TO_DATE('1976-05-09', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'emartins@example.org', 's&8Tkb%d*p');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (55, 'Gabriela Cunha', 92672351174, '989980638', TO_DATE('1977-01-15', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-03-24', 'YYYY-MM-DD'), 'ecorreia@example.org', '8bp4C$bf^5');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (56, 'Leandro Silveira', 88302730971, '803374528', TO_DATE('1985-08-04', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-11-08', 'YYYY-MM-DD'), 'dda-costa@example.org', '^$iD1QcD+#');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (57, 'Sophie Freitas', 54074546156, '3703660', TO_DATE('2001-07-01', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-01-07', 'YYYY-MM-DD'), 'cnovaes@example.net', '^gtROxja&9');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (58, 'Marcos Vinicius Pinto', 64326126784, '900838782', TO_DATE('1972-01-15', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-09-30', 'YYYY-MM-DD'), 'alexia83@example.com', ')5ryKjb@XN');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (59, 'Beatriz Ramos', 4505342592, '866198809', TO_DATE('2002-10-13', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-10-19', 'YYYY-MM-DD'), 'emanuelnascimento@example.net', ')0j4PzX27k');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (60, 'Ana Sophia da Paz', 62090883830, '935634115', TO_DATE('1992-07-17', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-12-24', 'YYYY-MM-DD'), 'carolina87@example.net', 'c59ZKtHu)c');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (61, 'João Pedro Cardoso', 22391247242, '609424722', TO_DATE('1963-12-11', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-09-18', 'YYYY-MM-DD'), 'pda-rocha@example.com', 'C6nAvOsc**');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (62, 'Leandro Pinto', 27248509183, '817152870', TO_DATE('2004-02-21', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-05-03', 'YYYY-MM-DD'), 'pcardoso@example.org', '2E%8xtls@&');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (63, 'Sra. Catarina Nunes', 11603325071, '112764272', TO_DATE('1961-10-04', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-07-07', 'YYYY-MM-DD'), 'opeixoto@example.net', '!9X7Sr5^VL');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (64, 'Raquel da Paz', 42065690317, '107146374', TO_DATE('1983-10-08', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-08-14', 'YYYY-MM-DD'), 'lucasda-paz@example.org', '(C!K&%Dy*1');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (65, 'Ryan Silva', 47827327886, '590301156', TO_DATE('1999-07-25', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-12-28', 'YYYY-MM-DD'), 'nda-costa@example.com', 'AY1Ka0tXQ+');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (66, 'João Miguel das Neves', 87308476008, '320892071', TO_DATE('1950-08-28', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-06-14', 'YYYY-MM-DD'), 'luiginunes@example.net', '(3Nmr1a!SL');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (67, 'Marcela Cavalcanti', 71618707001, '4098130', TO_DATE('1995-10-20', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-03-28', 'YYYY-MM-DD'), 'maria-julia96@example.org', '#osF8IQoD(');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (68, 'João Gabriel Ferreira', 26232379060, '570214740', TO_DATE('1953-02-22', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-02-08', 'YYYY-MM-DD'), 'cecilia84@example.org', '+d8@vgLrv0');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (69, 'Dra. Marcela Fogaça', 40592953386, '364624071', TO_DATE('1960-04-06', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-12-24', 'YYYY-MM-DD'), 'gpeixoto@example.org', '0Ir&3IbZ%q');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (70, 'Maria Alice Cardoso', 35272447880, '869195522', TO_DATE('1995-12-25', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-04-03', 'YYYY-MM-DD'), 'clara82@example.com', 'B6cghFdr^f');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (71, 'Dr. Luiz Otávio Freitas', 45696880666, '66330741', TO_DATE('1961-03-20', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-07-01', 'YYYY-MM-DD'), 'gabrielcostela@example.net', 'a0VXuDF^&D');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (72, 'Dr. Luiz Henrique Souza', 87524551971, '865582503', TO_DATE('1959-11-13', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-05-09', 'YYYY-MM-DD'), 'julia31@example.net', '^sU!1Rnj5Z');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (73, 'Vitor Cardoso', 97496306603, '638083873', TO_DATE('1971-03-23', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-03-21', 'YYYY-MM-DD'), 'luiz-otavio96@example.com', 'r!bRLjum%7');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (74, 'Srta. Ana Luiza Castro', 70652024584, '707111428', TO_DATE('1979-12-03', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-06-19', 'YYYY-MM-DD'), 'maria-clara08@example.org', '27A6k&mN@6');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (75, 'Ana Sophia Gonçalves', 38292809006, '172728575', TO_DATE('1974-05-05', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'ian24@example.org', 'i6VmHFOb^v');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (76, 'Gustavo Henrique Lima', 16407901669, '831384721', TO_DATE('1988-12-29', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-10-11', 'YYYY-MM-DD'), 'sophiecaldeira@example.org', '^(9!hPcyao');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (77, 'Luiza da Mota', 28472105158, '845507408', TO_DATE('1951-11-27', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-11-29', 'YYYY-MM-DD'), 'sophievieira@example.org', '^moGl+Ah2X');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (78, 'Srta. Pietra Nascimento', 81406702633, '464746358', TO_DATE('1973-03-14', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-06-13', 'YYYY-MM-DD'), 'pedro-henriquevieira@example.org', 'n!2#xZyz&F');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (79, 'Igor Almeida', 53142941952, '1790623', TO_DATE('1958-04-08', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-06-07', 'YYYY-MM-DD'), 'camila44@example.com', 'cb4&#Kla$)');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (80, 'Sra. Evelyn Rocha', 36435638260, '906443506', TO_DATE('1991-04-08', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-08-21', 'YYYY-MM-DD'), 'marcela91@example.com', 'Zh0(G6td%&');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (81, 'Sr. Enzo Gabriel Ramos', 59932312665, '169157641', TO_DATE('1997-10-06', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-10-09', 'YYYY-MM-DD'), 'barbosapedro-henrique@example.org', '34E5E4ri_0');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (82, 'Eduarda Nunes', 77469555041, '158561931', TO_DATE('1984-05-10', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-07-15', 'YYYY-MM-DD'), 'novaesmirella@example.org', 'IP22Zsvc^w');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (83, 'Lívia Azevedo', 79605160063, '729995262', TO_DATE('1954-04-05', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-08-20', 'YYYY-MM-DD'), 'orodrigues@example.org', 'T0A1wcIt^R');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (84, 'Luiz Fernando Peixoto', 19918778316, '315027641', TO_DATE('1948-06-10', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'amanda52@example.net', '$X0fZ4Ubud');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (85, 'Luigi Santos', 5429573214, '66808682', TO_DATE('1979-09-20', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-01-19', 'YYYY-MM-DD'), 'oliveiraana-julia@example.com', ')4p5PQ0mmf');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (86, 'Laura Carvalho', 10297798760, '310833979', TO_DATE('1996-07-28', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-12-15', 'YYYY-MM-DD'), 'leticia54@example.org', '085DxE6^&s');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (87, 'Helena Duarte', 77326776454, '476137486', TO_DATE('1956-06-28', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-04-17', 'YYYY-MM-DD'), 'alana31@example.com', 'w)U8TmIFra');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (88, 'Sr. Theo Nunes', 23858705483, '809181518', TO_DATE('1963-02-26', 'YYYY-MM-DD'), 'F',
            TO_DATE('2023-02-22', 'YYYY-MM-DD'), 'da-rosaana-vitoria@example.org', 'lkm*K4YBt(');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (89, 'Maria Alice Barros', 62744978318, '492488341', TO_DATE('1952-11-10', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-03-07', 'YYYY-MM-DD'), 'da-conceicaobianca@example.com', '*2vFV$zh0(');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (90, 'Ryan Nunes', 11013718981, '194511515', TO_DATE('1990-11-09', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-09-04', 'YYYY-MM-DD'), 'costanina@example.com', 'FP_1DewujO');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (91, 'Bernardo Cardoso', 37977591092, '374833338', TO_DATE('1957-03-14', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-07-27', 'YYYY-MM-DD'), 'moraesmaria-clara@example.com', '!5d3Vww669');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (92, 'João Gabriel Pinto', 8961352027, '5061464', TO_DATE('1999-09-07', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-09-07', 'YYYY-MM-DD'), 'vitor-hugo11@example.org', '+89eHRu2(r');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (93, 'Murilo Silveira', 90428197824, '653285063', TO_DATE('1982-12-12', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-06-26', 'YYYY-MM-DD'), 'manueladias@example.net', 'Ia$2MmEaXD');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (94, 'Melissa da Rosa', 52967702270, '499923533', TO_DATE('1977-12-25', 'YYYY-MM-DD'), 'M',
            TO_DATE('2020-05-13', 'YYYY-MM-DD'), 'otaviorodrigues@example.net', '#9K)cCqik(');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (95, 'Agatha Gonçalves', 79016262958, '729523727', TO_DATE('1985-01-13', 'YYYY-MM-DD'), 'M',
            TO_DATE('2021-06-17', 'YYYY-MM-DD'), 'eloahsales@example.org', 'k63JT60i_i');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (96, 'Yasmin Cunha', 28827934470, '596511408', TO_DATE('1977-12-19', 'YYYY-MM-DD'), 'F',
            TO_DATE('2021-05-11', 'YYYY-MM-DD'), 'barroscaio@example.com', '*Jl89IPmaG');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (97, 'Dra. Ana Vitória Fogaça', 92941081601, '204319141', TO_DATE('1973-09-02', 'YYYY-MM-DD'), 'M',
            TO_DATE('2022-10-20', 'YYYY-MM-DD'), 'lais08@example.org', 'e#1B*hp^9h');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (98, 'Sophia Cardoso', 57512186635, '864826786', TO_DATE('1944-02-11', 'YYYY-MM-DD'), 'F',
            TO_DATE('2020-02-13', 'YYYY-MM-DD'), 'milena12@example.org', 'x0YQiD(I@1');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (99, 'Heloísa Carvalho', 43375286927, '788927002', TO_DATE('1992-03-22', 'YYYY-MM-DD'), 'M',
            TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'beniciosantos@example.net', 'wb%SEsWF@4');


    INSERT INTO tg_usuario (id_usuario, nm_usuario, nr_cpf, nm_rg, dt_nascimento, fl_genero, dt_cadastro, nm_email, nm_senha)
    VALUES (100, 'Ana Lívia Costa', 96977430730, '537923668', TO_DATE('1954-06-20', 'YYYY-MM-DD'), 'F',
            TO_DATE('2022-02-28', 'YYYY-MM-DD'), 'biancada-rosa@example.com', 'DApctCyc@6');

-- inserindo os endereços para os usuarios 

INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (1, 1, 1, 4158, 'Quae provident dolorum sed.', 'Eligendi assumenda sequi.',
            TO_DATE('2022-10-12', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'), TO_DATE('2020-07-28', 'YYYY-MM-DD'));
    

    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (2, 2, 2, 4910, 'Culpa quas neque molestias.', 'Rerum animi sequi animi.',
            TO_DATE('2023-01-06', 'YYYY-MM-DD'), TO_DATE('2024-01-09', 'YYYY-MM-DD'), TO_DATE('2022-02-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (3, 3, 3, 8576, 'Omnis et non et.', 'Aut dicta qui iusto.',
            TO_DATE('2023-03-11', 'YYYY-MM-DD'), TO_DATE('2024-07-05', 'YYYY-MM-DD'), TO_DATE('2022-07-13', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (4, 4, 4, 8000, 'Neque tempora cum corrupti.', 'Labore atque id.',
            TO_DATE('2023-11-13', 'YYYY-MM-DD'), TO_DATE('2024-06-09', 'YYYY-MM-DD'), TO_DATE('2023-03-03', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (5, 5, 5, 3649, 'Possimus magni qui voluptas.', 'Vel eos quibusdam tempore.',
            TO_DATE('2023-10-25', 'YYYY-MM-DD'), TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2021-10-28', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (6, 6, 6, 2197, 'Libero optio optio error.', 'Necessitatibus quia vero.',
            TO_DATE('2021-11-05', 'YYYY-MM-DD'), TO_DATE('2024-05-28', 'YYYY-MM-DD'), TO_DATE('2022-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (7, 7, 7, 1419, 'Minima laudantium cumque.', 'Ipsum dolorem reprehenderit.',
            TO_DATE('2020-03-08', 'YYYY-MM-DD'), TO_DATE('2024-01-29', 'YYYY-MM-DD'), TO_DATE('2020-04-28', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (8, 8, 8, 990, 'Quae quibusdam assumenda.', 'Aliquam eos laboriosam quia.',
            TO_DATE('2022-04-07', 'YYYY-MM-DD'), TO_DATE('2024-08-04', 'YYYY-MM-DD'), TO_DATE('2021-07-31', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (9, 9, 9, 1359, 'Unde inventore tenetur harum.', 'Vel mollitia iste inventore.',
            TO_DATE('2020-02-11', 'YYYY-MM-DD'), TO_DATE('2024-08-13', 'YYYY-MM-DD'), TO_DATE('2020-01-16', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (10, 10, 10, 9107, 'Qui dolorum hic maiores.', 'Enim soluta itaque excepturi.',
            TO_DATE('2021-07-31', 'YYYY-MM-DD'), TO_DATE('2024-01-04', 'YYYY-MM-DD'), TO_DATE('2020-04-22', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (11, 11, 11, 9689, 'Eum eveniet dicta eum.', 'Quam ullam mollitia voluptas.',
            TO_DATE('2023-02-07', 'YYYY-MM-DD'), TO_DATE('2024-03-08', 'YYYY-MM-DD'), TO_DATE('2022-02-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (12, 12, 12, 7078, 'A minus voluptas nisi ipsam.', 'Minus fuga cum odit.',
            TO_DATE('2023-06-09', 'YYYY-MM-DD'), TO_DATE('2024-09-04', 'YYYY-MM-DD'), TO_DATE('2023-06-24', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (13, 13, 13, 6936, 'Quia saepe suscipit debitis.', 'Numquam ad autem tempore.',
            TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2024-03-22', 'YYYY-MM-DD'), TO_DATE('2022-07-20', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (14, 14, 14, 2856, 'Non cum tempora totam.', 'Autem et aut.',
            TO_DATE('2022-12-09', 'YYYY-MM-DD'), TO_DATE('2024-09-21', 'YYYY-MM-DD'), TO_DATE('2023-02-02', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (15, 15, 15, 2237, 'Dicta maxime aperiam quidem.', 'Doloribus in ut quod.',
            TO_DATE('2023-08-24', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'), TO_DATE('2022-02-23', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (16, 16, 16, 7638, 'Ex nulla nam praesentium.', 'Quod ullam velit.',
            TO_DATE('2020-09-25', 'YYYY-MM-DD'), TO_DATE('2024-04-03', 'YYYY-MM-DD'), TO_DATE('2020-12-16', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (17, 17, 17, 5117, 'Eum aperiam ea iure.', 'Ipsa atque eligendi error.',
            TO_DATE('2023-08-24', 'YYYY-MM-DD'), TO_DATE('2023-12-11', 'YYYY-MM-DD'), TO_DATE('2022-10-05', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (18, 18, 18, 2136, 'Hic eveniet ratione vel.', 'Error id amet fugit animi.',
            TO_DATE('2021-06-19', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), TO_DATE('2020-06-12', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (19, 19, 19, 8742, 'Praesentium in ipsa iste non.', 'Architecto voluptatem ab.',
            TO_DATE('2022-01-20', 'YYYY-MM-DD'), TO_DATE('2024-05-14', 'YYYY-MM-DD'), TO_DATE('2021-07-28', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (20, 20, 20, 5966, 'Eligendi at quos.', 'Maiores recusandae earum.',
            TO_DATE('2023-07-04', 'YYYY-MM-DD'), TO_DATE('2024-01-02', 'YYYY-MM-DD'), TO_DATE('2020-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (21, 21, 21, 5737, 'Maiores itaque impedit.', 'Minus sit enim omnis.',
            TO_DATE('2022-03-18', 'YYYY-MM-DD'), TO_DATE('2024-09-05', 'YYYY-MM-DD'), TO_DATE('2023-09-15', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (22, 22, 22, 4643, 'Dolore ullam amet excepturi.', 'Magnam temporibus nostrum.',
            TO_DATE('2020-10-31', 'YYYY-MM-DD'), TO_DATE('2024-03-08', 'YYYY-MM-DD'), TO_DATE('2022-02-20', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (23, 23, 23, 8972, 'Nostrum dolorum ut.', 'Minima cum tempora.',
            TO_DATE('2020-05-05', 'YYYY-MM-DD'), TO_DATE('2024-09-06', 'YYYY-MM-DD'), TO_DATE('2021-03-17', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (24, 24, 24, 4832, 'Placeat alias ex.', 'Accusantium modi numquam.',
            TO_DATE('2023-10-17', 'YYYY-MM-DD'), TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2022-12-12', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (25, 25, 25, 4955, 'Debitis eum eos nobis.', 'Commodi iste ullam optio.',
            TO_DATE('2020-08-22', 'YYYY-MM-DD'), TO_DATE('2024-02-25', 'YYYY-MM-DD'), TO_DATE('2022-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (26, 26, 26, 2867, 'Sit necessitatibus nisi eum.', 'Necessitatibus corporis sed.',
            TO_DATE('2022-01-28', 'YYYY-MM-DD'), TO_DATE('2024-09-27', 'YYYY-MM-DD'), TO_DATE('2021-01-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (27, 27, 27, 2529, 'Optio suscipit odit in.', 'Illo vel sit.',
            TO_DATE('2023-06-23', 'YYYY-MM-DD'), TO_DATE('2024-01-21', 'YYYY-MM-DD'), TO_DATE('2022-03-13', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (28, 28, 28, 6902, 'Magni nostrum provident sint.', 'Iure ipsa praesentium.',
            TO_DATE('2023-05-14', 'YYYY-MM-DD'), TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2023-08-02', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (29, 29, 29, 3576, 'Illum laudantium atque.', 'Cum expedita culpa.',
            TO_DATE('2020-03-14', 'YYYY-MM-DD'), TO_DATE('2024-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-11', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (30, 30, 30, 3206, 'Eius asperiores magnam enim.', 'Nemo quis voluptatum.',
            TO_DATE('2020-07-06', 'YYYY-MM-DD'), TO_DATE('2024-10-28', 'YYYY-MM-DD'), TO_DATE('2022-08-12', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (31, 31, 31, 9672, 'In ab laudantium.', 'Quaerat unde qui.',
            TO_DATE('2022-01-12', 'YYYY-MM-DD'), TO_DATE('2023-12-02', 'YYYY-MM-DD'), TO_DATE('2021-04-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (32, 32, 32, 8131, 'Labore assumenda rem in.', 'Eos numquam enim.',
            TO_DATE('2020-10-16', 'YYYY-MM-DD'), TO_DATE('2024-04-26', 'YYYY-MM-DD'), TO_DATE('2021-03-24', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (33, 33, 33, 1989, 'Qui totam animi ipsa soluta.', 'Sequi delectus quasi.',
            TO_DATE('2020-05-13', 'YYYY-MM-DD'), TO_DATE('2024-08-13', 'YYYY-MM-DD'), TO_DATE('2022-01-09', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (34, 34, 34, 6711, 'Pariatur eaque rem sunt.', 'Quisquam saepe earum est.',
            TO_DATE('2023-04-09', 'YYYY-MM-DD'), TO_DATE('2024-02-03', 'YYYY-MM-DD'), TO_DATE('2023-08-03', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (35, 35, 35, 6677, 'Possimus odio sequi dolorem.', 'Cupiditate iure dolore.',
            TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-04-24', 'YYYY-MM-DD'), TO_DATE('2023-07-16', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (36, 36, 36, 2774, 'Nostrum fugit quos.', 'Fuga sed nobis autem.',
            TO_DATE('2020-11-03', 'YYYY-MM-DD'), TO_DATE('2024-04-15', 'YYYY-MM-DD'), TO_DATE('2022-06-20', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (37, 37, 37, 1258, 'Accusantium iure ullam.', 'Molestias debitis deleniti.',
            TO_DATE('2020-02-07', 'YYYY-MM-DD'), TO_DATE('2024-01-13', 'YYYY-MM-DD'), TO_DATE('2020-04-09', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (38, 38, 38, 8387, 'A sequi expedita eius.', 'A nobis ipsum nam.',
            TO_DATE('2021-02-20', 'YYYY-MM-DD'), TO_DATE('2024-09-26', 'YYYY-MM-DD'), TO_DATE('2020-06-07', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (39, 39, 39, 612, 'Quae aut ipsa nisi nisi.', 'Unde sint vel atque.',
            TO_DATE('2021-05-01', 'YYYY-MM-DD'), TO_DATE('2024-09-14', 'YYYY-MM-DD'), TO_DATE('2020-05-27', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (40, 40, 40, 1453, 'Quae ipsum officiis est.', 'Nam voluptatum error.',
            TO_DATE('2020-11-03', 'YYYY-MM-DD'), TO_DATE('2024-06-28', 'YYYY-MM-DD'), TO_DATE('2021-04-29', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (41, 41, 41, 2827, 'Quo consectetur alias id.', 'Consectetur facere ipsam.',
            TO_DATE('2023-05-19', 'YYYY-MM-DD'), TO_DATE('2024-03-28', 'YYYY-MM-DD'), TO_DATE('2021-06-20', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (42, 42, 42, 383, 'Distinctio ipsam laborum sed.', 'Sequi sapiente expedita odit.',
            TO_DATE('2021-09-02', 'YYYY-MM-DD'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), TO_DATE('2020-01-07', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (43, 43, 43, 620, 'Omnis commodi ipsum.', 'Nemo iusto id tempore.',
            TO_DATE('2020-08-24', 'YYYY-MM-DD'), TO_DATE('2024-01-31', 'YYYY-MM-DD'), TO_DATE('2021-05-02', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (44, 44, 44, 7304, 'Eum voluptas in nulla.', 'Voluptate dolor ex iusto.',
            TO_DATE('2022-03-01', 'YYYY-MM-DD'), TO_DATE('2023-12-20', 'YYYY-MM-DD'), TO_DATE('2021-10-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (45, 45, 45, 672, 'Veniam ab unde debitis ullam.', 'Nobis iure esse tenetur ipsa.',
            TO_DATE('2023-07-29', 'YYYY-MM-DD'), TO_DATE('2024-10-24', 'YYYY-MM-DD'), TO_DATE('2020-11-30', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (46, 46, 46, 1830, 'Numquam ducimus nulla earum.', 'Harum totam debitis.',
            TO_DATE('2021-05-06', 'YYYY-MM-DD'), TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2023-04-30', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (47, 47, 47, 6710, 'Minima quis laboriosam.', 'Nihil nemo error consequatur.',
            TO_DATE('2023-05-22', 'YYYY-MM-DD'), TO_DATE('2023-12-07', 'YYYY-MM-DD'), TO_DATE('2022-03-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (48, 48, 48, 3935, 'Magnam ex nemo officiis illo.', 'Harum enim reiciendis.',
            TO_DATE('2023-03-02', 'YYYY-MM-DD'), TO_DATE('2024-01-18', 'YYYY-MM-DD'), TO_DATE('2020-08-05', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (49, 49, 49, 8465, 'Maiores quo ex.', 'Quo deleniti voluptates enim.',
            TO_DATE('2022-08-30', 'YYYY-MM-DD'), TO_DATE('2024-06-27', 'YYYY-MM-DD'), TO_DATE('2022-10-19', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (50, 50, 50, 7908, 'Eligendi laborum nisi alias.', 'Laboriosam laboriosam qui.',
            TO_DATE('2023-05-13', 'YYYY-MM-DD'), TO_DATE('2024-06-24', 'YYYY-MM-DD'), TO_DATE('2020-03-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (51, 51, 51, 5526, 'Dolores odio fuga eius.', 'Atque illo quaerat totam ad.',
            TO_DATE('2023-03-15', 'YYYY-MM-DD'), TO_DATE('2024-02-03', 'YYYY-MM-DD'), TO_DATE('2021-10-27', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (52, 52, 52, 1502, 'A quas repellendus modi.', 'Perspiciatis sunt illum nisi.',
            TO_DATE('2020-12-24', 'YYYY-MM-DD'), TO_DATE('2024-01-11', 'YYYY-MM-DD'), TO_DATE('2023-06-04', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (53, 53, 53, 6463, 'Magni consequuntur doloribus.', 'Facere saepe quam odit.',
            TO_DATE('2020-12-16', 'YYYY-MM-DD'), TO_DATE('2024-03-27', 'YYYY-MM-DD'), TO_DATE('2020-04-07', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (54, 54, 54, 3470, 'Facilis aperiam reiciendis.', 'Perspiciatis ad totam.',
            TO_DATE('2020-06-20', 'YYYY-MM-DD'), TO_DATE('2024-08-27', 'YYYY-MM-DD'), TO_DATE('2021-09-07', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (55, 55, 55, 1937, 'Saepe et hic earum.', 'Enim vitae porro.',
            TO_DATE('2022-12-21', 'YYYY-MM-DD'), TO_DATE('2024-06-25', 'YYYY-MM-DD'), TO_DATE('2021-09-07', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (56, 56, 56, 2021, 'Fuga culpa itaque.', 'Eos quia fugit vel est.',
            TO_DATE('2021-07-14', 'YYYY-MM-DD'), TO_DATE('2024-03-29', 'YYYY-MM-DD'), TO_DATE('2020-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (57, 57, 57, 2304, 'Libero blanditiis quod.', 'Qui quis autem.',
            TO_DATE('2022-02-20', 'YYYY-MM-DD'), TO_DATE('2024-04-07', 'YYYY-MM-DD'), TO_DATE('2020-10-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (58, 58, 58, 8525, 'Sint recusandae nesciunt est.', 'Ad ex quisquam ratione.',
            TO_DATE('2020-09-10', 'YYYY-MM-DD'), TO_DATE('2024-01-22', 'YYYY-MM-DD'), TO_DATE('2023-02-20', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (59, 59, 59, 1768, 'Porro magnam nobis nisi.', 'Beatae iusto saepe.',
            TO_DATE('2021-01-31', 'YYYY-MM-DD'), TO_DATE('2024-10-13', 'YYYY-MM-DD'), TO_DATE('2020-08-19', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (60, 60, 60, 4463, 'Ipsa nostrum nulla.', 'Sit beatae quis sed.',
            TO_DATE('2021-08-28', 'YYYY-MM-DD'), TO_DATE('2024-06-18', 'YYYY-MM-DD'), TO_DATE('2021-04-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (61, 61, 61, 3992, 'Expedita voluptatum at eius.', 'Deserunt iusto asperiores.',
            TO_DATE('2021-09-12', 'YYYY-MM-DD'), TO_DATE('2024-06-23', 'YYYY-MM-DD'), TO_DATE('2022-04-12', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (62, 62, 62, 9391, 'A animi doloribus facilis.', 'Expedita at eligendi at.',
            TO_DATE('2020-01-11', 'YYYY-MM-DD'), TO_DATE('2024-07-19', 'YYYY-MM-DD'), TO_DATE('2021-08-19', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (63, 63, 63, 7344, 'Earum dicta earum.', 'Rerum dicta sint vero.',
            TO_DATE('2021-10-09', 'YYYY-MM-DD'), TO_DATE('2024-10-02', 'YYYY-MM-DD'), TO_DATE('2021-01-22', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (64, 64, 64, 3947, 'Hic dolores ratione.', 'Amet quos maxime a.',
            TO_DATE('2022-03-13', 'YYYY-MM-DD'), TO_DATE('2024-05-12', 'YYYY-MM-DD'), TO_DATE('2020-12-23', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (65, 65, 65, 752, 'Numquam cum aperiam odit.', 'Vitae deserunt velit quia.',
            TO_DATE('2022-03-14', 'YYYY-MM-DD'), TO_DATE('2024-06-13', 'YYYY-MM-DD'), TO_DATE('2020-08-27', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (66, 66, 66, 5506, 'Et quae aspernatur quam.', 'Tempore omnis corporis sit.',
            TO_DATE('2023-09-02', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), TO_DATE('2021-03-23', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (67, 67, 67, 1240, 'Ex sequi id nemo iure quasi.', 'Est ut optio nihil expedita.',
            TO_DATE('2021-05-22', 'YYYY-MM-DD'), TO_DATE('2024-05-09', 'YYYY-MM-DD'), TO_DATE('2020-06-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (68, 68, 68, 8862, 'Adipisci ex ipsam modi.', 'Vel soluta suscipit vel.',
            TO_DATE('2023-08-12', 'YYYY-MM-DD'), TO_DATE('2024-03-01', 'YYYY-MM-DD'), TO_DATE('2022-10-26', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (69, 69, 69, 4480, 'Ratione laborum recusandae.', 'Ad nisi sunt sequi minus.',
            TO_DATE('2021-07-20', 'YYYY-MM-DD'), TO_DATE('2024-11-16', 'YYYY-MM-DD'), TO_DATE('2022-08-12', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (70, 70, 70, 6643, 'Voluptas ipsa necessitatibus.', 'Eos fuga tempora.',
            TO_DATE('2022-09-06', 'YYYY-MM-DD'), TO_DATE('2024-05-19', 'YYYY-MM-DD'), TO_DATE('2021-07-13', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (71, 71, 71, 5246, 'Blanditiis sit consequuntur.', 'Cum sapiente ipsam vel.',
            TO_DATE('2023-10-12', 'YYYY-MM-DD'), TO_DATE('2024-11-05', 'YYYY-MM-DD'), TO_DATE('2022-01-13', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (72, 72, 72, 1100, 'Aut ratione ipsum quod.', 'Atque mollitia magni.',
            TO_DATE('2022-10-04', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), TO_DATE('2021-04-20', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (73, 73, 73, 73, 'Laboriosam aliquam at nam.', 'Sint veniam magni.',
            TO_DATE('2020-02-26', 'YYYY-MM-DD'), TO_DATE('2023-12-04', 'YYYY-MM-DD'), TO_DATE('2022-12-25', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (74, 74, 74, 1706, 'Quod expedita neque quia sit.', 'Cupiditate minus provident.',
            TO_DATE('2022-08-21', 'YYYY-MM-DD'), TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_DATE('2022-03-29', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (75, 75, 75, 7270, 'Repudiandae dolorem aperiam.', 'Repellendus tempora quis.',
            TO_DATE('2020-10-22', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), TO_DATE('2021-03-11', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (76, 76, 76, 1556, 'Quos pariatur facere fugit.', 'Rem aspernatur sint.',
            TO_DATE('2022-03-14', 'YYYY-MM-DD'), TO_DATE('2023-12-28', 'YYYY-MM-DD'), TO_DATE('2022-12-30', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (77, 77, 77, 400, 'Est unde voluptas illum nam.', 'Labore officia a delectus.',
            TO_DATE('2023-05-05', 'YYYY-MM-DD'), TO_DATE('2023-11-28', 'YYYY-MM-DD'), TO_DATE('2021-05-09', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (78, 78, 78, 7741, 'Aut repellat neque.', 'Quas vitae illum.',
            TO_DATE('2020-06-30', 'YYYY-MM-DD'), TO_DATE('2024-08-23', 'YYYY-MM-DD'), TO_DATE('2020-05-15', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (79, 79, 79, 1119, 'Sint quas sint error.', 'Odio amet molestias.',
            TO_DATE('2020-01-16', 'YYYY-MM-DD'), TO_DATE('2024-07-22', 'YYYY-MM-DD'), TO_DATE('2021-05-06', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (80, 80, 80, 7440, 'Explicabo nobis cupiditate.', 'Ex nisi minus velit eveniet.',
            TO_DATE('2020-02-28', 'YYYY-MM-DD'), TO_DATE('2024-02-16', 'YYYY-MM-DD'), TO_DATE('2020-01-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (81, 81, 81, 7293, 'Magni error accusantium.', 'Suscipit vitae quidem iste.',
            TO_DATE('2020-07-05', 'YYYY-MM-DD'), TO_DATE('2024-02-02', 'YYYY-MM-DD'), TO_DATE('2021-03-04', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (82, 82, 82, 8649, 'Omnis a maiores enim id.', 'Non fugit a rem deserunt.',
            TO_DATE('2021-06-30', 'YYYY-MM-DD'), TO_DATE('2024-04-26', 'YYYY-MM-DD'), TO_DATE('2020-10-14', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (83, 83, 83, 6410, 'Dignissimos eius sapiente.', 'Suscipit similique nam optio.',
            TO_DATE('2021-09-26', 'YYYY-MM-DD'), TO_DATE('2024-09-17', 'YYYY-MM-DD'), TO_DATE('2021-05-27', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (84, 84, 84, 3881, 'Ab at itaque sit accusamus.', 'Quod magnam atque beatae.',
            TO_DATE('2022-08-18', 'YYYY-MM-DD'), TO_DATE('2024-04-12', 'YYYY-MM-DD'), TO_DATE('2020-11-03', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (85, 85, 85, 7525, 'Ad placeat accusantium.', 'Saepe quam minus.',
            TO_DATE('2023-07-06', 'YYYY-MM-DD'), TO_DATE('2024-09-08', 'YYYY-MM-DD'), TO_DATE('2023-03-31', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (86, 86, 86, 3756, 'Amet iste illum voluptate.', 'Deleniti adipisci similique.',
            TO_DATE('2021-04-28', 'YYYY-MM-DD'), TO_DATE('2024-11-16', 'YYYY-MM-DD'), TO_DATE('2020-08-18', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (87, 87, 87, 4785, 'Enim iure similique fugiat.', 'Repudiandae error expedita.',
            TO_DATE('2021-10-22', 'YYYY-MM-DD'), TO_DATE('2023-12-01', 'YYYY-MM-DD'), TO_DATE('2021-12-11', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (88, 88, 88, 2427, 'Deserunt adipisci esse ipsum.', 'Quos aspernatur aperiam hic.',
            TO_DATE('2022-11-18', 'YYYY-MM-DD'), TO_DATE('2023-11-26', 'YYYY-MM-DD'), TO_DATE('2020-11-08', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (89, 89, 89, 5827, 'A porro blanditiis delectus.', 'Optio assumenda sapiente.',
            TO_DATE('2021-02-01', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD'), TO_DATE('2020-06-03', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (90, 90, 90, 4806, 'Ducimus unde illum quibusdam.', 'Quos quae corporis.',
            TO_DATE('2020-03-15', 'YYYY-MM-DD'), TO_DATE('2024-04-05', 'YYYY-MM-DD'), TO_DATE('2022-12-24', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (91, 91, 91, 990, 'Totam maiores maiores.', 'Beatae excepturi aut ab ad.',
            TO_DATE('2020-09-15', 'YYYY-MM-DD'), TO_DATE('2024-01-14', 'YYYY-MM-DD'), TO_DATE('2020-04-30', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (92, 92, 92, 1852, 'Commodi quaerat odio aut.', 'Laboriosam harum soluta.',
            TO_DATE('2020-02-07', 'YYYY-MM-DD'), TO_DATE('2024-07-17', 'YYYY-MM-DD'), TO_DATE('2023-04-21', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (93, 93, 93, 4394, 'Rerum autem inventore vel.', 'Nam itaque veniam nemo nam.',
            TO_DATE('2021-11-19', 'YYYY-MM-DD'), TO_DATE('2024-09-03', 'YYYY-MM-DD'), TO_DATE('2023-10-23', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (94, 94, 94, 7304, 'Quo porro ipsam.', 'Iste ad fugit sunt.',
            TO_DATE('2023-10-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), TO_DATE('2020-05-10', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (95, 95, 95, 5161, 'Beatae accusamus autem magni.', 'Quas fuga blanditiis quaerat.',
            TO_DATE('2023-04-04', 'YYYY-MM-DD'), TO_DATE('2024-09-26', 'YYYY-MM-DD'), TO_DATE('2023-08-01', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (96, 96, 96, 6603, 'Repellat necessitatibus aut.', 'Eius consectetur repellendus.',
            TO_DATE('2023-11-07', 'YYYY-MM-DD'), TO_DATE('2024-06-24', 'YYYY-MM-DD'), TO_DATE('2022-10-18', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (97, 97, 97, 2701, 'Nulla id numquam totam.', 'Dolores accusamus alias.',
            TO_DATE('2020-01-29', 'YYYY-MM-DD'), TO_DATE('2024-05-11', 'YYYY-MM-DD'), TO_DATE('2021-09-05', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (98, 98, 98, 8629, 'Quos earum illum.', 'Sit fugit ut quam.',
            TO_DATE('2023-03-30', 'YYYY-MM-DD'), TO_DATE('2024-06-29', 'YYYY-MM-DD'), TO_DATE('2023-10-06', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (99, 99, 99, 2067, 'Beatae hic iure odit.', 'Corporis porro fugiat.',
            TO_DATE('2023-04-12', 'YYYY-MM-DD'), TO_DATE('2024-01-07', 'YYYY-MM-DD'), TO_DATE('2023-02-12', 'YYYY-MM-DD'));


    INSERT INTO tg_endereco_usuario (id_endereco, id_logradouro, id_usuario, nr_logradouro, ds_complemento, ds_ponto_ref, dt_inicio, dt_fim, dt_cadastro)
    VALUES (100, 100, 100, 8720, 'Itaque delectus saepe.', 'Omnis dolorum corrupti sit.',
            TO_DATE('2022-11-28', 'YYYY-MM-DD'), TO_DATE('2024-05-10', 'YYYY-MM-DD'), TO_DATE('2020-09-26', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (1, 1, 675, 27, 652353409, 'Celular', 'A', TO_DATE('2020-08-03', 'YYYY-MM-DD'));
    

    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (2, 2, 307, 58, 475680253, 'Comercial', 'A', TO_DATE('2023-05-30', 'YYYY-MM-DD'));
    

    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (3, 3, 497, 22, 918077506, 'Comercial', 'A', TO_DATE('2020-09-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (4, 4, 911, 83, 210049347, 'Comercial', 'I', TO_DATE('2021-08-24', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (5, 5, 230, 77, 956251838, 'Comercial', 'A', TO_DATE('2023-10-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (6, 6, 396, 94, 904289180, 'Celular', 'I', TO_DATE('2023-08-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (7, 7, 298, 68, 69583931, 'Comercial', 'I', TO_DATE('2021-02-08', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (8, 8, 280, 94, 348672596, 'Celular', 'A', TO_DATE('2021-01-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (9, 9, 734, 29, 215553899, 'Celular', 'A', TO_DATE('2021-11-02', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (10, 10, 977, 96, 3295688, 'Residencial', 'I', TO_DATE('2023-08-19', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (11, 11, 545, 74, 964477147, 'Comercial', 'I', TO_DATE('2021-08-26', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (12, 12, 752, 43, 908958768, 'Residencial', 'I', TO_DATE('2020-04-17', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (13, 13, 82, 52, 438217211, 'Celular', 'A', TO_DATE('2021-05-28', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (14, 14, 870, 8, 377653641, 'Residencial', 'A', TO_DATE('2023-10-04', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (15, 15, 504, 8, 459467396, 'Residencial', 'I', TO_DATE('2022-06-01', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (16, 16, 955, 90, 503241181, 'Comercial', 'A', TO_DATE('2023-07-04', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (17, 17, 309, 15, 601028291, 'Celular', 'I', TO_DATE('2021-02-19', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (18, 18, 745, 99, 585149082, 'Comercial', 'A', TO_DATE('2021-07-10', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (19, 19, 327, 89, 389998412, 'Celular', 'I', TO_DATE('2022-11-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (20, 20, 462, 43, 1408080, 'Residencial', 'A', TO_DATE('2023-01-18', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (21, 21, 353, 10, 671161725, 'Celular', 'I', TO_DATE('2022-07-14', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (22, 22, 774, 13, 452783679, 'Residencial', 'A', TO_DATE('2023-04-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (23, 23, 429, 58, 451992808, 'Residencial', 'A', TO_DATE('2020-07-28', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (24, 24, 427, 98, 476497063, 'Residencial', 'A', TO_DATE('2023-03-16', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (25, 25, 767, 31, 495349363, 'Residencial', 'I', TO_DATE('2020-04-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (26, 26, 571, 70, 348838143, 'Comercial', 'A', TO_DATE('2022-10-03', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (27, 27, 508, 4, 919677043, 'Celular', 'A', TO_DATE('2022-12-05', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (28, 28, 901, 54, 505944493, 'Comercial', 'I', TO_DATE('2020-08-14', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (29, 29, 756, 40, 521296665, 'Residencial', 'A', TO_DATE('2022-12-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (30, 30, 820, 43, 824132149, 'Residencial', 'I', TO_DATE('2023-10-02', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (31, 31, 865, 55, 957188748, 'Residencial', 'A', TO_DATE('2022-01-30', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (32, 32, 299, 24, 643194581, 'Comercial', 'A', TO_DATE('2022-11-18', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (33, 33, 134, 80, 783891572, 'Comercial', 'A', TO_DATE('2023-09-28', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (34, 34, 41, 30, 232677975, 'Residencial', 'I', TO_DATE('2020-12-21', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (35, 35, 834, 59, 116409233, 'Residencial', 'A', TO_DATE('2023-10-15', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (36, 36, 116, 50, 26495694, 'Residencial', 'I', TO_DATE('2021-08-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (37, 37, 146, 30, 728285827, 'Comercial', 'I', TO_DATE('2022-04-17', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (38, 38, 634, 94, 563349257, 'Residencial', 'I', TO_DATE('2023-05-11', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (39, 39, 240, 25, 612449108, 'Comercial', 'A', TO_DATE('2021-09-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (40, 40, 326, 69, 685933996, 'Celular', 'I', TO_DATE('2020-09-30', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (41, 41, 441, 31, 493000733, 'Comercial', 'I', TO_DATE('2022-11-02', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (42, 42, 91, 31, 848998045, 'Residencial', 'I', TO_DATE('2023-01-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (43, 43, 405, 4, 294252978, 'Comercial', 'I', TO_DATE('2020-03-08', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (44, 44, 628, 6, 619093018, 'Celular', 'A', TO_DATE('2020-03-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (45, 45, 893, 56, 479672575, 'Comercial', 'I', TO_DATE('2020-04-17', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (46, 46, 652, 78, 238042718, 'Residencial', 'A', TO_DATE('2021-05-03', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (47, 47, 547, 53, 524663910, 'Celular', 'A', TO_DATE('2022-08-03', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (48, 48, 721, 76, 856504133, 'Residencial', 'A', TO_DATE('2023-09-20', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (49, 49, 305, 79, 213543665, 'Comercial', 'I', TO_DATE('2021-12-25', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (50, 50, 759, 92, 194367623, 'Celular', 'I', TO_DATE('2021-03-02', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (51, 51, 988, 53, 120727478, 'Residencial', 'I', TO_DATE('2021-02-15', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (52, 52, 129, 66, 538625998, 'Celular', 'I', TO_DATE('2023-09-20', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (53, 53, 913, 92, 648900873, 'Residencial', 'I', TO_DATE('2023-06-15', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (54, 54, 82, 72, 651449239, 'Celular', 'A', TO_DATE('2023-03-04', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (55, 55, 519, 58, 864276799, 'Celular', 'A', TO_DATE('2021-03-23', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (56, 56, 759, 98, 170944577, 'Comercial', 'A', TO_DATE('2023-03-12', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (57, 57, 96, 51, 583182268, 'Comercial', 'A', TO_DATE('2020-05-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (58, 58, 902, 75, 805445326, 'Residencial', 'I', TO_DATE('2021-10-31', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (59, 59, 750, 56, 228097325, 'Residencial', 'A', TO_DATE('2021-09-03', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (60, 60, 359, 92, 624588988, 'Celular', 'A', TO_DATE('2020-03-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (61, 61, 757, 68, 375206667, 'Residencial', 'I', TO_DATE('2023-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (62, 62, 578, 10, 162640484, 'Residencial', 'I', TO_DATE('2023-06-18', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (63, 63, 984, 51, 21152469, 'Celular', 'I', TO_DATE('2020-05-30', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (64, 64, 808, 40, 146156817, 'Celular', 'I', TO_DATE('2020-07-20', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (65, 65, 159, 38, 152524809, 'Comercial', 'I', TO_DATE('2022-04-03', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (66, 66, 459, 87, 607951525, 'Residencial', 'I', TO_DATE('2022-03-15', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (67, 67, 710, 43, 303926299, 'Residencial', 'A', TO_DATE('2022-11-01', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (68, 68, 616, 76, 543010335, 'Celular', 'A', TO_DATE('2020-06-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (69, 69, 381, 12, 503978573, 'Residencial', 'I', TO_DATE('2022-06-11', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (70, 70, 728, 97, 308083570, 'Celular', 'A', TO_DATE('2022-01-27', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (71, 71, 441, 3, 502259707, 'Celular', 'I', TO_DATE('2020-11-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (72, 72, 68, 16, 666998445, 'Comercial', 'A', TO_DATE('2021-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (73, 73, 215, 75, 411366463, 'Celular', 'I', TO_DATE('2020-03-30', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (74, 74, 328, 14, 475809655, 'Residencial', 'I', TO_DATE('2020-11-06', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (75, 75, 10, 9, 389754264, 'Comercial', 'I', TO_DATE('2022-03-04', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (76, 76, 867, 98, 748125895, 'Comercial', 'A', TO_DATE('2021-03-11', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (77, 77, 308, 42, 330579087, 'Comercial', 'A', TO_DATE('2021-03-05', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (78, 78, 993, 43, 761051121, 'Celular', 'A', TO_DATE('2020-02-26', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (79, 79, 119, 87, 352861897, 'Comercial', 'I', TO_DATE('2020-04-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (80, 80, 738, 84, 444897571, 'Celular', 'A', TO_DATE('2023-03-15', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (81, 81, 601, 18, 824201048, 'Residencial', 'I', TO_DATE('2023-06-13', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (82, 82, 921, 54, 218106382, 'Celular', 'I', TO_DATE('2021-11-02', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (83, 83, 709, 31, 200162021, 'Comercial', 'A', TO_DATE('2021-10-17', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (84, 84, 356, 43, 916624000, 'Residencial', 'A', TO_DATE('2021-10-08', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (85, 85, 261, 76, 998731155, 'Comercial', 'A', TO_DATE('2023-03-04', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (86, 86, 825, 90, 72491021, 'Comercial', 'A', TO_DATE('2022-08-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (87, 87, 156, 18, 478702272, 'Comercial', 'I', TO_DATE('2023-05-22', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (88, 88, 87, 30, 629567508, 'Comercial', 'A', TO_DATE('2023-11-19', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (89, 89, 730, 82, 92459521, 'Comercial', 'A', TO_DATE('2023-11-17', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (90, 90, 156, 83, 445063045, 'Celular', 'A', TO_DATE('2023-08-20', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (91, 91, 179, 99, 299824741, 'Residencial', 'A', TO_DATE('2021-12-24', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (92, 92, 276, 73, 585697967, 'Residencial', 'I', TO_DATE('2021-11-26', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (93, 93, 534, 87, 719148566, 'Residencial', 'I', TO_DATE('2023-07-15', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (94, 94, 758, 67, 983499520, 'Residencial', 'A', TO_DATE('2023-04-09', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (95, 95, 514, 11, 385317309, 'Residencial', 'I', TO_DATE('2023-07-24', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (96, 96, 701, 48, 465807984, 'Celular', 'A', TO_DATE('2020-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (97, 97, 964, 96, 501180125, 'Celular', 'A', TO_DATE('2022-09-24', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (98, 98, 878, 35, 880534754, 'Celular', 'I', TO_DATE('2021-08-07', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (99, 99, 926, 98, 695554088, 'Residencial', 'I', TO_DATE('2021-01-22', 'YYYY-MM-DD'));


    INSERT INTO tg_telefone_usuario (id_telefone, id_usuario, nr_ddi, nr_ddd, nr_telefone, tp_telefone, st_telefone, dt_cadastro)
    VALUES (100, 100, 899, 52, 124321219, 'Residencial', 'I', TO_DATE('2022-11-08', 'YYYY-MM-DD'));



    -- inserindo o tipo de contato 


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (1, 'Residencial', TO_DATE('2021-07-04', 'YYYY-MM-DD'), TO_DATE('2024-04-04', 'YYYY-MM-DD'), TO_DATE('2022-09-25', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (2, 'Celular', TO_DATE('2023-04-04', 'YYYY-MM-DD'), TO_DATE('2024-04-13', 'YYYY-MM-DD'), TO_DATE('2022-08-05', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (3, 'E-mail Pessoal', TO_DATE('2021-07-18', 'YYYY-MM-DD'), TO_DATE('2022-05-31', 'YYYY-MM-DD'), TO_DATE('2021-05-05', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (4, 'E-mail Profissional', TO_DATE('2022-04-18', 'YYYY-MM-DD'), TO_DATE('2023-04-17', 'YYYY-MM-DD'), TO_DATE('2021-02-28', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (5, 'WhatsApp', TO_DATE('2020-04-05', 'YYYY-MM-DD'), TO_DATE('2022-07-21', 'YYYY-MM-DD'), TO_DATE('2023-05-12', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (6, 'Skype', TO_DATE('2020-09-22', 'YYYY-MM-DD'), TO_DATE('2022-05-19', 'YYYY-MM-DD'), TO_DATE('2022-07-16', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (7, 'Telegram', TO_DATE('2021-05-03', 'YYYY-MM-DD'), TO_DATE('2023-05-25', 'YYYY-MM-DD'), TO_DATE('2023-09-24', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (8, 'fax', TO_DATE('2023-02-26', 'YYYY-MM-DD'), TO_DATE('2023-09-28', 'YYYY-MM-DD'), TO_DATE('2020-06-28', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (9, 'Linkedin', TO_DATE('2020-06-09', 'YYYY-MM-DD'), TO_DATE('2023-09-23', 'YYYY-MM-DD'), TO_DATE('2021-11-06', 'YYYY-MM-DD'));


    INSERT INTO tg_tipo_contato (id_tipo, nm_tipo, dt_inico, dt_fim, dt_cadastro)
    VALUES (10, 'Twitter', TO_DATE('2020-10-19', 'YYYY-MM-DD'), TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-07-07', 'YYYY-MM-DD'));


-- tipos de tg_contato_usuario




INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (1, 1, 1, 'pariatur', 776, 307, 1091466318, TO_DATE('2022-12-17', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (2, 2, 2, 'labore', 396, 282, 6330743183, TO_DATE('2021-04-10', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
 VALUES (3, 3, 3, 'mãe', 702, 576, 7591999049, TO_DATE('2020-03-19', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (4, 4, 4, 'ullam', 944, 731, 4001771743, TO_DATE('2022-09-09', 'YYYY-MM-DD'));

INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (5, 5, 5, 'optio', 617, 426, 5416416940, TO_DATE('2021-01-10', 'YYYY-MM-DD'));


INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
VALUES (6, 6, 6, 'aperiam', 243, 271, 1750714313, TO_DATE('2023-02-16', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (7, 7, 7, 'asperiores', 782, 466, 6329430296, TO_DATE('2020-11-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (8, 8, 8, 'in', 606, 978, 5114840316, TO_DATE('2023-05-26', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (9, 9, 9, 'iste', 361, 822, 2920283648, TO_DATE('2023-02-09', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (10, 10, 10, 'omnis', 211, 799, 6776773068, TO_DATE('2023-05-28', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (11, 11, 11, 'irmão', 443, 419, 6010771419, TO_DATE('2022-12-08', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (12, 12, 12, 'hic', 378, 195, 1891831724, TO_DATE('2022-02-12', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (13, 13, 13, 'cum', 554, 397, 4048285258, TO_DATE('2020-08-04', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (14, 14, 14, 'veniam', 837, 886, 4666279550, TO_DATE('2023-11-03', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (15, 15, 15, 'aut', 319, 836, 8645701438, TO_DATE('2022-06-14', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (16, 16, 16, 'veniam', 842, 388, 2371727590, TO_DATE('2023-04-09', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (17, 17, 17, 'natus', 739, 466, 6948714220, TO_DATE('2022-12-31', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (18, 18, 18, 'ratione', 220, 347, 4257781715, TO_DATE('2020-10-23', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (19, 19, 19, 'quo', 953, 653, 2542747112, TO_DATE('2021-12-03', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (20, 20, 20, 'labore', 922, 614, 8741008776, TO_DATE('2022-02-23', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (21, 21, 21, 'dicta', 555, 777, 7446006980, TO_DATE('2020-03-25', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (22, 22, 22, 'consequuntur', 377, 922, 2704562305, TO_DATE('2022-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (23, 23, 23, 'irmã', 284, 862, 5081398114, TO_DATE('2023-05-24', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (24, 24, 24, 'earum', 535, 466, 1432573682, TO_DATE('2022-08-31', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (25, 25, 25, 'enim', 976, 652, 7781972779, TO_DATE('2021-11-11', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (26, 26, 26, 'tempore', 543, 704, 8332444701, TO_DATE('2023-08-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (27, 27, 27, 'architecto', 640, 320, 3377452183, TO_DATE('2023-07-29', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (28, 28, 28, 'outros', 428, 516, 6002816523, TO_DATE('2021-03-21', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (29, 29, 29, 'voluptatum', 702, 360, 6885365793, TO_DATE('2022-11-07', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (30, 30, 30, 'veritatis', 495, 673, 1754514779, TO_DATE('2020-11-06', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (31, 31, 31, 'tempora', 121, 511, 1713620495, TO_DATE('2023-01-06', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (32, 32, 32, 'itaque', 520, 337, 7253891520, TO_DATE('2020-04-30', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (33, 33, 33, 'nesciunt', 725, 553, 6391503729, TO_DATE('2021-12-23', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (34, 34, 34, 'illum', 784, 842, 8890024388, TO_DATE('2023-11-04', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (35, 35, 35, 'tempora', 774, 144, 5893602699, TO_DATE('2021-08-25', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (36, 36, 36, 'ipsum', 687, 378, 1550989918, TO_DATE('2020-01-28', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (37, 37, 37, 'enim', 868, 759, 3353604340, TO_DATE('2021-07-01', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (38, 38, 38, 'harum', 833, 591, 4697346286, TO_DATE('2022-12-24', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (39, 39, 39, 'possimus', 680, 133, 2640690495, TO_DATE('2023-06-05', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (40, 40, 40, 'irmã', 861, 217, 4424623654, TO_DATE('2022-04-27', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (41, 41, 41, 'esse', 503, 396, 9819344947, TO_DATE('2020-10-01', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (42, 42, 42, 'cupiditate', 984, 244, 8755042012, TO_DATE('2021-12-02', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (43, 43, 43, 'est', 386, 482, 2037884860, TO_DATE('2020-06-19', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (44, 44, 44, 'quo', 590, 725, 1406474893, TO_DATE('2020-02-29', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (45, 45, 45, 'commodi', 961, 154, 1408590695, TO_DATE('2020-04-29', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (46, 46, 46, 'soluta', 348, 440, 2765836294, TO_DATE('2020-10-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (47, 47, 47, 'quia', 288, 332, 6820171860, TO_DATE('2022-03-22', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (48, 48, 48, 'cum', 727, 114, 1492163872, TO_DATE('2021-07-18', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (49, 49, 49, 'reprehenderit', 963, 933, 5325847647, TO_DATE('2023-02-12', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (50, 50, 50, 'tempora', 604, 381, 3778605776, TO_DATE('2020-02-27', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (51, 51, 51, 'quidem', 464, 926, 9097721071, TO_DATE('2022-08-04', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (52, 52, 52, 'repudiandae', 709, 530, 3379530937, TO_DATE('2022-06-24', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (53, 53, 53, 'error', 247, 206, 7145605078, TO_DATE('2022-11-01', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (54, 54, 54, 'fugit', 136, 778, 8042058862, TO_DATE('2021-05-13', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (55, 55, 55, 'dolore', 847, 321, 3464841120, TO_DATE('2022-06-23', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (56, 56, 56, 'in', 801, 298, 7379968705, TO_DATE('2021-09-05', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (57, 57, 57, 'id', 873, 593, 9238387831, TO_DATE('2023-01-23', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (58, 58, 58, 'pai', 723, 684, 7538891511, TO_DATE('2021-04-15', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (59, 59, 59, 'nulla', 780, 289, 5826998298, TO_DATE('2021-12-05', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (60, 60, 60, 'sint', 171, 776, 2667859856, TO_DATE('2022-07-03', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (61, 61, 61, 'minus', 382, 562, 9182214202, TO_DATE('2023-06-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (62, 62, 62, 'odit', 987, 359, 8155970395, TO_DATE('2023-06-19', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (63, 63, 63, 'occaecati', 895, 846, 7135828333, TO_DATE('2023-10-22', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (64, 64, 64, 'sequi', 729, 607, 2749788631, TO_DATE('2023-08-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (65, 65, 65, 'molestias', 134, 544, 7083709970, TO_DATE('2022-02-07', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (66, 66, 66, 'irmã', 258, 478, 2330571807, TO_DATE('2021-07-14', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (67, 67, 67, 'aut', 894, 404, 1451600323, TO_DATE('2022-01-06', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (68, 68, 68, 'unde', 410, 113, 4073679103, TO_DATE('2020-02-28', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (69, 69, 69, 'nam', 497, 789, 1220474530, TO_DATE('2020-02-03', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (70, 70, 70, 'earum', 919, 412, 9056787954, TO_DATE('2023-01-28', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (71, 71, 71, 'rerum', 625, 643, 1855510027, TO_DATE('2022-02-18', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (72, 72, 72, 'magnam', 681, 943, 2358588626, TO_DATE('2020-11-17', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (73, 73, 73, 'et', 391, 106, 1333474885, TO_DATE('2023-10-02', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (74, 74, 74, 'ratione', 347, 578, 6861614321, TO_DATE('2023-02-05', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (75, 75, 75, 'perferendis', 845, 839, 8318690115, TO_DATE('2023-08-11', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (76, 76, 76, 'ipsum', 267, 628, 6499482455, TO_DATE('2023-06-14', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (77, 77, 77, 'dolor', 422, 704, 4474258225, TO_DATE('2021-06-23', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (78, 78, 78, 'tempora', 260, 932, 6691157273, TO_DATE('2023-09-15', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (79, 79, 79, 'quos', 723, 652, 1188636701, TO_DATE('2021-11-07', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (80, 80, 80, 'atque', 202, 106, 9298763115, TO_DATE('2021-05-21', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (81, 81, 81, 'fuga', 453, 930, 3252359917, TO_DATE('2021-02-25', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (82, 82, 82, 'cupiditate', 915, 585, 1271923362, TO_DATE('2022-08-13', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (83, 83, 83, 'veniam', 609, 155, 1988811580, TO_DATE('2022-09-21', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (84, 84, 84, 'possimus', 328, 980, 4632084014, TO_DATE('2023-09-15', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (85, 85, 85, 'dolores', 389, 142, 2919461223, TO_DATE('2022-04-19', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (86, 86, 86, 'ratione', 991, 131, 6986749525, TO_DATE('2021-05-09', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (87, 87, 87, 'facere', 854, 235, 4645892293, TO_DATE('2023-02-15', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (88, 88, 88, 'nemo', 269, 138, 8176579884, TO_DATE('2020-10-16', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (89, 89, 89, 'irmã', 828, 378, 1810046929, TO_DATE('2022-02-25', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (90, 90, 90, 'veritatis', 613, 875, 4575565361, TO_DATE('2020-08-31', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (91, 91, 91, 'hic', 483, 122, 6929120482, TO_DATE('2023-09-09', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (92, 92, 92, 'molestias', 960, 223, 5515872912, TO_DATE('2021-09-30', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (93, 93, 93, 'non', 239, 988, 3615433218, TO_DATE('2020-06-07', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (94, 94, 94, 'repudiandae', 470, 266, 3993704820, TO_DATE('2022-10-10', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (95, 95, 95, 'eveniet', 256, 121, 6879940500, TO_DATE('2023-08-28', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (96, 96, 96, 'molestias', 732, 615, 3178536221, TO_DATE('2021-01-18', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (97, 97, 97, 'expedita', 231, 507, 2684497026, TO_DATE('2023-05-26', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (98, 98, 98, 'fugiat', 591, 584, 2649916978, TO_DATE('2022-12-22', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (99, 99, 99, 'nulla', 161, 692, 2606780130, TO_DATE('2020-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_contato_usuario (id_contato, id_usuario, id_tipo, nm_contato, nr_ddi, nr_ddd, nr_telefone, dt_cadastro)
    VALUES (100, 100, 100, 'saepe', 256, 271, 5500218325, TO_DATE('2021-11-05', 'YYYY-MM-DD'));


    -- inserindo as noticias 



    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (1, 'Accusamus porro ratione.', 'Hic accusamus esse fugit consequuntur perferendis cupiditate sapiente.', TO_DATE('2020-07-12', 'YYYY-MM-DD'), 'https://picsum.photos/140/537', 'https://da.com/');
    

    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (2, 'Unde ut consequuntur accusantium eum veniam.', 'Aliquid exercitationem corporis debitis nam doloribus modi natus minus minus quasi doloribus.', TO_DATE('2023-04-26', 'YYYY-MM-DD'), 'https://dummyimage.com/591x107', 'http://freitas.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (3, 'Sequi provident quae reprehenderit.', 'Nisi hic aut beatae cum odio.', TO_DATE('2021-09-19', 'YYYY-MM-DD'), 'https://picsum.photos/839/32', 'https://www.nunes.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (4, 'Illum quibusdam ad.', 'Explicabo illum quidem quas consectetur mollitia.', TO_DATE('2021-10-23', 'YYYY-MM-DD'), 'https://dummyimage.com/862x206', 'https://www.da.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (5, 'Laudantium fugiat rerum doloremque quas reprehenderit provident.', 'Harum error vel laboriosam dolor non dolores.', TO_DATE('2021-03-11', 'YYYY-MM-DD'), 'https://placekitten.com/459/529', 'http://www.silveira.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (6, 'Dolorum unde voluptates nihil quos voluptatibus soluta.', 'Eos aliquam atque ipsa iste itaque neque eligendi eaque.', TO_DATE('2021-09-30', 'YYYY-MM-DD'), 'https://placekitten.com/308/180', 'http://fernandes.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (7, 'Dicta accusamus sapiente hic nulla modi.', 'Ipsam molestiae dignissimos qui velit incidunt cupiditate eius expedita fuga tenetur illum.', TO_DATE('2023-06-02', 'YYYY-MM-DD'), 'https://dummyimage.com/287x113', 'https://costela.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (8, 'Expedita expedita hic modi debitis.', 'Commodi molestias nemo ipsam molestias in labore.', TO_DATE('2021-07-07', 'YYYY-MM-DD'), 'https://picsum.photos/675/791', 'https://www.cardoso.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (9, 'Dolorem temporibus quo modi saepe nihil.', 'Architecto voluptas tempora soluta sit veniam eveniet quos nulla ducimus.', TO_DATE('2021-08-06', 'YYYY-MM-DD'), 'https://placekitten.com/280/475', 'https://aragao.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (10, 'Magni deleniti quia voluptate minus culpa placeat nulla.', 'Quos nostrum iusto ab nam accusantium beatae dicta praesentium.', TO_DATE('2023-10-14', 'YYYY-MM-DD'), 'https://dummyimage.com/424x355', 'https://das.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (11, 'Sed consequuntur vel aliquid perferendis doloribus.', 'Laborum repudiandae unde veritatis hic quam veritatis officiis.', TO_DATE('2023-10-10', 'YYYY-MM-DD'), 'https://picsum.photos/605/249', 'https://porto.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (12, 'Consequatur dicta assumenda voluptatum cumque.', 'Sit consequuntur nihil ab vel ea alias nemo cum quod magnam exercitationem.', TO_DATE('2022-07-19', 'YYYY-MM-DD'), 'https://dummyimage.com/703x927', 'http://caldeira.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (13, 'Fugit quos iusto magni quaerat.', 'Nemo beatae deleniti voluptate placeat repudiandae itaque.', TO_DATE('2023-05-18', 'YYYY-MM-DD'), 'https://placekitten.com/71/107', 'http://www.da.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (14, 'Incidunt ad soluta nisi consequuntur.', 'Accusantium rerum architecto libero perspiciatis laboriosam a voluptatibus non blanditiis commodi quo.', TO_DATE('2022-07-24', 'YYYY-MM-DD'), 'https://picsum.photos/881/451', 'https://moura.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (15, 'Labore explicabo perferendis adipisci architecto rerum sequi.', 'Est in quo labore cum ipsam amet deleniti debitis labore eos.', TO_DATE('2022-01-02', 'YYYY-MM-DD'), 'https://placekitten.com/554/690', 'http://www.cardoso.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (16, 'Eum mollitia tenetur.', 'Enim nam perferendis harum soluta qui dignissimos ipsum tenetur eos quo cupiditate.', TO_DATE('2020-04-12', 'YYYY-MM-DD'), 'https://dummyimage.com/512x447', 'http://www.da.com/');    


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (17, 'Aut magnam molestiae.', 'Eum asperiores delectus dolores ut accusamus voluptatibus.', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'https://placekitten.com/490/858', 'https://www.fernandes.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (18, 'Sint exercitationem maxime cum.', 'Perferendis excepturi quam numquam sint aspernatur delectus.', TO_DATE('2022-12-09', 'YYYY-MM-DD'), 'https://dummyimage.com/516x810', 'https://duarte.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (19, 'Laudantium perferendis illo dolore non voluptatum sit.', 'Blanditiis veniam nam occaecati ad quas.', TO_DATE('2020-10-02', 'YYYY-MM-DD'), 'https://placekitten.com/528/43', 'http://fogaca.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (20, 'Nesciunt placeat totam voluptas provident aut quaerat.', 'Aspernatur aspernatur ut minima libero accusantium cupiditate dignissimos inventore quidem.', TO_DATE('2020-03-04', 'YYYY-MM-DD'), 'https://dummyimage.com/489x324', 'http://oliveira.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (21, 'Accusamus dignissimos consequatur ducimus veritatis explicabo quas.', 'Quis corporis cupiditate mollitia corporis error sit.', TO_DATE('2023-05-09', 'YYYY-MM-DD'), 'https://placekitten.com/154/754', 'https://moura.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (22, 'Minus quis provident quas aliquid.', 'Dolorum possimus ea voluptas repellat eius aut voluptas sapiente fugit eos beatae.', TO_DATE('2022-09-25', 'YYYY-MM-DD'), 'https://picsum.photos/1003/101', 'http://www.viana.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (23, 'Nemo repudiandae facilis facere.', 'Modi neque expedita quisquam cupiditate quaerat debitis recusandae.', TO_DATE('2021-01-28', 'YYYY-MM-DD'), 'https://dummyimage.com/689x487', 'https://www.freitas.br/');    


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (24, 'Dolore optio ipsa excepturi asperiores neque neque.', 'Fugiat necessitatibus id vel soluta pariatur quae consequuntur necessitatibus assumenda consectetur illum aperiam.', TO_DATE('2020-12-13', 'YYYY-MM-DD'), 'https://dummyimage.com/648x596', 'https://www.gomes.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (25, 'Minima laboriosam hic repudiandae veritatis.', 'Odit quod ex error commodi aspernatur.', TO_DATE('2020-01-25', 'YYYY-MM-DD'), 'https://picsum.photos/677/176', 'http://www.melo.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (26, 'Quibusdam consectetur consequuntur amet.', 'Laudantium corporis alias tenetur rem recusandae quod possimus amet incidunt sapiente amet.', TO_DATE('2021-09-18', 'YYYY-MM-DD'), 'https://picsum.photos/259/159', 'http://www.souza.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (27, 'Ducimus minus corrupti optio.', 'Aut voluptate eius quae eius perspiciatis.', TO_DATE('2023-01-13', 'YYYY-MM-DD'), 'https://dummyimage.com/482x882', 'https://www.melo.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (28, 'Ipsa iste consequuntur sequi magnam quasi.', 'Similique explicabo iste porro vero cum voluptatum perspiciatis eum.', TO_DATE('2021-11-27', 'YYYY-MM-DD'), 'https://picsum.photos/761/142', 'https://vieira.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (29, 'Iure tempora est unde blanditiis quam ullam.', 'Eum laudantium dolor itaque iure consequatur officiis vero dignissimos eius.', TO_DATE('2021-05-30', 'YYYY-MM-DD'), 'https://picsum.photos/512/733', 'https://aragao.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (30, 'Error laborum ad architecto eius libero.', 'Exercitationem distinctio quasi perferendis voluptates minus quo ipsa.', TO_DATE('2023-06-24', 'YYYY-MM-DD'), 'https://dummyimage.com/93x563', 'https://porto.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (31, 'Tenetur dolores accusamus cum recusandae.', 'Excepturi dolore doloribus aperiam facere perspiciatis mollitia cumque ratione vitae.', TO_DATE('2021-05-22', 'YYYY-MM-DD'), 'https://placekitten.com/559/245', 'https://www.vieira.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (32, 'Laboriosam corrupti fugit illum eaque dolores.', 'Assumenda eligendi perspiciatis id repudiandae nobis suscipit modi officia.', TO_DATE('2022-06-27', 'YYYY-MM-DD'), 'https://picsum.photos/459/173', 'https://pinto.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (33, 'Rem ex officiis blanditiis repellat.', 'Temporibus earum natus vitae iusto expedita labore eius occaecati adipisci.', TO_DATE('2020-10-09', 'YYYY-MM-DD'), 'https://dummyimage.com/736x361', 'https://www.azevedo.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (34, 'Id reiciendis voluptatibus cumque explicabo beatae voluptatum harum.', 'Assumenda dolore vel excepturi sed consequatur provident voluptatum maxime dolorum.', TO_DATE('2023-09-10', 'YYYY-MM-DD'), 'https://picsum.photos/292/917', 'http://www.moura.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (35, 'Eos repellat nemo reprehenderit labore commodi minima doloribus.', 'Et dolorum deserunt ducimus consectetur incidunt maxime.', TO_DATE('2022-03-04', 'YYYY-MM-DD'), 'https://picsum.photos/143/498', 'http://costa.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (36, 'Velit dolorum itaque ipsam ad et.', 'Magnam tenetur ipsum eligendi dicta distinctio quasi.', TO_DATE('2020-10-06', 'YYYY-MM-DD'), 'https://dummyimage.com/1001x1022', 'https://www.azevedo.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (37, 'Aut deleniti ducimus quos.', 'Minus unde dolore nisi facere mollitia quisquam error aspernatur blanditiis harum.', TO_DATE('2023-06-22', 'YYYY-MM-DD'), 'https://picsum.photos/49/656', 'https://caldeira.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (38, 'Velit reiciendis et quis corrupti ut.', 'Minus illo ab numquam fuga quia rerum.', TO_DATE('2021-06-21', 'YYYY-MM-DD'), 'https://picsum.photos/23/176', 'http://www.farias.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (39, 'Ab at officia quidem consequatur.', 'Nisi inventore molestiae numquam est cupiditate quas.', TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'https://dummyimage.com/414x285', 'https://das.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (40, 'Exercitationem hic esse sequi.', 'Magnam eligendi reprehenderit quis tempora illum laudantium recusandae quo in neque porro.', TO_DATE('2023-10-06', 'YYYY-MM-DD'), 'https://picsum.photos/774/70', 'https://www.da.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (41, 'Pariatur minus quam architecto magnam.', 'Facere est magni maiores impedit doloribus nobis.', TO_DATE('2021-04-20', 'YYYY-MM-DD'), 'https://placekitten.com/491/231', 'http://moraes.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (42, 'Facilis recusandae aperiam.', 'Dolores tempore occaecati itaque ex ad.', TO_DATE('2020-04-29', 'YYYY-MM-DD'), 'https://dummyimage.com/683x693', 'http://www.monteiro.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (43, 'Porro hic architecto harum.', 'Deserunt ex corrupti incidunt iure animi.', TO_DATE('2020-04-15', 'YYYY-MM-DD'), 'https://picsum.photos/393/578', 'https://oliveira.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (44, 'Animi corporis alias eum eaque officia quos.', 'Sed deleniti totam consequuntur fugiat laboriosam necessitatibus molestiae.', TO_DATE('2023-08-07', 'YYYY-MM-DD'), 'https://placekitten.com/725/404', 'http://costa.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (45, 'Blanditiis illo delectus.', 'Cupiditate temporibus alias impedit unde quasi deserunt ab iusto architecto.', TO_DATE('2023-10-31', 'YYYY-MM-DD'), 'https://picsum.photos/151/422', 'http://teixeira.com/');      


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (46, 'Perferendis repellat eligendi reiciendis facilis provident magni ullam.', 'Aspernatur quisquam quod consectetur ullam iste aliquam ut qui corrupti iure.', TO_DATE('2021-09-13', 'YYYY-MM-DD'), 'https://placekitten.com/4/655', 'http://campos.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (47, 'Temporibus ducimus voluptate voluptate quasi tenetur.', 'Sint neque ab ipsum consequuntur accusantium blanditiis.', TO_DATE('2023-02-27', 'YYYY-MM-DD'), 'https://dummyimage.com/26x34', 'http://www.rodrigues.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (48, 'Molestiae amet dolorum.', 'Cumque magnam natus dolorem ratione nisi delectus sequi quod earum.', TO_DATE('2021-10-08', 'YYYY-MM-DD'), 'https://picsum.photos/314/730', 'http://farias.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (49, 'Nisi nihil ducimus.', 'Sequi accusantium magnam dignissimos culpa quibusdam temporibus.', TO_DATE('2021-10-26', 'YYYY-MM-DD'), 'https://picsum.photos/764/477', 'https://carvalho.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (50, 'Iste nulla cum.', 'Deleniti adipisci laudantium voluptate commodi assumenda iusto totam nisi fuga odio error nostrum.', TO_DATE('2021-02-10', 'YYYY-MM-DD'), 'https://dummyimage.com/858x691', 'https://www.da.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (51, 'Facilis explicabo blanditiis possimus.', 'Eos optio mollitia suscipit iure porro blanditiis porro vitae blanditiis pariatur.', TO_DATE('2022-07-22', 'YYYY-MM-DD'), 'https://placekitten.com/790/443', 'http://castro.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (52, 'Perspiciatis doloribus provident non aliquam dignissimos.', 'Nulla atque inventore esse eum provident sit.', TO_DATE('2023-05-05', 'YYYY-MM-DD'), 'https://placekitten.com/1004/801', 'https://www.da.com/');   


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (53, 'Maiores expedita sunt dolor voluptates non rerum.', 'Earum numquam expedita minima ea delectus odit nihil ipsa at eveniet veniam quibusdam.', TO_DATE('2020-10-20', 'YYYY-MM-DD'), 'https://picsum.photos/384/938', 'http://gomes.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (54, 'Iure asperiores perferendis magni nam impedit.', 'Ex doloribus nostrum culpa error tenetur commodi.', TO_DATE('2021-11-18', 'YYYY-MM-DD'), 'https://dummyimage.com/452x993', 'http://da.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (55, 'Dolor rerum expedita minima doloribus dignissimos.', 'Rem voluptatibus sit optio quo impedit tempora distinctio.', TO_DATE('2020-06-18', 'YYYY-MM-DD'), 'https://placekitten.com/668/435', 'http://www.barbosa.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (56, 'Culpa sapiente quae cupiditate inventore dignissimos itaque.', 'Mollitia rerum voluptates doloribus accusantium nemo unde natus.', TO_DATE('2022-05-11', 'YYYY-MM-DD'), 'https://dummyimage.com/888x429', 'https://barros.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (57, 'Deserunt consequuntur quos natus mollitia ratione id.', 'Voluptate quod consectetur dolorum iste voluptate tempora beatae maxime vero sunt explicabo quaerat.', TO_DATE('2020-02-09', 'YYYY-MM-DD'), 'https://picsum.photos/12/1010', 'http://lopes.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (58, 'Accusamus quasi quae magni ex quaerat reiciendis laborum.', 'Laudantium unde recusandae magnam vel itaque maiores maxime unde saepe vitae.', TO_DATE('2023-01-13', 'YYYY-MM-DD'), 'https://picsum.photos/929/63', 'https://aragao.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (59, 'Ducimus nisi veniam illo.', 'Vel quis debitis minima iure dolor molestiae quidem.', TO_DATE('2022-06-22', 'YYYY-MM-DD'), 'https://picsum.photos/483/799', 'https://da.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (60, 'Id pariatur ut ut optio.', 'Iure nesciunt officiis rem earum tempore autem ea impedit minus possimus.', TO_DATE('2021-07-02', 'YYYY-MM-DD'), 'https://dummyimage.com/538x63', 'http://castro.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (61, 'Nisi eius corporis consequuntur illo dignissimos quam enim.', 'Dolorem reiciendis repudiandae numquam fuga id a pariatur qui quae molestiae odio aperiam.', TO_DATE('2023-08-23', 'YYYY-MM-DD'), 'https://placekitten.com/613/110', 'https://da.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (62, 'Nesciunt illum iure voluptate provident similique dignissimos beatae.', 'Reiciendis assumenda maiores voluptatum expedita cum nesciunt fugit unde iusto accusamus suscipit commodi repellendus.', TO_DATE('2022-11-04', 'YYYY-MM-DD'), 'https://dummyimage.com/54x657', 'https://da.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (63, 'Molestias nam doloribus nostrum alias dolorum.', 'Accusamus unde harum ea nemo pariatur deserunt soluta necessitatibus.', TO_DATE('2022-12-11', 'YYYY-MM-DD'), 'https://dummyimage.com/500x367', 'https://www.ferreira.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (64, 'Dolorum earum dicta excepturi ex provident adipisci.', 'Amet odio sed harum tenetur eligendi id non tempora porro.', TO_DATE('2020-09-23', 'YYYY-MM-DD'), 'https://picsum.photos/519/183', 'http://goncalves.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (65, 'Quia culpa dolores itaque voluptatem.', 'Id rerum laudantium minus consectetur itaque quasi labore.', TO_DATE('2020-01-25', 'YYYY-MM-DD'), 'https://picsum.photos/815/459', 'https://www.rezende.com/');        


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (66, 'Illo quod doloremque provident quaerat exercitationem.', 'Vel laboriosam voluptatum a reprehenderit asperiores doloremque id molestiae sit omnis.', TO_DATE('2020-03-19', 'YYYY-MM-DD'), 'https://picsum.photos/257/972', 'https://www.nunes.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (67, 'Vitae tenetur accusantium nisi quia vero.', 'Placeat accusamus quam ratione nobis autem nulla aspernatur aliquid rem neque sequi autem.', TO_DATE('2020-01-18', 'YYYY-MM-DD'), 'https://picsum.photos/489/1022', 'http://caldeira.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (68, 'Animi a accusamus sit doloremque minus.', 'Similique reprehenderit quaerat esse architecto sed dolorum aspernatur atque vitae occaecati vel saepe.', TO_DATE('2021-08-23', 'YYYY-MM-DD'), 'https://picsum.photos/361/329', 'https://www.correia.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (69, 'Repudiandae beatae necessitatibus.', 'Necessitatibus rerum itaque reiciendis tempore praesentium corrupti placeat recusandae commodi.', TO_DATE('2020-05-29', 'YYYY-MM-DD'), 'https://placekitten.com/836/23', 'https://www.barros.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (70, 'Expedita itaque doloribus laboriosam deserunt tempore.', 'Nemo eaque magni error tenetur dicta.', TO_DATE('2022-07-11', 'YYYY-MM-DD'), 'https://placekitten.com/32/481', 'https://www.barros.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (71, 'Expedita dignissimos architecto praesentium accusantium suscipit quibusdam.', 'Ea ipsa et repellendus deserunt totam quas.', TO_DATE('2022-12-23', 'YYYY-MM-DD'), 'https://dummyimage.com/890x653', 'https://castro.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (72, 'Esse delectus ab ea voluptatum ipsa ea assumenda.', 'Voluptatem sint ipsum beatae laboriosam nobis blanditiis sequi ipsum vero eligendi pariatur debitis.', TO_DATE('2021-07-25', 'YYYY-MM-DD'), 'https://picsum.photos/717/276', 'https://almeida.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (73, 'Temporibus mollitia ipsum asperiores officia ex.', 'Alias quisquam voluptas alias nam corporis cumque debitis iure fuga eveniet similique.', TO_DATE('2022-06-22', 'YYYY-MM-DD'), 'https://picsum.photos/398/439', 'https://www.rocha.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (74, 'Dolorem reiciendis officiis doloribus necessitatibus.', 'Laborum quod officiis incidunt quisquam facere accusamus nam modi reiciendis consequuntur quaerat illo necessitatibus.', TO_DATE('2020-12-20', 'YYYY-MM-DD'), 'https://dummyimage.com/833x941', 'http://www.rezende.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (75, 'Tempore placeat suscipit ipsam accusantium.', 'Mollitia pariatur deleniti recusandae harum totam soluta dolore corporis ducimus dolores hic.', TO_DATE('2020-11-29', 'YYYY-MM-DD'), 'https://picsum.photos/487/823', 'https://www.fogaca.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (76, 'Perspiciatis modi quisquam laudantium qui earum mollitia.', 'Debitis et reprehenderit aperiam alias velit veniam assumenda iste assumenda similique.', TO_DATE('2022-03-24', 'YYYY-MM-DD'), 'https://dummyimage.com/525x698', 'http://www.porto.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (77, 'Atque molestiae vero maiores.', 'Molestiae tempora sunt accusantium quis voluptatibus consectetur ut neque.', TO_DATE('2023-03-23', 'YYYY-MM-DD'), 'https://dummyimage.com/768x271', 'https://www.rocha.net/'); 


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (78, 'Culpa corrupti eaque eius aut numquam atque.', 'Aliquam ad necessitatibus libero accusamus consequuntur alias voluptatum quam harum eveniet.', TO_DATE('2021-08-05', 'YYYY-MM-DD'), 'https://dummyimage.com/206x975', 'https://da.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (79, 'Dolor laboriosam quasi repellat necessitatibus minus.', 'Ipsa totam ullam fugiat ut ea assumenda tempora accusamus expedita occaecati.', TO_DATE('2021-02-05', 'YYYY-MM-DD'), 'https://dummyimage.com/133x819', 'http://da.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (80, 'Vitae facilis eum fugit fugiat doloribus voluptate.', 'Quis cupiditate eum at enim dicta placeat dolore nisi consequatur enim.', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'https://dummyimage.com/901x329', 'http://www.cunha.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (81, 'Provident sint molestiae.', 'Iusto aut itaque eveniet nemo esse.', TO_DATE('2023-11-19', 'YYYY-MM-DD'), 'https://picsum.photos/237/679', 'https://lopes.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (82, 'Dolorem vitae eveniet perferendis dolorem.', 'Nihil exercitationem occaecati autem tempora eaque velit id.', TO_DATE('2020-03-08', 'YYYY-MM-DD'), 'https://placekitten.com/276/492', 'https://www.fogaca.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (83, 'Nostrum fuga nobis unde quas.', 'Quos animi ut adipisci quas occaecati veritatis.', TO_DATE('2023-08-02', 'YYYY-MM-DD'), 'https://placekitten.com/789/709', 'http://www.goncalves.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (84, 'Veniam officia fugiat molestiae magni dolorum.', 'Debitis expedita non deserunt expedita earum repellat.', TO_DATE('2020-05-14', 'YYYY-MM-DD'), 'https://picsum.photos/995/22', 'https://www.pires.com/');      


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (85, 'Dolor natus odio quam ipsa quis.', 'Laborum aspernatur nihil voluptas earum non quia aut animi.', TO_DATE('2022-05-30', 'YYYY-MM-DD'), 'https://picsum.photos/260/731', 'https://www.da.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (86, 'Numquam magni at dicta.', 'Ab velit eaque repellendus est incidunt harum vitae maiores.', TO_DATE('2020-09-02', 'YYYY-MM-DD'), 'https://placekitten.com/406/322', 'http://novaes.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (87, 'A eveniet eaque excepturi ex.', 'Maiores vero quam facere corporis dolorem quo adipisci.', TO_DATE('2023-09-17', 'YYYY-MM-DD'), 'https://picsum.photos/255/833', 'http://nogueira.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (88, 'Sit veritatis numquam magni consequuntur eius.', 'Sed facere eveniet architecto culpa hic consequuntur.', TO_DATE('2020-01-05', 'YYYY-MM-DD'), 'https://dummyimage.com/344x718', 'http://porto.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (89, 'Maxime omnis cum.', 'Sit beatae provident eius perspiciatis fugiat id illum explicabo cupiditate impedit.', TO_DATE('2022-06-20', 'YYYY-MM-DD'), 'https://placekitten.com/370/214', 'http://goncalves.br/');    


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (90, 'Atque unde distinctio odit.', 'Veniam vitae amet est architecto aspernatur eveniet velit placeat.', TO_DATE('2020-03-16', 'YYYY-MM-DD'), 'https://picsum.photos/560/980', 'http://almeida.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (91, 'Accusantium ullam quas recusandae nobis qui.', 'Quaerat ab qui ab ea nulla eos sint minus.', TO_DATE('2022-06-13', 'YYYY-MM-DD'), 'https://dummyimage.com/97x536', 'http://www.da.net/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (92, 'Quas voluptate vero.', 'Nostrum ipsa aspernatur minima officiis eius.', TO_DATE('2020-10-04', 'YYYY-MM-DD'), 'https://dummyimage.com/761x8', 'https://www.fogaca.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (93, 'Mollitia vitae maxime harum recusandae quidem cupiditate.', 'Deserunt fuga reiciendis eveniet temporibus laboriosam odio numquam quas officiis amet dolore soluta.', TO_DATE('2023-02-12', 'YYYY-MM-DD'), 'https://dummyimage.com/747x280', 'http://freitas.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (94, 'A possimus temporibus hic voluptate molestias.', 'Mollitia dolore veniam earum accusantium animi quibusdam nam quod earum deleniti fuga magnam.', TO_DATE('2023-09-22', 'YYYY-MM-DD'), 'https://picsum.photos/917/691', 'https://www.nunes.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (95, 'Culpa libero rem ipsam.', 'Incidunt aut eaque magni aut tempore adipisci minus.', TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'https://placekitten.com/858/544', 'http://ramos.org/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (96, 'Adipisci odio repellendus quibusdam.', 'Quisquam at id molestiae illo cum deserunt exercitationem sint animi.', TO_DATE('2022-10-15', 'YYYY-MM-DD'), 'https://placekitten.com/744/279', 'http://www.teixeira.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (97, 'Sapiente eveniet quaerat facere dicta aliquam enim.', 'Distinctio tempore cupiditate ut repudiandae repudiandae.', TO_DATE('2021-07-07', 'YYYY-MM-DD'), 'https://picsum.photos/543/447', 'https://www.lopes.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (98, 'Aliquam a at nesciunt.', 'Corrupti dolorem eius rerum aliquam magni.', TO_DATE('2023-04-01', 'YYYY-MM-DD'), 'https://placekitten.com/629/960', 'https://souza.br/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (99, 'Dolore odit aspernatur ipsam exercitationem maxime nam.', 'Voluptate magnam ut animi reiciendis suscipit officia odio numquam.', TO_DATE('2023-06-13', 'YYYY-MM-DD'), 'https://placekitten.com/109/891', 'http://www.farias.com/');


    INSERT INTO tg_noticia (id_noticia, nm_titulo, nm_subtitulo, dt_noticia, ds_imagem, ds_link)
    VALUES (100, 'Quis laboriosam provident dolore.', 'Dolorum repellendus assumenda sapiente perspiciatis dolorum debitis architecto neque aliquid praesentium impedit quibusdam.', TO_DATE('2022-06-05', 'YYYY-MM-DD'), 'https://placekitten.com/825/586', 'https://moraes.com/');



    -- inserindo noticias acessadas


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (1, 1, 1, TO_DATE('2023-04-25', 'YYYY-MM-DD'));
    

    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (2, 2, 2, TO_DATE('2023-05-25', 'YYYY-MM-DD'));
    

    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (3, 3, 3, TO_DATE('2023-06-04', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (4, 4, 4, TO_DATE('2023-01-11', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (5, 5, 5, TO_DATE('2023-01-03', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (6, 6, 6, TO_DATE('2023-06-14', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (7, 7, 7, TO_DATE('2023-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (8, 8, 8, TO_DATE('2023-08-22', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (9, 9, 9, TO_DATE('2023-06-26', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (10, 10, 10, TO_DATE('2023-03-22', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (11, 11, 11, TO_DATE('2023-10-21', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (12, 12, 12, TO_DATE('2023-08-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (13, 13, 13, TO_DATE('2023-09-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (14, 14, 14, TO_DATE('2023-10-21', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (15, 15, 15, TO_DATE('2023-01-19', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (16, 16, 16, TO_DATE('2023-10-08', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (17, 17, 17, TO_DATE('2023-08-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (18, 18, 18, TO_DATE('2023-01-23', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (19, 19, 19, TO_DATE('2023-04-29', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (20, 20, 20, TO_DATE('2023-07-14', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (21, 21, 21, TO_DATE('2023-10-23', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (22, 22, 22, TO_DATE('2023-04-05', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (23, 23, 23, TO_DATE('2023-10-30', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (24, 24, 24, TO_DATE('2023-03-05', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (25, 25, 25, TO_DATE('2023-07-25', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (26, 26, 26, TO_DATE('2023-05-15', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (27, 27, 27, TO_DATE('2023-03-01', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (28, 28, 28, TO_DATE('2023-07-29', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (29, 29, 29, TO_DATE('2023-02-28', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (30, 30, 30, TO_DATE('2023-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (31, 31, 31, TO_DATE('2023-09-25', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (32, 32, 32, TO_DATE('2023-09-14', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (33, 33, 33, TO_DATE('2023-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (34, 34, 34, TO_DATE('2023-02-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (35, 35, 35, TO_DATE('2023-04-02', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (36, 36, 36, TO_DATE('2023-05-02', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (37, 37, 37, TO_DATE('2023-10-19', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (38, 38, 38, TO_DATE('2023-01-28', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (39, 39, 39, TO_DATE('2023-01-05', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (40, 40, 40, TO_DATE('2023-10-15', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (41, 41, 41, TO_DATE('2023-09-17', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (42, 42, 42, TO_DATE('2023-09-05', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (43, 43, 43, TO_DATE('2023-10-27', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (44, 44, 44, TO_DATE('2023-01-26', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (45, 45, 45, TO_DATE('2023-05-03', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (46, 46, 46, TO_DATE('2023-04-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (47, 47, 47, TO_DATE('2023-03-29', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (48, 48, 48, TO_DATE('2023-08-25', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (49, 49, 49, TO_DATE('2023-03-03', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (50, 50, 50, TO_DATE('2023-03-09', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (51, 51, 51, TO_DATE('2023-09-26', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (52, 52, 52, TO_DATE('2023-03-15', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (53, 53, 53, TO_DATE('2023-09-16', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (54, 54, 54, TO_DATE('2023-07-21', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (55, 55, 55, TO_DATE('2023-07-26', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (56, 56, 56, TO_DATE('2023-08-11', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (57, 57, 57, TO_DATE('2023-08-31', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (58, 58, 58, TO_DATE('2023-06-09', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (59, 59, 59, TO_DATE('2023-05-17', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (60, 60, 60, TO_DATE('2023-06-11', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (61, 61, 61, TO_DATE('2023-02-09', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (62, 62, 62, TO_DATE('2023-09-09', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (63, 63, 63, TO_DATE('2023-06-12', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (64, 64, 64, TO_DATE('2023-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (65, 65, 65, TO_DATE('2023-02-14', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (66, 66, 66, TO_DATE('2023-10-28', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (67, 67, 67, TO_DATE('2023-07-23', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (68, 68, 68, TO_DATE('2023-09-26', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (69, 69, 69, TO_DATE('2023-03-27', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (70, 70, 70, TO_DATE('2023-07-24', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (71, 71, 71, TO_DATE('2023-07-20', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (72, 72, 72, TO_DATE('2023-08-31', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (73, 73, 73, TO_DATE('2023-09-24', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (74, 74, 74, TO_DATE('2023-04-01', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (75, 75, 75, TO_DATE('2023-03-25', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (76, 76, 76, TO_DATE('2023-10-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (77, 77, 77, TO_DATE('2023-02-07', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (78, 78, 78, TO_DATE('2023-01-10', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (79, 79, 79, TO_DATE('2023-02-05', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (80, 80, 80, TO_DATE('2023-09-23', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (81, 81, 81, TO_DATE('2023-03-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (82, 82, 82, TO_DATE('2023-05-21', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (83, 83, 83, TO_DATE('2023-01-21', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (84, 84, 84, TO_DATE('2023-11-13', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (85, 85, 85, TO_DATE('2023-07-06', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (86, 86, 86, TO_DATE('2023-07-03', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (87, 87, 87, TO_DATE('2023-04-14', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (88, 88, 88, TO_DATE('2023-03-09', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (89, 89, 89, TO_DATE('2023-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (90, 90, 90, TO_DATE('2023-04-02', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (91, 91, 91, TO_DATE('2023-10-11', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (92, 92, 92, TO_DATE('2023-10-02', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (93, 93, 93, TO_DATE('2023-09-27', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (94, 94, 94, TO_DATE('2023-02-04', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (95, 95, 95, TO_DATE('2023-02-18', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (96, 96, 96, TO_DATE('2023-08-29', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (97, 97, 97, TO_DATE('2023-03-07', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (98, 98, 98, TO_DATE('2023-04-10', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (99, 99, 99, TO_DATE('2023-07-05', 'YYYY-MM-DD'));


    INSERT INTO tg_noticia_acessada (id_noticia_acess, id_usuario, id_noticia, dt_acesso)
    VALUES (100, 100, 100, TO_DATE('2023-09-16', 'YYYY-MM-DD'));





--Consulta 1 - Informações Gerais dos Usuários com Endereço e Telefone:
    SELECT
    u.id_usuario,
    u.nm_usuario,
    u.nr_cpf,
    u.nm_rg,
    u.dt_nascimento,
    u.fl_genero,
    u.dt_cadastro AS cadastro_usuario,
    e.nr_logradouro,
    e.ds_complemento,
    e.ds_ponto_ref,
    e.dt_inicio AS inicio_endereco,
    e.dt_fim AS fim_endereco,
    e.dt_cadastro AS cadastro_endereco,
    t.nr_ddi,
    t.nr_ddd,
    t.nr_telefone,
    t.tp_telefone,
    t.st_telefone,
    t.dt_cadastro AS cadastro_telefone
FROM
    tg_usuario u
LEFT JOIN
    tg_endereco_usuario e ON u.id_usuario = e.id_usuario
LEFT JOIN
    tg_telefone_usuario t ON u.id_usuario = t.id_usuario;

--Descrição:
-- Esta consulta retorna informações gerais dos usuários, incluindo dados do endereço e telefone associados.
-- Utiliza LEFT JOIN para incluir informações de endereço e telefone, mesmo que não haja correspondência nas tabelas relacionadas.



--Consulta Simples: Listar todos os usuários ordenados por nome:
SELECT id_usuario, nm_usuario, nr_cpf, dt_nascimento, fl_genero
FROM tg_usuario
ORDER BY nm_usuario;


-- Consulta com JOIN e Filtro: Listar contatos de um usuário específico ordenados por tipo de contato:

SELECT
    cu.id_contato,
    cu.nm_contato,
    tc.nm_tipo,
    cu.nr_ddi,
    cu.nr_ddd,
    cu.nr_telefone,
    cu.dt_cadastro
FROM
    tg_contato_usuario cu
JOIN
    tg_tipo_contato tc ON cu.id_tipo = tc.id_tipo
WHERE
    cu.id_usuario = 1  -- Substitua pelo ID do usuário desejado
ORDER BY
    tc.nm_tipo, cu.nm_contato;





--Consulta com Agrupamento: Contar quantos contatos cada usuário possui:

SELECT id_usuario, COUNT(id_contato) AS total_contatos
FROM tg_contato_usuario
GROUP BY id_usuario
ORDER BY id_usuario;


--Consulta com Função de Grupo e Filtro (Having): Listar tipos de contato com mais de 3 contatos:


SELECT
    n.id_noticia,
    n.nm_titulo,
    n.nm_subtitulo,
   
   COUNT(na.id_noticia_acess) AS total_acessos
FROM
    tg_noticia n
JOIN
    tg_noticia_acessada na ON n.id_noticia = na.id_noticia
 JOIN
    tg_usuario u ON na.id_usuario = u.id_usuario
WHERE
    u.fl_genero = 'M'
GROUP BY
    n.id_noticia, n.nm_titulo, n.nm_subtitulo
HAVING
    COUNT(na.id_noticia_acess) > 0
ORDER BY
    total_acessos DESC;



