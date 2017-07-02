/*
Navicat MySQL Data Transfer

Source Server         : Local
Source Server Version : 50718
Source Host           : localhost:3306
Source Database       : gta5_gamemode_essential

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-07-02 02:47:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for autoecole
-- ----------------------------
DROP TABLE IF EXISTS `autoecole`;
CREATE TABLE `autoecole` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`vehicle`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`end_x`  decimal(65,3) NOT NULL ,
`end_y`  decimal(65,3) NOT NULL ,
`end_z`  decimal(65,3) NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=4

;

-- ----------------------------
-- Records of autoecole
-- ----------------------------
BEGIN;
INSERT INTO `autoecole` VALUES ('1', 'Permis Voiture', 'blista', '141.180', '6634.790', '31.636'), ('2', 'Permis Moto', 'akuma', '646.875', '584.900', '128.911'), ('3', 'Permis Poids Lourd', 'pounder', '1268.240', '-3186.820', '5.903');
COMMIT;

-- ----------------------------
-- Table structure for bans
-- ----------------------------
DROP TABLE IF EXISTS `bans`;
CREATE TABLE `bans` (
`id`  int(10) UNSIGNED NOT NULL AUTO_INCREMENT ,
`banned`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' ,
`banner`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`reason`  varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' ,
`expires`  datetime NOT NULL ,
`timestamp`  datetime NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of bans
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for coordinates
-- ----------------------------
DROP TABLE IF EXISTS `coordinates`;
CREATE TABLE `coordinates` (
`identifier`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`x`  double NULL DEFAULT NULL ,
`y`  double NULL DEFAULT NULL ,
`z`  double NULL DEFAULT NULL ,
PRIMARY KEY (`identifier`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of coordinates
-- ----------------------------
BEGIN;
INSERT INTO `coordinates` VALUES ('steam:11000010947456d', '-837.2211303710938', '-405.06048583984375', '31.471559524536133');
COMMIT;

-- ----------------------------
-- Table structure for items
-- ----------------------------
DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
`id`  int(11) UNSIGNED NOT NULL AUTO_INCREMENT ,
`libelle`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL ,
`value`  int(11) NOT NULL DEFAULT 0 ,
`type`  int(11) NOT NULL DEFAULT 0 ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=28

;

-- ----------------------------
-- Records of items
-- ----------------------------
BEGIN;
INSERT INTO `items` VALUES ('1', 'Bouteille d\'eau', '20', '1'), ('2', 'Sandwich', '20', '2'), ('3', 'Filet Mignon', '20', '2'), ('4', 'Cannabis', '0', '0'), ('5', 'Cannabis roulé', '0', '0'), ('6', 'Feuille Coka', '0', '0'), ('7', 'Coka', '0', '0'), ('8', 'Coka', '0', '0'), ('9', 'Ephedrine ', '0', '0'), ('10', 'Matière illégale', '0', '0'), ('11', 'Matière illégale', '0', '0'), ('12', 'Meth', '0', '0'), ('13', 'Organe', '0', '0'), ('14', 'Organe emballé', '0', '0'), ('15', 'Organe analysé', '0', '0'), ('16', 'Organe livrable', '0', '0'), ('17', 'Cuivre', '0', '0'), ('18', 'Fer', '0', '0'), ('19', 'Diamants', '0', '0'), ('20', 'Cuivre traité', '0', '0'), ('21', 'Fer traité', '0', '0'), ('22', 'Diamants traité', '0', '0'), ('23', 'Roche', '0', '0'), ('24', 'Roche traitée', '0', '0'), ('25', 'Poisson', '5', '2'), ('26', 'Corps', '0', '0'), ('27', 'Corps traité', '0', '0');
COMMIT;

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
`job_id`  int(11) NOT NULL AUTO_INCREMENT ,
`job_name`  varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`salary`  int(11) NOT NULL DEFAULT 500 ,
PRIMARY KEY (`job_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=14

;

-- ----------------------------
-- Records of jobs
-- ----------------------------
BEGIN;
INSERT INTO `jobs` VALUES ('1', 'Sans Emploi', '0'), ('2', 'Nettoyeur de piscine', '0'), ('3', 'Éboueur', '0'), ('4', 'Mineur', '0'), ('5', 'Chauffeur de taxi', '500'), ('6', 'Livreur de bois', '0'), ('7', 'Livreur de citerne', '0'), ('8', 'Livreur de conteneur', '0'), ('9', 'Livreur de médicament', '0'), ('10', 'Policier', '0'), ('11', 'Fossoyeur', '0'), ('12', 'Préposé à la morgue', '0'), ('13', 'Ambulancier', '500');
COMMIT;

-- ----------------------------
-- Table structure for licences
-- ----------------------------
DROP TABLE IF EXISTS `licences`;
CREATE TABLE `licences` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`price`  int(255) NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=5

;

-- ----------------------------
-- Records of licences
-- ----------------------------
BEGIN;
INSERT INTO `licences` VALUES ('1', 'de conduire', '0'), ('2', 'moto', '0'), ('3', 'de Poids Lourd', '0'), ('4', 'de port d\'arme', '0');
COMMIT;

-- ----------------------------
-- Table structure for outfits
-- ----------------------------
DROP TABLE IF EXISTS `outfits`;
CREATE TABLE `outfits` (
`identifier`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`skin`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'mp_m_freemode_01' ,
`face`  int(11) NOT NULL DEFAULT 0 ,
`face_text`  int(11) NOT NULL DEFAULT 0 ,
`hair`  int(11) NOT NULL DEFAULT 0 ,
`hair_text`  int(11) NOT NULL DEFAULT 0 ,
`pants`  int(11) NOT NULL DEFAULT 0 ,
`pants_text`  int(11) NOT NULL DEFAULT 0 ,
`shoes`  int(11) NOT NULL DEFAULT 0 ,
`shoes_text`  int(11) NOT NULL DEFAULT 0 ,
`torso`  int(11) NOT NULL DEFAULT 0 ,
`torso_text`  int(11) NOT NULL DEFAULT 0 ,
`shirt`  int(11) NOT NULL DEFAULT 0 ,
`shirt_text`  int(11) NOT NULL DEFAULT 0 ,
`three`  int(11) NOT NULL DEFAULT 0 ,
`three_text`  int(11) NOT NULL DEFAULT 0 ,
`seven`  int(11) NOT NULL DEFAULT 0 ,
`seven_text`  int(11) NOT NULL DEFAULT 0 ,
`haircolor`  int(11) NOT NULL DEFAULT 0 ,
`haircolor_text`  int(11) NOT NULL DEFAULT 0 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of outfits
-- ----------------------------
BEGIN;
INSERT INTO `outfits` VALUES ('steam:11000010947456d', 'mp_m_freemode_01', '0', '0', '10', '0', '13', '0', '10', '0', '72', '2', '10', '0', '33', '0', '12', '2', '0', '4');
COMMIT;

-- ----------------------------
-- Table structure for phonebook
-- ----------------------------
DROP TABLE IF EXISTS `phonebook`;
CREATE TABLE `phonebook` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`pidentifier`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' ,
`phonenumber`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of phonebook
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for police
-- ----------------------------
DROP TABLE IF EXISTS `police`;
CREATE TABLE `police` (
`police_id`  int(11) NOT NULL AUTO_INCREMENT ,
`police_name`  varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`salary`  int(11) NOT NULL DEFAULT 500 ,
PRIMARY KEY (`police_id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=9

;

-- ----------------------------
-- Records of police
-- ----------------------------
BEGIN;
INSERT INTO `police` VALUES ('1', 'Cadet', '500'), ('2', 'Brigadier', '500'), ('3', 'Sergent', '500'), ('4', 'Lieutenant', '500'), ('5', 'Capitaine', '500'), ('6', 'Commandant', '500'), ('7', 'Colonel', '500'), ('8', 'Rien', '0');
COMMIT;

-- ----------------------------
-- Table structure for user_appartement
-- ----------------------------
DROP TABLE IF EXISTS `user_appartement`;
CREATE TABLE `user_appartement` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`identifier`  varchar(60) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`name`  varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL ,
`price`  int(11) NOT NULL ,
`money`  int(11) NOT NULL DEFAULT 0 ,
`dirtymoney`  int(11) NOT NULL DEFAULT 0 ,
PRIMARY KEY (`id`)
)
ENGINE=MyISAM
DEFAULT CHARACTER SET=latin1 COLLATE=latin1_swedish_ci
AUTO_INCREMENT=10

;

-- ----------------------------
-- Records of user_appartement
-- ----------------------------
BEGIN;
INSERT INTO `user_appartement` VALUES ('9', 'steam:11000010947456d', 'Condo de Luxe 14', '100000', '0', '0');
COMMIT;

-- ----------------------------
-- Table structure for user_boat
-- ----------------------------
DROP TABLE IF EXISTS `user_boat`;
CREATE TABLE `user_boat` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`identifier`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`boat_name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_model`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_price`  int(60) NULL DEFAULT NULL ,
`boat_plate`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_state`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_colorprimary`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_colorsecondary`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_pearlescentcolor`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`boat_wheelcolor`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
PRIMARY KEY (`id`),
UNIQUE INDEX `boat_plate` (`boat_plate`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of user_boat
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_inventory
-- ----------------------------
DROP TABLE IF EXISTS `user_inventory`;
CREATE TABLE `user_inventory` (
`user_id`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' ,
`item_id`  int(11) UNSIGNED NOT NULL ,
`quantity`  int(11) NULL DEFAULT NULL ,
PRIMARY KEY (`user_id`, `item_id`),
FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
INDEX `item_id` (`item_id`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci

;

-- ----------------------------
-- Records of user_inventory
-- ----------------------------
BEGIN;
INSERT INTO `user_inventory` VALUES ('steam:11000010947456d', '1', '0'), ('steam:11000010947456d', '2', '0'), ('steam:11000010947456d', '3', '0'), ('steam:11000010947456d', '4', '0'), ('steam:11000010947456d', '5', '0'), ('steam:11000010947456d', '6', '0'), ('steam:11000010947456d', '7', '0'), ('steam:11000010947456d', '8', '0'), ('steam:11000010947456d', '9', '0'), ('steam:11000010947456d', '10', '0'), ('steam:11000010947456d', '11', '0'), ('steam:11000010947456d', '12', '0'), ('steam:11000010947456d', '13', '0'), ('steam:11000010947456d', '14', '0'), ('steam:11000010947456d', '15', '0'), ('steam:11000010947456d', '16', '0'), ('steam:11000010947456d', '17', '0'), ('steam:11000010947456d', '18', '0'), ('steam:11000010947456d', '19', '0'), ('steam:11000010947456d', '20', '0'), ('steam:11000010947456d', '21', '0'), ('steam:11000010947456d', '22', '0'), ('steam:11000010947456d', '23', '0'), ('steam:11000010947456d', '24', '0'), ('steam:11000010947456d', '25', '0'), ('steam:11000010947456d', '26', '0'), ('steam:11000010947456d', '27', '0');
COMMIT;

-- ----------------------------
-- Table structure for user_licence
-- ----------------------------
DROP TABLE IF EXISTS `user_licence`;
CREATE TABLE `user_licence` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`identifier`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`licence_id`  int(255) NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of user_licence
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `user_vehicle`;
CREATE TABLE `user_vehicle` (
`id`  int(10) NOT NULL AUTO_INCREMENT ,
`identifier`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`vehicle_name`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_model`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_price`  int(60) NULL DEFAULT NULL ,
`vehicle_plate`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_state`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_colorprimary`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_colorsecondary`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_pearlescentcolor`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_wheelcolor`  varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_plateindex`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neoncolor1`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neoncolor2`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neoncolor3`  varchar(25) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_windowtint`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_wheeltype`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods0`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods1`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods2`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods3`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods4`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods5`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods6`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods7`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods8`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods9`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods10`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods11`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods12`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods13`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods14`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods15`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods16`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_turbo`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off' ,
`vehicle_tiresmoke`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off' ,
`vehicle_xenon`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off' ,
`vehicle_mods23`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_mods24`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neon0`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neon1`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neon2`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_neon3`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_bulletproof`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_smokecolor1`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_smokecolor2`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_smokecolor3`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL ,
`vehicle_modvariation`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'off' ,
PRIMARY KEY (`id`),
UNIQUE INDEX `vehicle_plate` (`vehicle_plate`) USING BTREE 
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Records of user_vehicle
-- ----------------------------
BEGIN;
INSERT INTO `user_vehicle` VALUES ('1', 'steam:11000010947456d', 'Dominator', 'dominator', '35000', 'CTZN456D', 'Rentré', '138', '12', '4', '156', '1', '255', '0', '255', '1', '1', '0', '-1', '-1', '-1', '0', '0', '-1', '-1', '-1', '-1', '-1', '-1', '2', '2', '-1', '3', '4', 'on', 'on', 'on', '5', '-1', 'off', 'off', 'off', 'off', 'on', '1', '1', '1', 'on');
COMMIT;

-- ----------------------------
-- Table structure for user_weapons
-- ----------------------------
DROP TABLE IF EXISTS `user_weapons`;
CREATE TABLE `user_weapons` (
`ID`  int(10) NOT NULL AUTO_INCREMENT ,
`identifier`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`weapon_model`  varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL ,
`withdraw_cost`  int(10) NOT NULL ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=1

;

-- ----------------------------
-- Records of user_weapons
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
`ID`  int(11) NOT NULL AUTO_INCREMENT ,
`identifier`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' ,
`group`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' ,
`permission_level`  int(11) NOT NULL DEFAULT 0 ,
`money`  double NOT NULL DEFAULT 0 ,
`bankbalance`  int(32) NULL DEFAULT 0 ,
`job`  int(11) NULL DEFAULT 1 ,
`police`  int(11) NULL DEFAULT 0 ,
`enService`  int(11) NULL DEFAULT 0 ,
`dirtymoney`  double(11,0) NOT NULL DEFAULT 0 ,
`isFirstConnection`  int(11) NULL DEFAULT 1 ,
`nom`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' ,
`prenom`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' ,
`telephone`  varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' ,
`player_state`  int(255) NOT NULL DEFAULT 0 ,
PRIMARY KEY (`ID`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=2

;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'steam:11000010947456d', 'user', '0', '764686', '5000000', '1', '0', '0', '0', '1', 'Johns', 'Connor', '654-7490', '0');
COMMIT;

-- ----------------------------
-- Table structure for vehicles
-- ----------------------------
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE `vehicles` (
`id`  int(11) NOT NULL AUTO_INCREMENT ,
`name`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
`price`  int(255) NOT NULL ,
`model`  varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARACTER SET=utf8 COLLATE=utf8_general_ci
AUTO_INCREMENT=164

;

-- ----------------------------
-- Records of vehicles
-- ----------------------------
BEGIN;
INSERT INTO `vehicles` VALUES ('1', 'Blista', '15000', 'blista'), ('2', 'Brioso R/A', '155000', 'brioso'), ('3', 'Dilettante', '25000', 'Dilettante'), ('4', 'Issi', '18000', 'issi2'), ('5', 'Panto', '85000', 'panto'), ('6', 'Prairie', '30000', 'prairie'), ('7', 'Rhapsody', '120000', 'rhapsody'), ('8', 'Cognoscenti Cabrio', '180000', 'cogcabrio'), ('9', 'Exemplar', '200000', 'exemplar'), ('10', 'F620', '80000', 'f620'), ('11', 'Felon', '90000', 'felon'), ('12', 'Felon GT', '95000', 'felon2'), ('13', 'Jackal', '60000', 'jackal'), ('14', 'Oracle', '80000', 'oracle'), ('15', 'Oracle XS', '82000', 'oracle2'), ('16', 'Sentinel', '90000', 'sentinel'), ('17', 'Sentinel XS', '60000', 'sentinel2'), ('18', 'Windsor', '800000', 'windsor'), ('19', 'Windsor Drop', '850000', 'windsor2'), ('20', 'Zion', '60000', 'zion'), ('21', 'Zion Cabrio', '65000', 'zion2'), ('22', '9F', '120000', 'ninef'), ('23', '9F Cabrio', '130000', 'ninef2'), ('24', 'Alpha', '150000', 'alpha'), ('25', 'Banshee', '105000', 'banshee'), ('26', 'Bestia GTS', '610000', 'bestiagts'), ('27', 'Blista Compact', '42000', 'blista'), ('28', 'Buffalo', '35000', 'buffalo'), ('29', 'Buffalo S', '96000', 'buffalo2'), ('30', 'Carbonizzare', '195000', 'carbonizzare'), ('31', 'Comet', '100000', 'comet2'), ('32', 'Coquette', '138000', 'coquette'), ('33', 'Drift Tampa', '995000', 'tampa2'), ('34', 'Feltzer', '130000', 'feltzer2'), ('35', 'Furore GT', '448000', 'furoregt'), ('36', 'Fusilade', '36000', 'fusilade'), ('37', 'Jester', '240000', 'jester'), ('38', 'Jester(Racecar)', '350000', 'jester2'), ('39', 'Kuruma', '95000', 'kuruma'), ('40', 'Lynx', '1735000', 'lynx'), ('41', 'Massacro', '275000', 'massacro'), ('42', 'Massacro(Racecar)', '385000', 'massacro2'), ('43', 'Omnis', '701000', 'omnis'), ('44', 'Penumbra', '24000', 'penumbra'), ('45', 'Rapid GT', '140000', 'rapidgt'), ('46', 'Rapid GT Convertible', '150000', 'rapidgt2'), ('47', 'Schafter V12', '140000', 'schafter3'), ('48', 'Sultan', '12000', 'sultan'), ('49', 'Surano', '110000', 'surano'), ('50', 'Tropos', '816000', 'tropos'), ('51', 'Verkierer', '695000', 'verlierer2'), ('52', 'Casco', '680000', 'casco'), ('53', 'Coquette Classic', '665000', 'coquette2'), ('54', 'JB 700', '350000', 'jb700'), ('55', 'Pigalle', '400000', 'pigalle'), ('56', 'Stinger', '850000', 'stinger'), ('57', 'Stinger GT', '875000', 'stingergt'), ('58', 'Stirling GT', '975000', 'feltzer3'), ('59', 'Z-Type', '950000', 'ztype'), ('60', 'Adder', '1000000', 'adder'), ('61', 'Banshee 900R', '565000', 'banshee2'), ('62', 'Bullet', '155000', 'bullet'), ('63', 'Cheetah', '650000', 'cheetah'), ('64', 'Entity XF', '795000', 'entityxf'), ('65', 'ETR1', '199500', 'sheava'), ('66', 'FMJ', '1750000', 'fmj'), ('67', 'Infernus', '440000', 'infernus'), ('68', 'Osiris', '1950000', 'osiris'), ('69', 'RE-7B', '2475000', 'le7b'), ('70', 'Reaper', '1595000', 'reaper'), ('71', 'Sultan RS', '795000', 'sultanrs'), ('72', 'T20', '2200000', 't20'), ('73', 'Turismo R', '500000', 'turismor'), ('74', 'Tyrus', '2550000', 'tyrus'), ('75', 'Vacca', '240000', 'vacca'), ('76', 'Voltic', '150000', 'voltic'), ('77', 'X80 Proto', '2700000', 'prototipo'), ('78', 'Zentorno', '725000', 'zentorno'), ('79', 'Blade', '160000', 'blade'), ('80', 'Buccaneer', '29000', 'buccaneer'), ('81', 'Chino', '225000', 'chino'), ('82', 'Coquette BlackFin', '695000', 'coquette3'), ('83', 'Dominator', '35000', 'dominator'), ('84', 'Dukes', '62000', 'dukes'), ('85', 'Gauntlet', '32000', 'gauntlet'), ('86', 'Hotknife', '90000', 'hotknife'), ('87', 'Faction', '36000', 'faction'), ('88', 'Nightshade', '585000', 'nightshade'), ('89', 'Picador', '9000', 'picador'), ('90', 'Sabre Turbo', '15000', 'sabregt'), ('91', 'Tampa', '375000', 'tampa'), ('92', 'Virgo', '195000', 'virgo'), ('93', 'Vigero', '21000', 'vigero'), ('94', 'Bifta', '75000', 'bifta'), ('95', 'Blazer', '8000', 'blazer'), ('96', 'Brawler', '715000', 'brawler'), ('97', 'Bubsta 6x6', '249000', 'dubsta3'), ('98', 'Dune Buggy', '20000', 'dune'), ('99', 'Rebel', '22000', 'rebel2'), ('100', 'Sandking', '38000', 'sandking');
INSERT INTO `vehicles` VALUES ('101', 'The Liberator', '550000', 'monster'), ('102', 'Trophy Truck', '550000', 'trophytruck'), ('103', 'Baller', '90000', 'baller'), ('104', 'Cavalcade', '60000', 'cavalcade'), ('105', 'Grabger', '35000', 'granger'), ('106', 'Huntley S', '195000', 'huntley'), ('107', 'Landstalker', '58000', 'landstalker'), ('108', 'Radius', '32000', 'radi'), ('109', 'Rocoto', '85000', 'rocoto'), ('110', 'Seminole', '30000', 'seminole'), ('111', 'XLS', '253000', 'xls'), ('112', 'Bison', '30000', 'bison'), ('113', 'Bobcat XL', '23000', 'bobcatxl'), ('114', 'Gang Burrito', '65000', 'gburrito'), ('115', 'Journey', '15000', 'journey'), ('116', 'Minivan', '30000', 'minivan'), ('117', 'Paradise', '25000', 'paradise'), ('118', 'Rumpo', '13000', 'rumpo'), ('119', 'Surfer', '11000', 'surfer'), ('120', 'Youga', '16000', 'youga'), ('121', 'Asea', '1000000', 'asea'), ('122', 'Asterope', '1000000', 'asterope'), ('123', 'Fugitive', '24000', 'fugitive'), ('124', 'Glendale', '200000', 'glendale'), ('125', 'Ingot', '9000', 'ingot'), ('126', 'Intruder', '16000', 'intruder'), ('127', 'Premier', '10000', 'premier'), ('128', 'Primo', '9000', 'primo'), ('129', 'Primo Custom', '9500', 'primo2'), ('130', 'Regina', '8000', 'regina'), ('131', 'Schafter', '65000', 'schafter2'), ('132', 'Stanier', '10000', 'stanier'), ('133', 'Stratum', '10000', 'stratum'), ('134', 'Stretch', '30000', 'stretch'), ('135', 'Super Diamond', '250000', 'superd'), ('136', 'Surge', '38000', 'surge'), ('137', 'Tailgater', '55000', 'tailgater'), ('138', 'Warrener', '120000', 'warrener'), ('139', 'Washington', '15000', 'washington'), ('140', 'Akuma', '9000', 'AKUMA'), ('141', 'Bagger', '5000', 'bagger'), ('142', 'Bati 801', '15000', 'bati'), ('143', 'Bati 801RR', '15000', 'bati2'), ('144', 'BF400', '95000', 'bf400'), ('145', 'Carbon RS', '40000', 'carbonrs'), ('146', 'Cliffhanger', '225000', 'cliffhanger'), ('147', 'Daemon', '5000', 'daemon'), ('148', 'Double T', '12000', 'double'), ('149', 'Enduro', '48000', 'enduro'), ('150', 'Faggio', '4000', 'faggio2'), ('151', 'Gargoyle', '120000', 'gargoyle'), ('152', 'Hakuchou', '82000', 'hakuchou'), ('153', 'Hexer', '15000', 'hexer'), ('154', 'Innovation', '90000', 'innovation'), ('155', 'Lectro', '700000', 'lectro'), ('156', 'Nemesis', '12000', 'nemesis'), ('157', 'PCJ-600', '9000', 'pcj'), ('158', 'Ruffian', '9000', 'ruffian'), ('159', 'Sanchez', '7000', 'sanchez'), ('160', 'Sovereign', '90000', 'sovereign'), ('161', 'Thrust', '75000', 'thrust'), ('162', 'Vader', '9000', 'vader'), ('163', 'Vindicator', '600000', 'vindicator');
COMMIT;

-- ----------------------------
-- Auto increment value for autoecole
-- ----------------------------
ALTER TABLE `autoecole` AUTO_INCREMENT=4;

-- ----------------------------
-- Auto increment value for bans
-- ----------------------------
ALTER TABLE `bans` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for items
-- ----------------------------
ALTER TABLE `items` AUTO_INCREMENT=28;

-- ----------------------------
-- Auto increment value for jobs
-- ----------------------------
ALTER TABLE `jobs` AUTO_INCREMENT=14;

-- ----------------------------
-- Auto increment value for licences
-- ----------------------------
ALTER TABLE `licences` AUTO_INCREMENT=5;

-- ----------------------------
-- Auto increment value for phonebook
-- ----------------------------
ALTER TABLE `phonebook` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for police
-- ----------------------------
ALTER TABLE `police` AUTO_INCREMENT=9;

-- ----------------------------
-- Auto increment value for user_appartement
-- ----------------------------
ALTER TABLE `user_appartement` AUTO_INCREMENT=10;

-- ----------------------------
-- Auto increment value for user_boat
-- ----------------------------
ALTER TABLE `user_boat` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for user_licence
-- ----------------------------
ALTER TABLE `user_licence` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for user_vehicle
-- ----------------------------
ALTER TABLE `user_vehicle` AUTO_INCREMENT=2;

-- ----------------------------
-- Auto increment value for user_weapons
-- ----------------------------
ALTER TABLE `user_weapons` AUTO_INCREMENT=1;

-- ----------------------------
-- Auto increment value for users
-- ----------------------------
ALTER TABLE `users` AUTO_INCREMENT=2;

-- ----------------------------
-- Auto increment value for vehicles
-- ----------------------------
ALTER TABLE `vehicles` AUTO_INCREMENT=164;
