USE `wallet`;

-- Представление которое показывает когда и с какого IP и машины входил пользователь, сортировка по времени.
DROP VIEW IF EXISTS recent_logins_view;
CREATE VIEW recent_logins_view AS
SELECT
	u.name 'Имя пользователя',
	url.date 'Дата входа',
	url.device 'Устройство пользователя', 
	url.ip_address 'IP адресс',
	url.city 'Город'
FROM
	users u
JOIN user_recent_logins url ON
	u.id = url.user_id
ORDER BY
	url.date DESC;

SELECT * FROM recent_logins_view;

-- Представление которое показвает какие системы безопасности подключены у пользователя.
DROP VIEW IF EXISTS user_security_view;
CREATE VIEW user_security_view AS
SELECT
	u.name 'Имя пользователя',
	us.TYPE 'Тип безопасности',
	(SELECT IF(us.status = 1, 'Включено', 'Отключено')) 'Статус'
FROM
	users u
JOIN user_security us ON
	u.id = us.user_id
ORDER BY
	u.name DESC;

SELECT * FROM user_security_view;
