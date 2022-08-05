-- DML - Data Manipulation Language - (SELECT, INSERT, UPDATE, DELETE, MERGE)

-- seleciona a base de dados.
USE base_de_dados;

-- mostra as tabelas da base de dados.
SHOW TABLES;

-- descreve as colunas da tabela.
DESCRIBE users;

-- inserir registros na base de dados.
INSERT INTO users (first_name, last_name, email, password_hash) VALUES ("Caio", "Pratali", "caio@pratali.com.br", "any_hash"), ("Lilian", "Pratali", "lilian@pratali.com.br", "any_hash_lih");
INSERT INTO users (first_name, last_name, email, password_hash) VALUES ("Goku", "Pratali", "goku@pratali.com.br", "any_hash_goku");

-- seleciona colunas.
SELECT * FROM users;
-- seleciona todas as colunas da tabela users e cria apelido para tabela.
SELECT * FROM users u;
-- seleciona a coluna first_name da tabela users cria apelido para a coluna e cria apelido para tabela users.
SELECT first_name as name FROM users as u;
-- seleciona apenas as colunas que vc quer.
SELECT last_name, first_name, email FROM users;
-- para casos que pode estar buscando em mais de uma tabela e n quer ter conflitos.
SELECT u.last_name uname FROM users u;
-- mesma coisa porem com as para deixar mais explícito. (sempre que criar apelidos vai aparecer na resposta com o apelido).
SELECT u.last_name as uname FROM users as u;

-- where filtra registros com operadores de comparacao (=, <, <=, >, >=, !=) e operadores logicos (AND, OR).
SELECT * FROM users WHERE first_name='Lilian';
SELECT * FROM users WHERE updated_at < '2022-08-04 22:15:30' AND first_name != 'Lilian';

-- DICA: sempre fazer select com os operadores para ver quais registros serao alterado.

-- BETWEEN seleciona um range (entre um valor e outro).
SELECT * FROM users WHERE created_at BETWEEN "2019-12-29 01:46:33" AND "2020-02-22 22:36:48";
-- IN seleciona os elementos existentes que batem com os valores informados.
SELECT * FROM users WHERE id IN (3,6,9,10);
-- LIKE filtra elementos (% qualquer coisa, _ um caracter).
SELECT * FROM users WHERE first_name LIKE 'c%';
SELECT * FROM users WHERE first_name LIKE 'c_io';

-- ORDER BY (ASC, DESC)
SELECT * from users WHERE id BETWEEN 70 AND 150 ORDER BY first_name ASC;

-- LIMIT
SELECT * from users WHERE id BETWEEN 70 AND 150 ORDER BY first_name ASC LIMIT 10;

-- OFFSET (pula a quantidade de registros selecionados no caso os proximos 10 registros) usado para paginacao.
SELECT * from users WHERE id BETWEEN 70 AND 150 ORDER BY first_name ASC LIMIT 10 OFFSET 10;

UPDATE users SET password_hash  = "any" WHERE id=3;
