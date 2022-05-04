USE `wallet`;

DELIMITER //

-- Процедура бана пользователя по имени.
DROP PROCEDURE IF EXISTS ban_user //
CREATE PROCEDURE ban_user (ban VARCHAR(50))
BEGIN
	DELETE FROM users WHERE name = ban;
END //

DELIMITER ;

CALL ban_user('Merl Strosin');

-- Триггер блокировки INSERT при добавлении несовершеннолетнего пользователя.
DROP TRIGGER IF EXISTS block_minor_user;

DELIMITER //

CREATE TRIGGER `block_minor_user` BEFORE UPDATE ON `users`
FOR EACH ROW
BEGIN
	IF (NEW.birthday + INTERVAL 18 YEAR) >= current_date()
	 	THEN SIGNAL SQLSTATE '45000' SET message_text = 'You enter wrong birthday date';
	END IF;
END//

DELIMITER ;

UPDATE users u SET `birthday` = '2010-11-11' WHERE u.id = 11;



