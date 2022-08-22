DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at, created_at) VALUES
  ('Василий', '1990-10-05', '2000-10-03'),
  ('Наталья', '1984-11-12', '2000-08-11'),
  ('Александр', '1985-05-20', '2000-10-05'),
  ('Сергей', '1988-02-14', '1999-08-01'),
  ('Иван', '1998-01-12', '2000-11-25'),
  ('Мария', '1992-08-29', '2000-12-15');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- Практическое задание по теме “Транзакции, переменные, представления”

-- ЗАДАНИЕ 1 В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из 
-- таблицы shop.users в таблицу sample.users. Используйте транзакции.

START TRANSACTION;
UPDATE sample.users SET sample.users.name = (SELECT name FROM shop.users WHERE id = 1) WHERE sample.users.id = 1;
COMMIT;

-- ЗАДАНИЕ 2 Создайте представление, которое выводит название name товарной позиции из таблицы products и 
-- соответствующее название каталога name из таблицы catalogs.

DROP VIEW IF EXISTS product_name;
CREATE VIEW product_name AS SELECT p.name AS 'название', c.name AS 'категория' FROM products p JOIN catalogs c ON c.id = p.catalog_id;
SELECT * FROM product_name;

-- ЗАДАНИЕ 3 (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи за август 
-- 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в 
-- соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

-- за основу беру таблицу users

ALTER TABLE users ADD COLUMN august INT DEFAULT 0 AFTER updated_at;
UPDATE users SET august = 1 WHERE MONTH(created_at) = 8;
SELECT * FROM users;

-- ЗАДАНИЕ 4 (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие записи из таблицы, 
-- оставляя только 5 самых свежих записей.

DELETE FROM users WHERE created_at < '1999-12-31 00:00:00';

-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

-- ЗАДАНИЕ 1 Создайте двух пользователей которые имеют доступ к базе данных shop. Первому пользователю shop_read должны быть доступны только 
-- запросы на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

DROP USER IF EXISTS shop_read;
CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'pass';
GRANT SELECT ON shop.* TO shop_read;

DROP USER IF EXISTS shop;
CREATE USER shop IDENTIFIED WITH sha256_password BY 'pass';
GRANT ALL ON shop TO shop_read;

-- ЗАДАНИЕ 2 (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел 
-- доступа к таблице accounts, однако, мог бы извлекать записи из представления username.

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password_hash VARCHAR(100)
);

INSERT INTO accounts (name, password_hash) VALUES
  ('Василий', '4f4a4a4'),
  ('Наталья', 'a5f5af5f'),
  ('Александр', 'af5a6g6s7'),
  ('Сергей', 'ga6h7s77h'),
  ('Иван', '2f4335'),
  ('Мария', 'n06789b67j');
 
DROP VIEW IF EXISTS new_view;
CREATE VIEW new_view AS SELECT id, name FROM accounts;

DROP USER IF EXISTS user_read;
CREATE USER user_read IDENTIFIED WITH sha256_password BY 'pass';
GRANT SELECT ON new_view.* TO user_read;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- ЗАДАНИЕ 1 Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — 
-- "Доброй ночи".

drop procedure if exists good_day;

CREATE PROCEDURE shop.good_day()
begin
	if(hour(NOW()) > 6
and hour(NOW()) < 12) then
select
	'Доброе утро!' as good_day; -- я не понимаю почему тут выходит ошибка?(((

elseif (hour(NOW()) > 12
and hour(NOW()) < 18) then
select
	'Добрый день!' as good_day;

elseif (hour(NOW()) > 18
and hour(NOW()) < 0) then
select
	'Добрый вечер!' as good_day;
else
select
	'Доброй ночи!' as good_day;
end if;
end;

-- ЗАДАНИЕ 2 В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей 
-- или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из 
-- этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

drop trigger if exists drop_null;

create trigger drop_null after
update
	on
	products
for each row
begin
 if name = null
	and description = null
 	then signal sqlstate '4001' set
	message = 'error'
end if;
end;

update
	products
set
	name = null
where
	id = 1;

-- ЗАДАНИЕ 3 (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность 
-- в которой число равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

DELIMITER //

DROP FUNCTION IF EXISTS fibonachi//
CREATE FUNCTION fibonachi(n INT)
RETURNS TEXT DETERMINISTIC
BEGIN
DECLARE f_0 INT default 0;
    DECLARE f_1 INT DEFAULT 1;
    DECLARE out_fib INT;
    DECLARE i INT;
    DECLARE f_2 INT;

    SET f_0 = 0;
    SET f_1 = 1;
    SET i = 1;

    WHILE (i<=n) DO
        SET f_2 = f_0 + f_1;
        SET f_0 = f_1;
        SET f_1 = f_2;
        SET i = i + 1;
    END WHILE;
    SET out_fib = f_0;
RETURN out_fib;
END//

SELECT fibonachi(10)//















