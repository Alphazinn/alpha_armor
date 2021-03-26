USE `es_extended`;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('armor', 'Çelik Yelek', 3, 0, 1);

ALTER TABLE `users` ADD `armor` TINYINT UNSIGNED NOT NULL DEFAULT '0';
