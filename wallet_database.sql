-- ОПИСАНИЕ ПРОЕКТА.

-- Текущая база данных предназначена для использования в криптовалютных кошельках на базе вэб-интерфейса (сайта), за основу взят проект ru.cryptonator.com
-- Базой данных решаются задачи по хранению учетных данных пользователей, адресов их кошельков, используемых криптовалют.
-- Также база данных хранит историю транзакций, последние логины, варинаты двухфакторной авторизации для пользователя.
-- В базе данных будут реализованы триггеры, например блок регистрации несовершеннолетнего пользователя.

-- TODO выборка данных из user_activity
-- TODO проверка оптимизации выборки user_activity (explain)
-- TODO выборки, транзакции и прочее в отдельных скрипт

DROP DATABASE IF EXISTS `wallet`;
CREATE DATABASE IF NOT EXISTS `wallet`;
USE `wallet`;

DROP TABLE IF EXISTS `user_wallet`,
					 `exchange_rates`,
					 `users`,
 					 `currencies`,
					 `transactions_types`,
					 `user_activity`,
					 `user_recent_logins`,
					 `user_security`,
					 `user_devices`;

CREATE TABLE `users` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(50) UNIQUE,
	`email` VARCHAR(50) UNIQUE,
	`birthday` DATE,
	`password_hash` VARCHAR(100),
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX (`name`, `email`)
	) COMMENT = 'пользователи';
	
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Mr. Milan Buckridge II', 'sipes.nina@example.org', '1984-03-19', '1147ac0742c5d46af0e618af39706bf18054e19f', '2017-12-02 20:12:32', '2013-02-22 04:16:38');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Arlo Bergstrom', 'adonis.boyer@example.org', '1992-05-12', 'b3f2ec2054fceeadca6001c9c1554a1dc88ae9a8', '1979-07-22 15:40:18', '2021-10-25 13:30:00');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Dr. Norberto Beahan', 'qconsidine@example.net', '1966-11-27', 'a502e0a8882272818c85ee0213f2b64f24393770', '1984-01-19 11:55:30', '1979-06-15 23:45:35');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Amiya Oberbrunner', 'dooley.hermina@example.org', '1954-03-22', '7d94e4c99af1a62ab76c9580b6c90bb1335250b6', '1995-02-27 17:34:57', '1976-08-09 07:37:37');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Jaquelin Eichmann Sr.', 'harber.violet@example.com', '1985-11-24', '53d5129673eb3be662fa0417ffa3dbc5002807a8', '2005-04-07 10:55:29', '2001-03-11 19:34:02');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Joaquin Nikolaus', 'carolyne.olson@example.com', '2005-12-11', 'a6f11beed505854160ac64eb7d44868806492560', '2014-12-21 08:54:18', '2018-09-13 13:13:14');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Deonte Hansen', 'jordane.schimmel@example.com', '1999-11-01', 'ff8aa05ceb4d25343c7a5558ed5fab6443321912', '2005-05-20 21:42:59', '1978-04-02 05:36:16');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Merl Strosin', 'shanahan.alaina@example.net', '1996-03-11', 'cfc27977befd792b767489cac0fa3fff72d022da', '1976-05-02 02:39:52', '1993-02-05 16:23:04');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Prof. Grady Ledner', 'juana.pollich@example.com', '1956-01-24', '88b7d378c287b1092adf0027b4dc2a0a28fa4a2d', '1978-06-27 16:39:42', '2013-12-25 19:26:25');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Tevin Hilpert', 'huels.andreane@example.org', '1998-02-19', 'f06ef7af0c3a52f11173654112eb1f99fbd8f5f6', '1985-06-19 10:09:10', '1977-06-10 06:29:13');
INSERT INTO `users` (`name`, `email`, `birthday`, `password_hash`, `created_at`, `updated_at`) VALUES ('Bob Mackenzie', 'mack.b@example.org', '2001-11-11', '1147ac0742c5d46af0e618af39706bf18054e19f', '2017-12-02 20:12:32', '2013-02-22 04:16:38');


CREATE TABLE `currencies` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(50) UNIQUE,
	`short_name` VARCHAR(50) UNIQUE
	) COMMENT = 'виды криптовалют';

INSERT INTO `currencies` (`name`, `short_name`) VALUES ('Bitcoin', 'BTC');
INSERT INTO `currencies` (`name`, `short_name`) VALUES ('Ethereum', 'ETH');
INSERT INTO `currencies` (`name`, `short_name`) VALUES ('Litecoin', 'LTC');
INSERT INTO `currencies` (`name`, `short_name`) VALUES ('Tether', 'USDT');
INSERT INTO `currencies` (`name`, `short_name`) VALUES ('Dogecoin', 'DOGE');

CREATE TABLE `exchange_rates` (
	`id` SERIAL PRIMARY KEY,
	`currency_id` BIGINT UNSIGNED NOT NULL,
	`exchange_currency` VARCHAR(50),
	`exchange_rate` DECIMAL(9,2) NOT NULL DEFAULT 0,
	FOREIGN KEY (`currency_id`) REFERENCES `currencies`(`id`)
	) COMMENT = 'курсы криптовалют';

INSERT INTO `exchange_rates` (`currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('1', 'USD', '37527.88');
INSERT INTO `exchange_rates` (`currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('2', 'USD', '3008.90');
INSERT INTO `exchange_rates` (`currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('3', 'USD', '104.18');
INSERT INTO `exchange_rates` (`currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('4', 'USD', '1');
INSERT INTO `exchange_rates` (`currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('5', 'USD', '0.16');
 
CREATE TABLE `transactions_types` (
	`id` SERIAL PRIMARY KEY,
 	`type` VARCHAR(50)
 	) COMMENT = 'типы транзакций';

INSERT INTO `transactions_types` (`type`) VALUES ('Receive');
INSERT INTO `transactions_types` (`type`) VALUES ('Send');
INSERT INTO `transactions_types` (`type`) VALUES ('Fee');
INSERT INTO `transactions_types` (`type`) VALUES ('Exchange');

CREATE TABLE `user_wallet` (
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
	`currency_id` BIGINT UNSIGNED NOT NULL,
	`balance` DOUBLE(65,8) NOT NULL DEFAULT 0,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
	FOREIGN KEY (`currency_id`) REFERENCES `currencies`(`id`)
	) COMMENT = 'кошелек пользователя';

INSERT INTO `user_wallet` (`user_id`, `currency_id`, `balance`) VALUES ('1', '1', '0.00348790');
INSERT INTO `user_wallet` (`user_id`, `currency_id`, `balance`) VALUES ('2', '4', '0.95423713');
INSERT INTO `user_wallet` (`user_id`, `currency_id`, `balance`) VALUES ('2', '1', '1000');
INSERT INTO `user_wallet` (`user_id`, `currency_id`, `balance`) VALUES ('3', '2', '11.56344567');
INSERT INTO `user_wallet` (`user_id`, `currency_id`, `balance`) VALUES ('4', '4', '0');
INSERT INTO `user_wallet` (`user_id`, `currency_id`, `balance`) VALUES ('5', '3', '53.85638204');

CREATE TABLE `user_activity` (
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
	`transaction_time` DATETIME NOT NULL,
	`transaction_type_id` BIGINT UNSIGNED NOT NULL,
	`ammount` DOUBLE(65,8) NOT NULL DEFAULT 0,
	`short_name_id` BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
	FOREIGN KEY (`transaction_type_id`) REFERENCES `transactions_types`(`id`),
	FOREIGN KEY (`short_name_id`) REFERENCES `currencies`(`id`)
	) COMMENT = 'Транзакции пользователей';

INSERT INTO `user_activity` (`user_id`, `transaction_time`, `transaction_type_id`, `ammount`, `short_name_id`) VALUES ('1', '2022-05-02 10:50:23', '2', '3.02252035', '1');
INSERT INTO `user_activity` (`user_id`, `transaction_time`, `transaction_type_id`, `ammount`, `short_name_id`) VALUES ('1', '2022-05-02 10:51:39', '3', '0.00004021', '1');
INSERT INTO `user_activity` (`user_id`, `transaction_time`, `transaction_type_id`, `ammount`, `short_name_id`) VALUES ('1', '2022-02-01 11:44:01', '1', '1.90512135', '1');
INSERT INTO `user_activity` (`user_id`, `transaction_time`, `transaction_type_id`, `ammount`, `short_name_id`) VALUES ('9', '2022-01-17 15:55:33', '1', '100.15320001', '5');
INSERT INTO `user_activity` (`user_id`, `transaction_time`, `transaction_type_id`, `ammount`, `short_name_id`) VALUES ('1', '2022-01-14 02:07:44', '1', '0.00256398', '2');

CREATE TABLE `user_recent_logins` (
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
 	`date` DATETIME NOT NULL,
 	`device` VARCHAR(100),
 	`ip_address` VARCHAR(20),
 	`city` VARCHAR(100),
 	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
 	INDEX(`ip_address`)
 	) COMMENT = 'История входов';
 
INSERT INTO `user_recent_logins` (`date`, `user_id`, `device`, `ip_address`, `city`) VALUES ('2022-05-02 10:50:23', '1', 'Windows 10', '192.168.0.1', 'Moscow');
INSERT INTO `user_recent_logins` (`date`, `user_id`, `device`, `ip_address`, `city`) VALUES ('2022-05-02 10:51:39', '6', 'android 8.1', '192.168.13.100', 'Moscow');
INSERT INTO `user_recent_logins` (`date`, `user_id`, `device`, `ip_address`, `city`) VALUES ('2022-02-01 11:44:01', '4', 'Windows 7', '10.38.0.55', 'Baku');
INSERT INTO `user_recent_logins` (`date`, `user_id`, `device`, `ip_address`, `city`) VALUES ('2022-01-17 15:55:33', '2', 'Linux', '192.168.0.55', 'Moscow');
INSERT INTO `user_recent_logins` (`date`, `user_id`, `device`, `ip_address`, `city`) VALUES ('2022-01-14 02:07:44', '7', 'Windows 10', '11.155.255.0', 'Beirut');

CREATE TABLE `user_security` (
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
 	`type` VARCHAR(100),
 	`status` BOOLEAN,
 	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
 	) COMMENT = 'Безопасность';
 
INSERT INTO `user_security` (`user_id`, `type`, `status`) VALUES ('1', 'Goole 2FA', TRUE);
INSERT INTO `user_security` (`user_id`, `type`, `status`) VALUES ('1', 'e-mail', TRUE);
INSERT INTO `user_security` (`user_id`, `type`, `status`) VALUES ('6', 'sms', FALSE);
INSERT INTO `user_security` (`user_id`, `type`, `status`) VALUES ('9', 'Goole 2FA', FALSE);
INSERT INTO `user_security` (`user_id`, `type`, `status`) VALUES ('1', 'sms', FALSE);

-- DROP TABLE `user_security`;

CREATE TABLE `user_notifications` (
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
 	`email` BOOLEAN,
 	`sms` BOOLEAN,
 	`telegram` BOOLEAN,
 	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
 	) COMMENT = 'Оповещения';
 
INSERT INTO `user_notifications` (`user_id`, `email`, `sms`, `telegram`) VALUES ('1', TRUE, FALSE, TRUE);
INSERT INTO `user_notifications` (`user_id`, `email`, `sms`, `telegram`) VALUES ('2', TRUE, FALSE, TRUE);
INSERT INTO `user_notifications` (`user_id`, `email`, `sms`, `telegram`) VALUES ('3', FALSE, FALSE, TRUE);
INSERT INTO `user_notifications` (`user_id`, `email`, `sms`, `telegram`) VALUES ('4', TRUE, FALSE, TRUE);
INSERT INTO `user_notifications` (`user_id`, `email`, `sms`, `telegram`) VALUES ('5', FALSE, FALSE, TRUE);

SELECT * FROM users;
	
	