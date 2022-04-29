-- ОПИСАНИЕ ПРОЕКТА.

-- Текущая база данных предназначена для использования в криптовалютных кошельках на базе вэб-интерфейса (сайта), за основу взят проект ru.cryptonator.com
-- Базой данных решаются задачи по хранению учетных данных пользователей, адресов их кошельков, используемых криптовалют и транзакций.
-- Также база данных хранит историю транзакций, последние логины, варинаты двухфакторной авторизации для пользователя.
-- В базе данных будут реализованы триггеры, например блок регистрации несовершеннолетнего пользователя.

-- TODO Правильно распределить дропы.

DROP TABLE IF EXISTS `user_wallet`;
DROP TABLE IF EXISTS `exchange_rates`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `currencies`;
DROP TABLE IF EXISTS `transactions_types`;

CREATE TABLE `users` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(50) UNIQUE,
	`email` VARCHAR(50) UNIQUE,
	`password_hash` VARCHAR(100),
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX (name, email)
	) COMMENT = 'пользователи';
	
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('1', 'Mr. Milan Buckridge II', 'sipes.nina@example.org', '1147ac0742c5d46af0e618af39706bf18054e19f', '2017-12-02 20:12:32', '2013-02-22 04:16:38');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('2', 'Arlo Bergstrom', 'adonis.boyer@example.org', 'b3f2ec2054fceeadca6001c9c1554a1dc88ae9a8', '1979-07-22 15:40:18', '2021-10-25 13:30:00');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('3', 'Dr. Norberto Beahan', 'qconsidine@example.net', 'a502e0a8882272818c85ee0213f2b64f24393770', '1984-01-19 11:55:30', '1979-06-15 23:45:35');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('4', 'Amiya Oberbrunner', 'dooley.hermina@example.org', '7d94e4c99af1a62ab76c9580b6c90bb1335250b6', '1995-02-27 17:34:57', '1976-08-09 07:37:37');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('5', 'Jaquelin Eichmann Sr.', 'harber.violet@example.com', '53d5129673eb3be662fa0417ffa3dbc5002807a8', '2005-04-07 10:55:29', '2001-03-11 19:34:02');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('6', 'Joaquin Nikolaus', 'carolyne.olson@example.com', 'a6f11beed505854160ac64eb7d44868806492560', '2014-12-21 08:54:18', '2018-09-13 13:13:14');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('7', 'Deonte Hansen', 'jordane.schimmel@example.com', 'ff8aa05ceb4d25343c7a5558ed5fab6443321912', '2005-05-20 21:42:59', '1978-04-02 05:36:16');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('8', 'Merl Strosin', 'shanahan.alaina@example.net', 'cfc27977befd792b767489cac0fa3fff72d022da', '1976-05-02 02:39:52', '1993-02-05 16:23:04');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('9', 'Prof. Grady Ledner', 'juana.pollich@example.com', '88b7d378c287b1092adf0027b4dc2a0a28fa4a2d', '1978-06-27 16:39:42', '2013-12-25 19:26:25');
INSERT INTO `users` (`id`, `name`, `email`, `password_hash`, `created_at`, `updated_at`) VALUES ('10', 'Tevin Hilpert', 'huels.andreane@example.org', 'f06ef7af0c3a52f11173654112eb1f99fbd8f5f6', '1985-06-19 10:09:10', '1977-06-10 06:29:13');

CREATE TABLE `currencies` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(50) UNIQUE,
	`short_name` VARCHAR(50) UNIQUE
	) COMMENT = 'виды криптовалют';

INSERT INTO `currencies` (`id`, `name`, `short_name`) VALUES ('1', 'Bitcoin', 'BTC');
INSERT INTO `currencies` (`id`, `name`, `short_name`) VALUES ('2', 'Ethereum', 'ETH');
INSERT INTO `currencies` (`id`, `name`, `short_name`) VALUES ('3', 'Litecoin', 'LTC');
INSERT INTO `currencies` (`id`, `name`, `short_name`) VALUES ('4', 'Tether', 'USDT');
INSERT INTO `currencies` (`id`, `name`, `short_name`) VALUES ('5', 'Dogecoin', 'DOGE');

CREATE TABLE `exchange_rates` (
	`id` SERIAL PRIMARY KEY,
	`currency_id` BIGINT UNSIGNED NOT NULL,
	`exchange_currency` VARCHAR(50),
	`exchange_rate` DECIMAL(9,2) NOT NULL DEFAULT 0,
	FOREIGN KEY (currency_id) REFERENCES currencies(id)
	) COMMENT = 'курсы криптовалют';

INSERT INTO `exchange_rates` (`id`, `currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('1', '1', 'USD', '37527.88');
INSERT INTO `exchange_rates` (`id`, `currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('2', '2', 'USD', '3008.90');
INSERT INTO `exchange_rates` (`id`, `currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('3', '3', 'USD', '104.18');
INSERT INTO `exchange_rates` (`id`, `currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('4', '4', 'USD', '1');
INSERT INTO `exchange_rates` (`id`, `currency_id`, `exchange_currency`, `exchange_rate`) VALUES ('5', '5', 'USD', '0.16');

-- Выборка кусов валют с названиями по убыванию курса к USD

SELECT
	c.name 'Криптовалюта',
	e.exchange_rate 'Курс',
	e.exchange_currency 'Валюта обмена'
FROM
	currencies c
JOIN exchange_rates e ON
	c.id = e.currency_id
ORDER BY
	e.exchange_rate DESC;

CREATE TABLE `transactions_types` (
	`id` SERIAL PRIMARY KEY,
	`type` VARCHAR(50)
	) COMMENT = 'типы транзакций';

INSERT INTO `transactions_types` (`id`, `type`) VALUES ('1', 'Receive');
INSERT INTO `transactions_types` (`id`, `type`) VALUES ('2', 'Send');
INSERT INTO `transactions_types` (`id`, `type`) VALUES ('3', 'Fee');
INSERT INTO `transactions_types` (`id`, `type`) VALUES ('4', 'Exchange');

CREATE TABLE `user_wallet` (
	`id` SERIAL PRIMARY KEY,
	`user_id` BIGINT UNSIGNED NOT NULL,
	`currency_id` BIGINT UNSIGNED NOT NULL,
	`balance` FLOAT(40,8) NOT NULL DEFAULT 0,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (currency_id) REFERENCES currencies(id)
	) COMMENT = 'кошелек пользователя';

INSERT INTO `user_wallet` (`id`, `user_id`, `currency_id`, `balance`) VALUES ('1', '1', '1', '0.00348790');
INSERT INTO `user_wallet` (`id`, `user_id`, `currency_id`, `balance`) VALUES ('2', '2', '3', '43.74302740');
INSERT INTO `user_wallet` (`id`, `user_id`, `currency_id`, `balance`) VALUES ('3', '3', '5', '10000.00000000');
INSERT INTO `user_wallet` (`id`, `user_id`, `currency_id`, `balance`) VALUES ('4', '4', '1', '1.45830842');
INSERT INTO `user_wallet` (`id`, `user_id`, `currency_id`, `balance`) VALUES ('5', '5', '2', '3.98654332');

-- Выборка баланса первых 100 самых крупных пользователей по курсу в USD
SELECT
	u.name 'Пользователь',
	FORMAT(uw.balance, 8) 'Баланс',
	c.short_name 'Криптовалюта',
	FORMAT(uw.balance * er.exchange_rate, 2) 'Баланс USD'
FROM
	users u
JOIN user_wallet uw ON
	u.id = uw.user_id
JOIN exchange_rates er ON
	er.currency_id = uw.currency_id
JOIN currencies c ON
	c.id = uw.currency_id
ORDER BY
	uw.balance * er.exchange_rate DESC
LIMIT
	100;



