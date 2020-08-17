ALTER TABLE `users`
	ADD `vip` TINYINT(1) NULL DEFAULT '0'
;
----------------------------------------------
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `vehiclevip_categories`;
CREATE TABLE `vehicle_categories`  (
  `name` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `label` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

INSERT INTO `vehiclevip_categories` VALUES ('vip', 'VIP');
-------------------------------------------------------------------
DROP TABLE IF EXISTS `vipvehicles`;
CREATE TABLE `vipvehicles`  (
  `name` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `model` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`model`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

INSERT INTO `vipvehicles` VALUES ('ZentornoVIP', 'police3', 1000000, 'vip');

SET FOREIGN_KEY_CHECKS = 1;