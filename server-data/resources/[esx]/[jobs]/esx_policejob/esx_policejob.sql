USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'LSPD')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Cadete',20,'{}','{}'),
	('police',1,'officer','Oficial',40,'{}','{}'),
	('police',2,'sergeant','Sargento',60,'{}','{}'),
	('police',3,'lieutenant','Teniente',85,'{}','{}'),
	('police',4,'boss','Comandante',100,'{}','{}')
;

CREATE TABLE `fine_types` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int(11) DEFAULT NULL,
	`category` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types` (label, amount, category) VALUES
	('Mal uso del claxon', 250, 0),
	('Cruzando ilegalmente una línea continua', 300, 0),
	('Conducir en el lado equivocado de la carretera', 500, 0),
	('Giro ilegal en U', 300, 0),
	('Conducir ilegalmente fuera de la carretera', 600, 0),
	('Rechazar una orden legal', 800, 0),
	('Detener ilegalmente un vehículo', 200, 0),
	('Estacionamiento ilegal', 200, 0),
	('No respetar los semáforos', 200, 0),
	('Incumplimiento de la información del vehículo', 200, 0),
	('No parar en una señal de Stop', 150, 0),
	('No parar en una luz roja', 300, 0),
	('Paso ilegal', 100, 0),
	('Conducir un vehículo ilegal', 700, 0),
	('Conducir sin licencia', 1500, 0),
	('Accidente con fuga', 800, 0),
	('Exceso de velocidad por < 5 mph', 200, 0),
	('Exceso de velocidad por 5-15 mph', 250, 0),
	('Exceso de velocidad por 15-30 mph', 300, 0),
	('Exceso de velocidad por > 30 mph', 400, 0),
	('Impedir el flujo de tráfico', 300, 1),
	('Intoxicación pública', 500, 1),
	('Conducta desordenada', 300, 1),
	('Obstrucción de la justicia', 600, 1),
	('Insultos hacia los civiles', 200, 1),
	('Falta de respeto a un oficial', 500, 1),
	('Amenaza verbal hacia un civil', 300, 1),
	('Amenaza verbal hacia un oficial', 600, 1),
	('Proporcionar información falsa', 1500, 1),
	('Intento de corrupción', 1500, 1),
	('Blandiendo un arma en los límites de la ciudad', 200, 2),
	('Blandiendo un arma letal en los límites de la ciudad', 300, 2),
	('Sin licencia de armas de fuego', 1000, 2),
	('Posesión de un arma ilegal', 2000, 2),
	('Posesión de herramientas de robo', 800, 2),
	('Acoso y/o violacion', 5000, 2),
	('Intención de vender, comprar droga', 1500, 2),
	('Fabricación de una sustancia ilegal', 1500, 2),
	('Posesión de una sustancia ilegal', 2000, 2),
	('Secuestro de un Civilan', 15000, 2),
	('Secuestro de un Oficial', 20000, 2),
	('Robo', 15000, 2),
	('Robo de joyeria mano armada', 25000, 2),
	('Robo de banco mano armada', 100000, 2),
	('Robo a un civil', 2000, 3),
	('Robo a un oficial', 5000, 3),
	('Intento de asesinato de un civil', 30000, 3),
	('Intento de asesinato de un oficial', 50000, 3),
	('Asesinato de un civil', 1000000, 3),
	('Asesinato de un oficial', 3000000, 3),
	('Homicidio involuntario', 100000, 3),
	('Fraude', 10000, 2);
;