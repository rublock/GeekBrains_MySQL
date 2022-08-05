
DROP TABLE IF EXISTS `catalogs`;

CREATE TABLE `catalogs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Разделы интернет-магазина';

INSERT INTO `catalogs` (`id`, `name`) VALUES ('1', 'Процессоры');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('2', 'Материнские платы');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('3', 'Видеокарты');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('4', 'Жесткие диски');
INSERT INTO `catalogs` (`id`, `name`) VALUES ('5', 'Оперативная память');

DROP TABLE IF EXISTS `discounts`;

CREATE TABLE `discounts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `discount` float unsigned DEFAULT NULL COMMENT 'Величина скидки от 0.0 до 1.0',
  `started_at` datetime DEFAULT NULL,
  `finished_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`),
  KEY `index_of_product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Скидки';

INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('1', 1, 1, '3', '2015-05-24 21:37:50', '2010-10-10 02:06:15', '2020-05-07 07:53:34', '2006-05-18 12:15:52');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('2', 2, 2, '12', '1993-01-20 00:24:47', '2018-06-24 00:51:29', '2005-11-13 06:37:49', '2020-12-02 20:34:35');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('3', 3, 3, '44', '2008-04-26 09:08:27', '1981-07-07 13:40:06', '2013-05-31 19:51:27', '2020-10-17 19:19:47');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('4', 4, 4, '3', '2015-08-09 02:23:32', '1986-04-11 16:14:44', '1984-05-26 12:21:54', '1995-02-04 03:02:06');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('5', 5, 5, '13', '1986-06-17 00:34:38', '1974-08-28 17:25:06', '1991-01-29 07:01:22', '2021-07-06 16:01:03');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('6', 6, 6, '44', '2008-09-13 02:03:27', '1987-07-19 18:15:11', '1983-06-27 12:28:29', '1983-06-18 00:20:11');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('7', 1, 7, '9', '2014-07-16 05:42:43', '2005-01-03 03:45:07', '2016-07-28 21:03:07', '2021-01-16 21:42:19');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('8', 2, 1, '22', '1977-09-14 22:00:33', '2008-09-01 15:55:08', '2010-08-29 16:27:35', '1990-06-22 22:11:35');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('9', 3, 2, '8', '1987-10-08 07:07:27', '2005-12-31 11:38:31', '1973-06-16 18:07:08', '1995-06-26 16:21:51');
INSERT INTO `discounts` (`id`, `user_id`, `product_id`, `discount`, `started_at`, `finished_at`, `created_at`, `updated_at`) VALUES ('10', 4, 3, '12', '1989-10-24 21:39:45', '1974-09-29 20:47:57', '2005-07-28 14:37:35', '1996-07-29 07:57:08');

DROP TABLE IF EXISTS `orders`;

CREATE TABLE `orders` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Заказы';

INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('1', 1, '2021-11-12 00:01:53', '1970-02-13 04:02:39');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('2', 2, '2009-01-18 02:53:55', '1989-12-04 21:55:45');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('3', 3, '2015-03-10 13:04:47', '1998-06-25 09:22:25');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('4', 4, '2007-09-16 16:13:14', '2017-08-26 03:28:11');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('5', 2, '1979-08-30 15:15:05', '2019-03-29 00:32:40');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('6', 1, '1978-10-25 16:51:46', '2020-07-05 06:57:54');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('7', 1, '1991-08-10 02:11:04', '1991-06-23 17:48:02');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('8', 2, '1992-07-22 10:39:26', '1971-11-22 21:22:59');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('9', 3, '2008-07-10 16:57:28', '1983-01-26 14:51:26');
INSERT INTO `orders` (`id`, `user_id`, `created_at`, `updated_at`) VALUES ('10', 4, '2004-11-24 04:26:03', '1981-05-08 12:10:21');

DROP TABLE IF EXISTS `orders_products`;

CREATE TABLE `orders_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `total` int(10) unsigned DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Состав заказа';

INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('1', 1, 1, 1, '1970-07-27 07:52:03', '1984-09-15 03:04:43');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('2', 2, 2, 1, '2017-10-08 16:41:09', '2012-07-13 03:30:21');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('3', 3, 3, 1, '1996-07-07 19:38:53', '1978-02-10 06:34:28');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('4', 4, 4, 1, '2002-03-06 04:38:48', '1977-05-12 07:28:35');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('5', 5, 5, 1, '1982-10-26 04:14:35', '2020-01-07 04:08:07');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('6', 6, 6, 1, '2003-07-09 14:36:19', '1974-08-18 04:51:44');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('7', 7, 7, 1, '1979-08-22 19:05:52', '1990-09-15 20:53:43');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('8', 8, 1, 1, '2015-04-27 00:05:50', '1999-12-03 06:10:19');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('9', 9, 2, 1, '2002-04-26 14:48:56', '1982-09-18 12:56:32');
INSERT INTO `orders_products` (`id`, `order_id`, `product_id`, `total`, `created_at`, `updated_at`) VALUES ('10', 10, 3, 1, '1989-10-21 03:32:36', '1970-02-09 08:22:59');

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `catalog_id` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `index_of_catalog_id` (`catalog_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Товарные позиции';

INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('1', 'Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '7890.00', 1, '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('2', 'Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '12700.00', 1, '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('3', 'AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '4780.00', 1, '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('4', 'AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '7120.00', 1, '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('5', 'ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', '19310.00', 2, '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('6', 'Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', '4790.00', 2, '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `products` (`id`, `name`, `description`, `price`, `catalog_id`, `created_at`, `updated_at`) VALUES ('7', 'MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', '5060.00', 2, '2022-04-14 06:59:25', '2022-04-14 06:59:25');

DROP TABLE IF EXISTS `rubrics`;

CREATE TABLE `rubrics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Разделы интернет-магазина';

INSERT INTO `rubrics` (`id`, `name`) VALUES ('1', 'Видеокарты');
INSERT INTO `rubrics` (`id`, `name`) VALUES ('2', 'Память');

DROP TABLE IF EXISTS `storehouses`;

CREATE TABLE `storehouses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Название',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Склады';

INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('1', 'voluptatum', '1987-01-13 17:44:41', '2001-07-30 18:20:17');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('2', 'maiores', '1999-06-23 17:53:04', '1970-05-04 14:45:27');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('3', 'modi', '1995-10-18 06:30:42', '1971-08-30 08:59:43');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('4', 'illum', '1996-01-13 23:08:04', '2018-05-18 04:24:53');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('5', 'non', '1974-01-12 06:56:20', '2019-12-01 16:49:54');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('6', 'repudiandae', '1996-05-02 14:03:21', '2004-07-08 06:44:29');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('7', 'ipsam', '1986-01-18 05:05:05', '1997-08-05 11:19:00');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('8', 'vitae', '1991-03-06 12:34:54', '2003-05-15 04:09:01');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('9', 'itaque', '1973-11-28 16:51:02', '2013-05-18 22:36:32');
INSERT INTO `storehouses` (`id`, `name`, `created_at`, `updated_at`) VALUES ('10', 'adipisci', '1984-02-12 12:50:16', '1975-12-07 23:55:40');

DROP TABLE IF EXISTS `storehouses_products`;

CREATE TABLE `storehouses_products` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(10) unsigned DEFAULT NULL,
  `product_id` int(10) unsigned DEFAULT NULL,
  `value` int(10) unsigned DEFAULT NULL COMMENT 'Запас товарной позиции на складе',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Запасы на складе';

INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('1', 1, 1, 689, '2013-04-22 06:39:50', '1973-12-26 22:14:18');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('2', 2, 2, 193, '2006-11-23 20:16:48', '1982-03-25 14:31:55');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('3', 3, 3, 788, '1979-12-22 03:07:55', '1977-07-30 19:12:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('4', 4, 4, 409, '1991-06-05 20:51:51', '2019-09-06 14:14:01');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('5', 5, 5, 649, '1971-03-03 00:08:55', '2010-08-20 06:46:58');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('6', 6, 6, 907, '1971-09-08 07:48:59', '2018-10-03 13:42:46');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('7', 7, 7, 356, '1985-07-01 16:52:03', '1992-12-28 08:40:39');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('8', 8, 1, 766, '1987-12-03 04:24:28', '2007-10-12 11:12:43');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('9', 9, 2, 634, '1980-08-29 06:43:33', '1987-04-05 23:09:47');
INSERT INTO `storehouses_products` (`id`, `storehouse_id`, `product_id`, `value`, `created_at`, `updated_at`) VALUES ('10', 10, 3, 941, '1981-05-24 21:01:34', '2008-05-08 12:02:25');

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Покупатели';

INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('1', 'Геннадий', '1990-10-05', '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('2', 'Наталья', '1984-11-12', '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('3', 'Александр', '1985-05-20', '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('4', 'Сергей', '1988-02-14', '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('5', 'Иван', '1998-01-12', '2022-04-14 06:59:25', '2022-04-14 06:59:25');
INSERT INTO `users` (`id`, `name`, `birthday_at`, `created_at`, `updated_at`) VALUES ('6', 'Мария', '1992-08-29', '2022-04-14 06:59:25', '2022-04-14 06:59:25');

-- ЗАДАНИЕ 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT id, name FROM users WHERE id IN (SELECT user_id FROM orders);

-- ЗАДАНИЕ 2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT 
	products.name,
	(SELECT 
		catalogs.name 
	FROM 
		catalogs 
	WHERE 
		catalogs.id = products.catalog_id) AS 'catalogs_name' 
FROM 
	products;

-- ЗАДАНИЕ 3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights` (
  `id` SERIAL,
  `from` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Откуда',
  `to` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Куда'
);

INSERT INTO `flights` (`id`, `from`, `to`) VALUES (NULL, 'moscow', 'omsk');
INSERT INTO `flights` (`id`, `from`, `to`) VALUES (NULL, 'novgorod', 'kazan');
INSERT INTO `flights` (`id`, `from`, `to`) VALUES (NULL, 'irkutsk', 'moscow');
INSERT INTO `flights` (`id`, `from`, `to`) VALUES (NULL, 'omsk', 'irkutsk');
INSERT INTO `flights` (`id`, `from`, `to`) VALUES (NULL, 'moscow', 'kazan');

DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ENG',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'RUS'
);

INSERT INTO `cities` (`label`, `name`) VALUES ('moscow', 'Москва');
INSERT INTO `cities` (`label`, `name`) VALUES ('novgorod', 'Новгород');
INSERT INTO `cities` (`label`, `name`) VALUES ('irkutsk', 'Иркутск');
INSERT INTO `cities` (`label`, `name`) VALUES ('omsk', 'Омск');
INSERT INTO `cities` (`label`, `name`) VALUES ('kazan', 'Казань');

SELECT
	(SELECT
		cities.name
	FROM
		cities
	WHERE
		cities.label = flights.from) AS 'russian_from',
	(SELECT
		cities.name
	FROM
		cities
	WHERE
		cities.label = flights.to) AS 'russian_to'
FROM
	flights;
	
	






	
	
	
	
	
	