USE vk;

DROP TABLE IF EXISTS higher_education;
CREATE TABLE higher_education (
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	institute VARCHAR(255) COMMENT 'Институт',
	faculty VARCHAR(255) COMMENT 'Факультет',
	education_form VARCHAR(255) COMMENT 'Форма обучения',
	status VARCHAR(255) COMMENT 'Текущий статус учащегося',
	
	FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'Высшее образование';

DROP TABLE IF EXISTS secondary_education;
CREATE TABLE secondary_education (
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	school VARCHAR(255) COMMENT 'Школа',
	year_end VARCHAR(255) COMMENT 'Год окончания',
	
	FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT 'Среднее образование';

DROP TABLE IF EXISTS wall;
CREATE TABLE wall(
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
)COMMENT 'Стена';

SHOW TABLES;

SELECT * FROM higher_education;
SELECT * FROM secondary_education;
SELECT * FROM wall;

