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

 Date: 10/12/2019 17:15:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_rate_configure
-- ----------------------------
DROP TABLE IF EXISTS `sys_rate_configure`;
CREATE TABLE `sys_rate_configure`  (
  `id_` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `grade` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rate` decimal(10, 7) NULL DEFAULT NULL,
  `create_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `remark_` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `flag` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `version` decimal(10, 0) NULL DEFAULT NULL,
  `enable_` decimal(1, 0) NULL DEFAULT NULL,
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `province_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_rate_configure
-- ----------------------------
INSERT INTO `sys_rate_configure` VALUES ('rc_563416062701363200', 'A', 0.0900000, NULL, NULL, 'admin', '2019-11-25 13:56:23.000000', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_rate_configure` VALUES ('rc_563416062701363201', 'B', 0.0900000, NULL, NULL, 'admin', '2019-11-25 13:56:30.000000', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_rate_configure` VALUES ('rc_563416062701363202', 'C', 0.0900000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
commit;