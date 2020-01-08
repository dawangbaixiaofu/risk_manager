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

 Date: 10/12/2019 17:08:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for exception_table
-- ----------------------------
DROP TABLE IF EXISTS `exception_table`;
CREATE TABLE `exception_table`  (
  `nsrsbh` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flag1` int(11) NULL DEFAULT NULL,
  `flag2` int(11) NULL DEFAULT NULL,
  `flag3` int(11) NULL DEFAULT NULL,
  `flag4` int(11) NULL DEFAULT NULL,
  `flag5` int(11) NULL DEFAULT NULL,
  `flag6` int(11) NULL DEFAULT NULL,
  `flag7` int(11) NULL DEFAULT NULL,
  `flag8` int(11) NULL DEFAULT NULL,
  `flag9` int(11) NULL DEFAULT NULL,
  `flag10` int(11) NULL DEFAULT NULL,
  `flag11` int(11) NULL DEFAULT NULL,
  `flag12` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
