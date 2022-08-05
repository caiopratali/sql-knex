CREATE TABLE base_de_dados.users (
	id INT UNSIGNED auto_increment NOT NULL,
	first_name varchar(150) NULL,
	last_name varchar(150) NULL,
	email varchar(255) NOT NULL,
	password_hash varchar(255) NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT users_un_email UNIQUE KEY (email),
	CONSTRAINT users_un_password_hash UNIQUE KEY (password_hash)
);

CREATE TABLE base_de_dados.roles (
	id INT UNSIGNED auto_increment NOT NULL,
	name varchar(100) NOT NULL,
	CONSTRAINT roles_pk PRIMARY KEY (id)
);

CREATE TABLE base_de_dados.users_roles (
	user_id INT UNSIGNED NOT NULL,
	role_id INT UNSIGNED NOT NULL,
	CONSTRAINT users_roles_pk PRIMARY KEY (user_id,role_id),
	CONSTRAINT users_roles_fk FOREIGN KEY (user_id) REFERENCES base_de_dados.users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT user_roles_fk_1 FOREIGN KEY (role_id) REFERENCES base_de_dados.roles(id) ON DELETE CASCADE ON UPDATE  CASCADE
);

CREATE TABLE base_de_dados.profiles (
	id INT UNSIGNED auto_increment NOT NULL,
	bio TEXT NULL,
	description TEXT NULL,
	user_id INT UNSIGNED NULL,
	CONSTRAINT profiles_pk PRIMARY KEY (id),
	CONSTRAINT profiles_fk FOREIGN KEY (user_id) REFERENCES base_de_dados.users(id) ON DELETE CASCADE ON UPDATE CASCADE
);

ALTER TABLE base_de_dados.users ADD created_at DATETIME DEFAULT NOW() NOT NULL;
ALTER TABLE base_de_dados.users ADD updated_at DATETIME DEFAULT NOW() ON UPDATE NOW() NOT NULL;