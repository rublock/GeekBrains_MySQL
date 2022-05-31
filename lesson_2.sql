-- 2. Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

-- mysql> CREATE DATABASE expample;

ALTER DATABASE example CHARACTER SET utf8 COLLATE utf8_general_ci;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя пользователя'
) COMMENT = 'Таблица пользователей';

DESCRIBE users;

INSERT INTO users (id, name) VALUES (1, 'Максим');

SELECT * FROM users;

-- 3.Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

-- $ mysqldump example > sample.sql
-- mysql> CREATE DATABASE sample;
-- $ mysql sample < sample.sql

-- 4.(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. 
-- Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

-- $ mysqldump mysql help_keyword --where="1 limit 100" > help_keyword.sql
-- mysql> create database help_keyword;
-- $ mysql help_keyword < help_keyword.sql