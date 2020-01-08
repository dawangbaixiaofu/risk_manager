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

 Date: 10/12/2019 17:11:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for coverage_area_bank_xyyh_csfh
-- ----------------------------
DROP TABLE IF EXISTS `coverage_area_bank_xyyh_csfh`;
CREATE TABLE `coverage_area_bank_xyyh_csfh`  (
  `SWJGDM` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PROVINCE` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CITY` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of coverage_area_bank_xyyh_csfh
-- ----------------------------
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4301', '湖南省', '长沙市');
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4304', '湖南省', '衡阳市');
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4302', '湖南省', '株洲市');
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4303', '湖南省', '湘潭市');
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4306', '湖南省', '岳阳市');
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4307', '湖南省', '常德市');
INSERT INTO `coverage_area_bank_xyyh_csfh` VALUES ('4310', '湖南省', '郴州市');

SET FOREIGN_KEY_CHECKS = 1;
commit;   