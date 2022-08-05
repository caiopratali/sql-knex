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

-- INSERT COM SELECT, PARA CADA USUARIO ADICIONA BIO E DESCRIPTION;
INSERT INTO profiles (bio, description, user_id)
SELECT 'bio', 'description', id from users;

-- CONCAT UNI OS VALORES E INSERE OS PARAMETROS
INSERT INTO profiles (bio, description, user_id)
SELECT 
CONCAT('bio de ', first_name), 
CONCAT('description de', first_name), id from users;


-- DELETE 
DELETE FROM users WHERE id = 96;

-- DICA: sempre fazer select com os operadores para ver quais registros serao alterado.
SELECT * FROM users WHERE id BETWEEN 60 AND 65;

DELETE FROM users WHERE id BETWEEN 60 AND 65;

DELETE FROM profiles WHERE id BETWEEN 10 AND 30;

-- UPDATE 
-- DICA: sempre fazer select com os operadores para ver quais registros serao alterado.
SELECT * FROM users WHERE id = 70;
UPDATE users SET first_name = 'Goku', last_name = 'Batata' WHERE id = 70;

UPDATE users SET first_name = CONCAT('Eu sou o ', first_name) WHERE id = 70;

SELECT * FROM users u WHERE u.id BETWEEN 70 AND 80;
UPDATE users SET first_name = CONCAT('Eu sou o ', first_name) WHERE id BETWEEN 70 AND 80;

-- SELECT DUAS TABELAS (FORMA ERRADA, VAI EXIBIR PARA CADA PERFIL TODOS OS USUARIOS, N MOSTRANDO APENAS OS RELACIONAMENTOS)
SELECT u.id AS uid, p.id AS pid FROM users AS u, profiles AS p;

-- SELECT DUAS TABELAS (FAREMOS COM JOIN DEPOIS)
SELECT u.id AS uid, p.id AS pid, u.first_name, p.bio FROM users AS u, profiles AS p WHERE u.id = p.user_id;

-- INNER JOIN (retorna todos os registros que possuem relacao, mesma consulta que fiz em cima)
SELECT u.id AS uid, p.id AS pid, u.first_name, p.bio FROM users AS u INNER JOIN profiles p ON u.id = p.user_id;

-- INNER JOIN COM MAIS CONDICOES
SELECT u.id AS uid, p.id AS pid, u.first_name, p.bio FROM users AS u INNER JOIN profiles p ON u.id = p.user_id WHERE u.first_name LIKE 'Eu sou o%' ORDER BY u.id DESC LIMIT 5;

-- LEFT JOIN (retona todos os usuarios mesmo que nao possuam relacao com um profile)
SELECT u.id AS uid, p.id AS pid, u.first_name, p.bio FROM users u LEFT JOIN profiles p ON u.id = p.user_id;

-- RIGHT JOIN (retona todos os profiles mesmo que nao possuam relacao com um users)
INSERT INTO profiles (bio, description) VALUES ( ('bio test', 'description test'), 'bio test 2', 'description test 2'), ('bio test 3', 'description test 3');
SELECT u.id AS uid, p.id AS pid, u.first_name, p.bio FROM users u RIGHT JOIN profiles p ON u.id = p.user_id;

-- RAND, ROUND (gerar numeros aleatorios)
UPDATE users SET salary = ROUND(RAND() * 10000, 2);
SELECT u.first_name, u.salary FROM users u WHERE salary BETWEEN 1000 AND 1500;
