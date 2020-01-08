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

 Date: 10/12/2019 17:16:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tax_rule_set_info_xyyh_csfh
-- ----------------------------
DROP TABLE IF EXISTS `tax_rule_set_info_xyyh_csfh`;
CREATE TABLE `tax_rule_set_info_xyyh_csfh`  (
  `RULE_NO` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RULE_NAME` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `RULE_LIMIT` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `SQL_1` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `CREATE_TIME` datetime NULL DEFAULT NULL,
  `UPDATE_TIME` datetime NULL DEFAULT NULL,
  `DIRECTION` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `RULE_DESCRIPTION` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `FLAG` decimal(65, 30) NULL DEFAULT NULL,
  `SAME_OR` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `INDEX_DM` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tax_rule_set_info_xyyh_csfh
-- ----------------------------
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S101', '借款人不是“法定代表人”', '1.0', NULL, NULL, NULL, '=', '借款人不是“法定代表人”:', 1.000000000000000000000000000000, '且', 'fd_dbr_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S102', '借款人年龄', '60.0', NULL, NULL, NULL, '<=', '借款人年龄大于60周岁：', 1.000000000000000000000000000000, '且', 'nl_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S103', '借款人年龄', '18.0', NULL, NULL, NULL, '>=', '借款人年龄小于18周岁：', 1.000000000000000000000000000000, '且', 'nl_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S104', '经营实体成立年限', '24.0', NULL, NULL, NULL, '>=', '（一般纳税人）近2年增值税申报记录次数＜24：', 1.000000000000000000000000000000, '且', 'zzs_count_2_yb');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S105', '经营实体成立年限', '9.0', NULL, NULL, NULL, '>=', '（一般纳税人）近2年企业所得税申报记录次数＜9：', 1.000000000000000000000000000000, '且', 'qysds_count_2_yb');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S104_1', '经营实体成立年限', '8.0', NULL, NULL, NULL, '>=', '（小规模纳税人）近2年增值税申报记录次数＜8：', 1.000000000000000000000000000000, '且', 'zzs_count_2_xgm');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S105_1', '经营实体成立年限', '9.0', NULL, NULL, NULL, '>=', '（小规模纳税人）近2年企业所得税申报记录次数＜9：', 1.000000000000000000000000000000, '且', 'qysds_count_2_xgm');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S106', '企业注册地址', '1.0', NULL, NULL, NULL, '=', '企业注册地址在行方规定的区域1表示在0否：', 1.000000000000000000000000000000, '且', 'coverage_area');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S107', '纳税信用评级', '(\'C\',\'D\',\'M\')', NULL, NULL, NULL, 'not in', '纳税信用评级为：', 1.000000000000000000000000000000, '且', 'xydj_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S108', '严重违法违章（违章）', '1.0', NULL, NULL, NULL, '<', '近24个月重大违法违章次数>=1:', 1.000000000000000000000000000000, '且', 'wfwz_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S109', '纳税状态', '(\'正常\',\'开业\')', NULL, NULL, NULL, 'in', '企业纳税状态非正常:', 1.000000000000000000000000000000, '且', 'nsrzt_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S110', '滞纳金', '2.0', NULL, NULL, NULL, '<=', '近12个月缴纳滞纳金次数大于2次:', 1.000000000000000000000000000000, '且', 'znj_12');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S111', '滞纳金', '1.0', NULL, NULL, NULL, '<=', '近6个月缴纳滞纳金次数超过1次:', 1.000000000000000000000000000000, '且', 'znj_6');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S112', '当前欠税', '0.0', NULL, NULL, NULL, '<=', '当前有欠税余额:', 1.000000000000000000000000000000, '且', 'qs_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S113', '首次报税情况', '24.0', NULL, NULL, NULL, '>', '首次有收入报税时间<=24个月:', 1.000000000000000000000000000000, '且', 'scbs_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S114', '企业缴税规模', '3000.0', NULL, NULL, NULL, '>=', '近12个月缴税总额<0.3万元:', 1.000000000000000000000000000000, '且', 'nsze_12');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S115', '亏损情况', '-100000.0', NULL, NULL, NULL, '>=', '上年度净利润<-10万:', 1.000000000000000000000000000000, '且', 'lrze_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S116', '亏损情况', '-0.1', NULL, NULL, NULL, '>=', '净利润率＜-10%:', 1.000000000000000000000000000000, '且', 'profit_ratio_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S117', '净资产情况', '0.0', NULL, NULL, NULL, '>', '所有者权益小于且等于0:', 1.000000000000000000000000000000, '且', 'syzqy_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S118', '经营实体规模', '500000.0', NULL, NULL, NULL, '>=', '前12个月的全部销售收入小于50万:', 1.000000000000000000000000000000, '且', 'qbxse_12');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S119', '最近两期的全部销售收入', '0.0', NULL, NULL, NULL, '>', '最近两期的全部销售收入加总金额<=0:', 1.000000000000000000000000000000, '且', 'qbxse_2_period');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S120', '近6个月收入同比', '-0.15', NULL, NULL, NULL, '>=', '近6个月收入同比增幅<-0.15:', 1.000000000000000000000000000000, '且', 'qbxse_zzl_6');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S121', '近12个月收入同比', '-0.2', NULL, NULL, NULL, '>=', '近12个月收入同比增幅＜-0.2:', 1.000000000000000000000000000000, '且', 'qbxse_zzl_12');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S122', '近24个月行为罚款次数', '4.0', NULL, NULL, NULL, '<', '近24个月行为罚款次数≥4次:', 1.000000000000000000000000000000, '且', 'xwfk_24');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S123', '近12个月行为罚款次数', '3.0', NULL, NULL, NULL, '<', '近12个月行为罚款次数>=3:', 1.000000000000000000000000000000, '且', 'xwfk_12');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S124', '近6个月行为罚款次数', '2.0', NULL, NULL, NULL, '<', '近6个月行为罚款次数>=2:', 1.000000000000000000000000000000, '且', 'xwfk_6');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S125', '近3个月行为罚款次数', '1.0', NULL, NULL, NULL, '<', '近3个月行为罚款次数>=1:', 1.000000000000000000000000000000, '且', 'xwfk_3');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S126', '近24期连续申报为0', '3.0', NULL, NULL, NULL, '<=', '（一般纳税人）近24期连续申报为0的最大次数大于3：', 1.000000000000000000000000000000, '且', 'SB_ZERO_CONTINUOUS_24_yb');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S127', '近24期累计零申报', '6.0', NULL, NULL, NULL, '<=', '（一般纳税人）近24期累计零申报次数最大次数大于6：', 1.000000000000000000000000000000, '且', 'SB_ZERO_COUNT_24_yb');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S126_1', '近24期连续申报为0', '2.0', NULL, NULL, NULL, '<=', '（小规模）近24期连续申报为0的最大次数大于2：', 1.000000000000000000000000000000, '且', 'SB_ZERO_CONTINUOUS_24_xgm');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S127_1', '近24期累计零申报', '4.0', NULL, NULL, NULL, '<=', '（小规模）近24期累计零申报次数最大次数大于4：', 1.000000000000000000000000000000, '且', 'SB_ZERO_COUNT_24_xgm');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('S128', '未按时申报', '0.0', NULL, NULL, NULL, '=', '最近一期未按时申报，1表示未按时申报：', 1.000000000000000000000000000000, '且', 'assb_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G101', '法定代表人投资占比', '0.25', NULL, NULL, NULL, '>=', '申请人为“法定代表人且”投资占比＜25%:', 1.000000000000000000000000000000, '且', 'fr_chigu_gs');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G102', '法定代表人更换频率', '3.0', NULL, NULL, NULL, '<', '法定代表人更换频率大于等于（两年3次）:', 1.000000000000000000000000000000, '且', 'bgcs_fr');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G103', '法定代表人的变更时间', '180.0', NULL, NULL, NULL, '>=', '法定代表人的变更时间距申请日＜180天:', 1.000000000000000000000000000000, '且', 'bgrq_fr');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G104', '工商营业状态', '0.0', NULL, NULL, NULL, '<=', '工商营业状态，0表示正常:', 1.000000000000000000000000000000, '且', 'nsrzt_gs');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G105', '法定代表人持股时长', '365.0', NULL, NULL, NULL, '>=', '法定代表人持股时长<365天:', 1.000000000000000000000000000000, '且', 'holding_duration');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G106', '近12月作为被执行人', '0.0', NULL, NULL, NULL, '<=', '近12月作为被执行人记录数>0:', 1.000000000000000000000000000000, '且', 'bzxr_1');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G107', '近3年作为被执行人', '3.0', NULL, NULL, NULL, '<', '近3年作为被执行人记录数>=3:', 1.000000000000000000000000000000, '且', 'bzxr_3');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G108', '近5年作为失信人', '0.0', NULL, NULL, NULL, '<=', '近3年作为失信人记录数>0:', 1.000000000000000000000000000000, '且', 'shixin_bzxr_3');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G109', '近5年作为失信人', '3.0', NULL, NULL, NULL, '<', '近5年作为失信人记录数>=3:', 1.000000000000000000000000000000, '且', 'shixin_bzxr_5');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G110', '近5年限制高消费、出入境名单和通缉名单', '0.0', NULL, NULL, NULL, '<=', '近5年限制高消费、出入境名单和通缉名单命中拒绝：', 1.000000000000000000000000000000, '且', 'judicial_blacklist');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('G111', '财产保全申请作为被告', '0.0', NULL, NULL, NULL, '<=', '财产保全申请作为被告:', 1.000000000000000000000000000000, '且', 'cpws_ccbq');
INSERT INTO `tax_rule_set_info_xyyh_csfh` VALUES ('H101', '限制性行业', '0.0', NULL, NULL, NULL, '=', '所属行业判断是否为禁入行业，1是0否:', 1.000000000000000000000000000000, '且', 'bank_industry');

SET FOREIGN_KEY_CHECKS = 1;
commit;