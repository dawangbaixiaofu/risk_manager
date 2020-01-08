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

 Date: 10/12/2019 17:13:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for fxxs_qbxse
-- ----------------------------
DROP TABLE IF EXISTS `fxxs_qbxse`;
CREATE TABLE `fxxs_qbxse`  (
  `id` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fxxs` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `qbxse_avg_2_order` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of fxxs_qbxse
-- ----------------------------
INSERT INTO `fxxs_qbxse` VALUES ('1.0', '0.630363', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('1.0', '0.446412', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('1.0', '0.305965', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('2.0', '0.695594', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('2.0', '0.627996', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('2.0', '0.583333', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('3.0', '0.61387', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('3.0', '0.484541', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('3.0', '0.433117', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('4.0', '0.628368', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('4.0', '0.603056', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('4.0', '0.582823', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('5.0', '0.501978', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('5.0', '0.473152', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('5.0', '0.396227', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('6.0', '0.787968', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('6.0', '0.926599', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('6.0', '0.819468', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('7.0', '0.443386', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('7.0', '0.347394', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('7.0', '0.317565', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('8.0', '0.92824', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('8.0', '0.631371', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('8.0', '0.52681', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('9.0', '0.902879', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('9.0', '0.971603', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('9.0', '0.533354', '3.0');
INSERT INTO `fxxs_qbxse` VALUES ('10.0', '0.254759', '1.0');
INSERT INTO `fxxs_qbxse` VALUES ('10.0', '0.266209', '2.0');
INSERT INTO `fxxs_qbxse` VALUES ('10.0', '0.468865', '3.0');

SET FOREIGN_KEY_CHECKS = 1;
commit;