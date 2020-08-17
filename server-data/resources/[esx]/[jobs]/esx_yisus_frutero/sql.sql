INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
	('frutero', 'Frutero/a', 0);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES ('frutero', 0, 'recrue', 'Frutero/a', 10, '{"tshirt_1":15,"tshirt_2":0,"torso_1":95,"torso_2":0,"shoes_1":26,"shoes_2":1,"pants_1":42, "pants_2":0, "arms":48}', '{"tshirt_1":15,"tshirt_2":0,"torso_1":86,"torso_2":0,"shoes_1":28,"shoes_2":0,"pants_1":25, "pants_2":0, "arms":46}');

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('orange', 'Naranja', 0.7, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('apple', 'Manzana', 0.7, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('juice', 'Zumo de frutas', 0.2, 0, 1);
