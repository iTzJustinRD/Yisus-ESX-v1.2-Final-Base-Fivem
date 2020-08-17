/*
 Navicat Premium Data Transfer

 Source Server         : Local
 Source Server Type    : MySQL
 Source Server Version : 100408
 Source Host           : localhost:3306
 Source Schema         : essentialmode

 Target Server Type    : MySQL
 Target Server Version : 100408
 File Encoding         : 65001

 Date: 21/03/2020 20:15:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for owned_vehicles
-- ----------------------------
DROP TABLE IF EXISTS `owned_vehicles`;
CREATE TABLE `owned_vehicles`  (
  `vehicle` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `owner` varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `state` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the vehicle',
  `stored` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'State of the vehicle',
  `garage_name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'Garage_Centre',
  `pound` tinyint(1) NOT NULL DEFAULT 0,
  `vehiclename` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'vehicle',
  `plate` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `type` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'car',
  `job` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`plate`) USING BTREE,
  INDEX `vehsowned`(`owner`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of owned_vehicles
-- ----------------------------
INSERT INTO `owned_vehicles` VALUES ('{\"modHydrolic\":-1,\"modHood\":-1,\"modSuspension\":-1,\"modLivery\":-1,\"windowTint\":-1,\"engineHealth\":0.0,\"modBrakes\":-1,\"modSeats\":-1,\"modTurbo\":false,\"modTank\":-1,\"modAirFilter\":-1,\"modAPlate\":-1,\"modTrunk\":-1,\"modFrontWheels\":-1,\"modSideSkirt\":-1,\"modRoof\":-1,\"modShifterLeavers\":-1,\"wheelColor\":27,\"modDoorSpeaker\":-1,\"modFrame\":-1,\"neonColor\":[255,0,255],\"modTransmission\":-1,\"modDial\":-1,\"modOrnaments\":-1,\"modDashboard\":-1,\"pearlescentColor\":27,\"modTrimA\":-1,\"modVanityPlate\":-1,\"modWindows\":-1,\"modXenon\":false,\"modTrimB\":-1,\"modEngine\":-1,\"modGrille\":-1,\"modRightFender\":-1,\"extras\":[],\"modStruts\":-1,\"modRearBumper\":-1,\"model\":-1670998136,\"color2\":1,\"modEngineBlock\":-1,\"neonEnabled\":[false,false,false,false],\"color1\":6,\"modBackWheels\":-1,\"modFrontBumper\":-1,\"modArmor\":-1,\"plateIndex\":0,\"fuelLevel\":41.0,\"health\":4.2038953929745e-43,\"modSmokeEnabled\":false,\"modSpeakers\":-1,\"modAerials\":-1,\"modFender\":-1,\"modPlateHolder\":-1,\"modExhaust\":-1,\"wheels\":6,\"modSteeringWheel\":-1,\"xenonColor\":255,\"modSpoilers\":-1,\"plate\":\"YP292NZZ\",\"modHorns\":-1,\"bodyHealth\":763.0,\"dirtLevel\":11.4,\"tyreSmokeColor\":[255,255,255],\"modArchCover\":-1}', 'dc152b1b20e2cd63ab687fc7d4db0df65ee12a24', 0, 0, 'Centro', 0, 'vehicle', 'YP292NZZ', 'car', NULL);

SET FOREIGN_KEY_CHECKS = 1;
