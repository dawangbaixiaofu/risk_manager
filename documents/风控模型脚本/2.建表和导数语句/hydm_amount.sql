/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.85.140
 Source Server Type    : MySQL
 Source Server Version : 50560
 Source Host           : 192.168.85.140:3306
 Source Schema         : yth_xybk_cs

 Target Server Type    : MySQL
 Target Server Version : 50560
 File Encoding         : 65001

 Date: 10/12/2019 17:14:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hydm_amount
-- ----------------------------
DROP TABLE IF EXISTS `hydm_amount`;
CREATE TABLE `hydm_amount`  (
  `id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hydm` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of hydm_amount
-- ----------------------------
INSERT INTO `hydm_amount` VALUES ('1.0', '51');
INSERT INTO `hydm_amount` VALUES ('1.0', '52');
INSERT INTO `hydm_amount` VALUES ('2.0', '08');
INSERT INTO `hydm_amount` VALUES ('2.0', '09');
INSERT INTO `hydm_amount` VALUES ('2.0', '10');
INSERT INTO `hydm_amount` VALUES ('2.0', '25');
INSERT INTO `hydm_amount` VALUES ('2.0', '29');
INSERT INTO `hydm_amount` VALUES ('2.0', '30');
INSERT INTO `hydm_amount` VALUES ('2.0', '31');
INSERT INTO `hydm_amount` VALUES ('2.0', '32');
INSERT INTO `hydm_amount` VALUES ('2.0', '33');
INSERT INTO `hydm_amount` VALUES ('2.0', '34');
INSERT INTO `hydm_amount` VALUES ('2.0', '35');
INSERT INTO `hydm_amount` VALUES ('2.0', '36');
INSERT INTO `hydm_amount` VALUES ('2.0', '37');
INSERT INTO `hydm_amount` VALUES ('2.0', '38');
INSERT INTO `hydm_amount` VALUES ('2.0', '39');
INSERT INTO `hydm_amount` VALUES ('2.0', '40');
INSERT INTO `hydm_amount` VALUES ('2.0', '41');
INSERT INTO `hydm_amount` VALUES ('2.0', '42');
INSERT INTO `hydm_amount` VALUES ('2.0', '43');
INSERT INTO `hydm_amount` VALUES ('3.0', '13');
INSERT INTO `hydm_amount` VALUES ('3.0', '14');
INSERT INTO `hydm_amount` VALUES ('3.0', '15');
INSERT INTO `hydm_amount` VALUES ('3.0', '17');
INSERT INTO `hydm_amount` VALUES ('3.0', '18');
INSERT INTO `hydm_amount` VALUES ('3.0', '19');
INSERT INTO `hydm_amount` VALUES ('3.0', '20');
INSERT INTO `hydm_amount` VALUES ('3.0', '21');
INSERT INTO `hydm_amount` VALUES ('3.0', '22');
INSERT INTO `hydm_amount` VALUES ('3.0', '24');
INSERT INTO `hydm_amount` VALUES ('3.0', '27');
INSERT INTO `hydm_amount` VALUES ('4.0', '23');
INSERT INTO `hydm_amount` VALUES ('4.0', '64');
INSERT INTO `hydm_amount` VALUES ('4.0', '65');
INSERT INTO `hydm_amount` VALUES ('4.0', '66');
INSERT INTO `hydm_amount` VALUES ('4.0', '71');
INSERT INTO `hydm_amount` VALUES ('4.0', '73');
INSERT INTO `hydm_amount` VALUES ('4.0', '74');
INSERT INTO `hydm_amount` VALUES ('4.0', '75');
INSERT INTO `hydm_amount` VALUES ('4.0', '77');
INSERT INTO `hydm_amount` VALUES ('5.0', '80');
INSERT INTO `hydm_amount` VALUES ('5.0', '81');
INSERT INTO `hydm_amount` VALUES ('5.0', '72');
INSERT INTO `hydm_amount` VALUES ('5.0', '61');
INSERT INTO `hydm_amount` VALUES ('5.0', '62');
INSERT INTO `hydm_amount` VALUES ('5.0', '44');
INSERT INTO `hydm_amount` VALUES ('5.0', '45');
INSERT INTO `hydm_amount` VALUES ('5.0', '46');
INSERT INTO `hydm_amount` VALUES ('5.0', '82');
INSERT INTO `hydm_amount` VALUES ('5.0', '83');
INSERT INTO `hydm_amount` VALUES ('5.0', '86');
INSERT INTO `hydm_amount` VALUES ('5.0', '87');
INSERT INTO `hydm_amount` VALUES ('5.0', '89');
INSERT INTO `hydm_amount` VALUES ('5.0', '78');
INSERT INTO `hydm_amount` VALUES ('5.0', '79');
INSERT INTO `hydm_amount` VALUES ('6.0', '47');
INSERT INTO `hydm_amount` VALUES ('6.0', '48');
INSERT INTO `hydm_amount` VALUES ('6.0', '49');
INSERT INTO `hydm_amount` VALUES ('6.0', '50');
INSERT INTO `hydm_amount` VALUES ('6.0', '70');
INSERT INTO `hydm_amount` VALUES ('7.0', '54');
INSERT INTO `hydm_amount` VALUES ('7.0', '55');
INSERT INTO `hydm_amount` VALUES ('7.0', '58');
INSERT INTO `hydm_amount` VALUES ('7.0', '59');
INSERT INTO `hydm_amount` VALUES ('8.0', '26');
INSERT INTO `hydm_amount` VALUES ('8.0', '28');
INSERT INTO `hydm_amount` VALUES ('9.0', '01');
INSERT INTO `hydm_amount` VALUES ('9.0', '02');
INSERT INTO `hydm_amount` VALUES ('9.0', '03');
INSERT INTO `hydm_amount` VALUES ('9.0', '05');
INSERT INTO `hydm_amount` VALUES ('10.0', '60');
INSERT INTO `hydm_amount` VALUES ('10.0', '63');

SET FOREIGN_KEY_CHECKS = 1;
commit;