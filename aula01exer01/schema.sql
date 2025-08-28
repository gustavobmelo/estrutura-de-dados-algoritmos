-- exemplo de criação de um banco de dados, comando: ls // depois: sqlite3 mais o banco de dados (loja.db)
-- comando: PRAGMA foreign_keys = NO; + alt shift v
-- comando: sqlite3 loja.db + alt shift v
-- COPIAR A TABELA E COLAR NO TERMINAL ANTES DE EXECUTAR O COMANDO NO TERMINAL

-- Attiva foreign keys no início do script
PRAGMA foreign_keys = NO;

-- Tabela usuario (é necessário criar uma tabela com um tipo de entidade + seus atributos dentro dos parênteses()
-- cada atributo deve conter uma tipagem)
CREATE TABLE usuario(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    nome TEXT NOT NULL,
    email TEXT NOT NULL,
    senha TEXT NOT NULL
);

-- TABELA COM ENTIDADE DO TIPO CLIENTE
CREATE TABLE cliente(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    telefone TEXT,
    usuario_id INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE CASCADE
);

-- TABELA ENTIDADE PRODUTO
CREATE TABLE produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    preco REAL NOT NULL CHECK (preco >= 0)
);

--TABELA ENTIDADE VENDA
CREATE TABLE venda(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    data TEXT NOT NULL,
    usuario_id INTEGER NOT NULL,
    cliente_id INTEGER NOT NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE SET NULL,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id) ON DELETE SET NULL
);

--TABELA venda_produto tabela associativa para N:M produto <-> venda
CREATE TABLE venda_produto(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    preco_unitario REAL NOT NULL CHECK (preco_unitario >= 0),
    FOREIGN KEY (venda_id) REFERENCES venda(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE CASCADE
);

--Inserir usuario
INSERT INTO usuario (nome, email, senha) VALUES ('Rafael','rafael@unipam','leafar');
INSERT INTO usuario (nome, email, senha) VALUES ('Junior','junior@unipam','leafar');
INSERT INTO usuario (nome, email, senha) VALUES ('James','james@unipam','leafar');
INSERT INTO usuario (nome, email, senha) VALUES ('Steve','steve@unipam','leafar');

--Inserir cliente
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Rafael Marinho','999999999', 1);
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Junior Savior','988888888',2);
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('James Stafe','977777777',3);
INSERT INTO cliente (nome, telefone, usuario_id) VALUES ('Steve Henri','966666666',4);

--Inserir produtos
INSERT INTO produto (nome, descricao, preco) VALUES ('Arroz 5kg','Arroz tipo 1', 10.20);
INSERT INTO produto (nome, descricao, preco) VALUES ('Feijao 1kg','Feijao carioca', 7.25);
INSERT INTO produto (nome, descricao, preco) VALUES ('Acucar 2kg','Acucar refinado', 5.35);

--Inserir venda
INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('2025-08-27', 1, 1);
INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('2025-08-27', 2, 2);
INSERT INTO venda (data, usuario_id, cliente_id) VALUES ('2025-08-27', 3, 3);

--Inserir dados na tabela de associação venda_produto
INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES (1,1,3,10.20);
INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES (1,2,5,7.25);
INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES (1,2,5,7.25);
INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES (2,2,1,7.25);
INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES (2,2,1,7.25);
INSERT INTO venda_produto (venda_id, produto_id, quantidade, preco_unitario) VALUES (3,1,2,10.20);