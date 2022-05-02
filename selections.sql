USE `wallet`;

-- Выборка кусов валют с названиями по алфавиту
SELECT
	c.name 'Криптовалюта',
	e.exchange_rate 'Курс',
	e.exchange_currency 'Валюта обмена'
FROM
	currencies c
JOIN exchange_rates e ON
	c.id = e.currency_id
ORDER BY
	c.name;
	
-- Выборка баланса пользователя по курсу в USD, сортировка по пользователю
SELECT
	u.name 'Пользователь',
	с.short_name 'Криптовалюта',
	FORMAT(uw.balance, 8) 'Баланс в криптовалюте',
	FORMAT(uw.balance * er.exchange_rate, 2) 'Баланс USD'
FROM
	users u
JOIN user_wallet uw ON
	u.id = uw.user_id
JOIN exchange_rates er ON
	er.currency_id = uw.currency_id
JOIN currencies с ON
	с.id = uw.currency_id
ORDER BY
	u.name DESC;
	
-- Выборка транзакций пользователя с id = 1, сначала новые, затем старые
SELECT
	ua.transaction_time 'Вермя',
	u.name 'Имя пользователя',
	tt.type 'Тип транзакции',
	ua.ammount 'Сумма',
	c.short_name 'Криптовалюта'
FROM
	user_activity ua
JOIN users u ON
	u.id = user_id
JOIN transactions_types tt ON
	tt.id = transaction_type_id
JOIN currencies c ON
	c.id = short_name_id
WHERE
	user_id = 1
ORDER BY
 ua.transaction_time DESC;