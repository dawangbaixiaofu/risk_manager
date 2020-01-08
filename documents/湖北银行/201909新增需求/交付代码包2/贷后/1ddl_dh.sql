create table T_WARNING_INDEX_VALUES_HBYH
(
  nsrsbh_1      VARCHAR2(30),
  yzwfwz_1      VARCHAR2(30),
  assb_1        VARCHAR2(30),
  nsrzt_1       VARCHAR2(30),
  xydj_1        VARCHAR2(30),
  qs_1          VARCHAR2(30),
  yq_6          VARCHAR2(30),
  yq_12         VARCHAR2(30),
  yq_24         VARCHAR2(30),
  sb0_6_yb      VARCHAR2(30),
  sb0_12_yb     VARCHAR2(30),
  sb0_6_xgm     VARCHAR2(30),
  sb0_12_xgm    VARCHAR2(30),
  qbxse_zzl_6   VARCHAR2(30),
  hybg_12       VARCHAR2(30),
  xwfk_6        VARCHAR2(30),
  kszb_1        VARCHAR2(30),
  lxks_2        VARCHAR2(30),
  xypf_wz       VARCHAR2(30),
  nsrzt_gs      VARCHAR2(30),
  bzxr          VARCHAR2(30),
  frbg_cs       VARCHAR2(30),
  ssxx          VARCHAR2(30),
  sxbzxr_qy     VARCHAR2(30),
  sxbzxr_fr     VARCHAR2(30),
  bhqx_over_30  VARCHAR2(30),
  thqx_over_30  VARCHAR2(30),
  bhqx_below_30 VARCHAR2(30),
  thqx_below_30 VARCHAR2(30)
);

-- Create table
create table T_ZBB_DH_HBYH
(
  nsrsbh              VARCHAR2(30),
  lrsj                DATE,
  zzl_12              NUMBER(20,2),
  znj_6               INTEGER,
  sum_1_12_zs_zzs     NUMBER(20,2),
  sy_ch_count_10      NUMBER(20,4),
  xy_ch_count_10      NUMBER(20,4),
  fir_ten_sum_xy      NUMBER(20,2),
  count_sy_bn         NUMBER(20,4),
  glfy_zchj           NUMBER(20,4),
  jlr_zchj            NUMBER(20,4),
  yszk_yysr           NUMBER(20,4),
  jljzj_zchj          NUMBER(20,4),
  ldzchj_yysr         NUMBER(20,4),
  zzl_12_x_woe        NUMBER(20,6),
  znj_6_woe           NUMBER(20,6),
  sum_1_12_zs_zzs_woe NUMBER(20,6),
  sy_ch_count_10_woe  NUMBER(20,6),
  xy_ch_count_10_woe  NUMBER(20,6),
  fir_ten_sum_xy_woe  NUMBER(20,6),
  count_sy_bn_woe     NUMBER(20,6),
  glfy_zchj_woe       NUMBER(20,6),
  jlr_zchj_woe        NUMBER(20,6),
  yszk_yysr_woe       NUMBER(20,6),
  jljzj_zchj_woe      NUMBER(20,6),
  ldzchj_yysr_woe     NUMBER(20,6),
  fen_1               NUMBER(20,6)
)
;


-- Create table
create table T_WARNING_RESULT_HBYH
(
  nsrsbh        VARCHAR2(30),
  index_dm      VARCHAR2(30),
  remark        VARCHAR2(500),
  index_value   VARCHAR2(30),
  lrsj          DATE default sysdate,
  warning_month VARCHAR2(10) default to_char(sysdate,'yyyy-mm'),
  warning_levl  VARCHAR2(30),
  nsrmc         VARCHAR2(200)
);

-- Create table
create table T_WARNING_RESULT_DES_HBYH
(
  nsrsbh    VARCHAR2(30),
  nsrmc     VARCHAR2(200),
  des       VARCHAR2(800),
  lrsj      DATE default sysdate,
  nsrsbh_wj VARCHAR2(50)
);


-- Create table
create table T_INDEX_ELY_WARNING_HBYH
(
  index_dm      VARCHAR2(30),
  index_remark  VARCHAR2(200),
  lower_limit   VARCHAR2(30),
  upper_limit   VARCHAR2(30),
  warning_level VARCHAR2(30),
  id            VARCHAR2(64),
  lower_lab     CHAR(3),
  upper_lab     CHAR(3),
  flag          NUMBER
);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('qs_1', '当月欠税', '0', '0', '一级预警', '8', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('xydj_1', '信用评级', '4', '4', '一级预警', '12', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yq_6', '近6个月逾期次数（逾期天数>3)', '2', '2', '一级预警', '21', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yq_24', '近24个月逾期次数（逾期天数>3)', '4', '4', '一级预警', '25', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('kszb_1', '亏损收入比', '-0.3', '-0.3', '一级预警', '29', '<  ', '<  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('lxks_2', '企业连续两期亏损且每期亏损额超过收入的20%', '1', '1', '一级预警', '32', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_12_xgm', '近12个月销售额为0的申报次数（小规模纳税人）', '3', '3', '正常', '33', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('bzxr', '公司被列为被执行人', '0', '0', '一级预警', '46', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sxbzxr_fr', '法人代表被列为失信被执行人', '0', '0', '正常', '49', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sxbzxr_fr', '法人代表被列为失信被执行人', '0', '0', '一级预警', '50', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('frbg_cs', '法定代表人人发生变更', '0', '0', '正常', '51', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('bhqx_below_30', '在本行出现了企业或法定代表人（30天以内）欠息、逾期:', '0', '0', '正常', '59', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('xydj_1', '信用评级', '4', '4', '正常', '11', '!= ', '!= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_12_yb', '近12个月销售额为0的申报次数（一般纳税人）', '7', '7', '正常', '37', '<  ', '<  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('nsrzt_gs', '工商营业状态是否正常', '0', '0', '一级预警', '44', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('bhqx_over_30', '在本行出现了企业或法定代表人（30天+）欠息、逾期或关注及以下:', '0', '0', '一级预警', '56', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('thqx_over_30', '在其他行出现企业或法定代表人（30天+）欠息、逾期及次级及以下:', '0', '0', '正常', '57', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('qbxse_zzl_6', '近6个月销售同比增长', 'null', 'null', '一级预警 申报缺失', '1', 'is ', 'is ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('qbxse_zzl_6', '近6个月销售同比增长', '-0.4', '-0.4', '一级预警', '4', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yzwfwz_1', '近1月是否严重违法违章（偷、逃、骗税）', '0', '0', '正常', '5', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('qs_1', '当月欠税', '0', '0', '正常', '7', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('assb_1', '未按时申报增值税', '0', '0', '正常', '18', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('lxks_2', '企业连续两期亏损且每期亏损额超过收入的20%', '0', '0', '正常', '31', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_6_yb', '近6个月销售额为0的申报次数（一般纳税人）', '4', '4', '一级预警', '42', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('bhqx_over_30', '在本行出现了企业或法定代表人（30天+）欠息、逾期或关注及以下:', '0', '0', '正常', '55', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yzwfwz_1', '近1月是否严重违法违章（偷、逃、骗税）', '0', '0', '一级预警', '6', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('hybg_12', '一年内行业发生变更的次数', '0', '2', '正常', '16', '>= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('xwfk_6', '近6个月税务行为罚款', '2', '2', '正常', '26', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_6_xgm', '近6个月销售额为0的申报次数（小规模纳税人）', '2', '2', '正常', '35', '<  ', '<  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_6_xgm', '近6个月销售额为0的申报次数（小规模纳税人）', '2', '2', '一级预警', '36', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_6_yb', '近6个月销售额为0的申报次数（一般纳税人）', '4', '4', '二级预警', '41', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('ssxx', '涉及重大法律诉讼、仲裁或重大经济纠纷', '0', '0', '一级预警', '54', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('thqx_over_30', '在其他行出现企业或法定代表人（30天+）欠息、逾期及次级及以下:', '0', '0', '一级预警', '58', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('XYPF_WZ', '微众评分', 'null', 'null', '一级预警 数据不全', '2', 'is ', 'is ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('XYPF_WZ', '微众评分', '0.8', '0.8', '正常', '13', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('XYPF_WZ', '微众评分', '0.9', '1', '一级预警', '15', '>  ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yq_6', '近6个月逾期次数（逾期天数>3)', '1', '1', '正常', '20', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yq_24', '近24个月逾期次数（逾期天数>3)', '3', '3', '正常', '24', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('nsrzt_gs', '工商营业状态是否正常', '0', '0', '正常', '43', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('frbg_cs', '法定代表人人发生变更', '0', '0', '一级预警', '52', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('ssxx', '涉及重大法律诉讼、仲裁或重大经济纠纷', '0', '0', '正常', '53', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('nsrzt_1', '纳税人状态是否正常', '0', '0', '一级预警', '10', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('XYPF_WZ', '微众评分', '0.8', '0.9', '二级预警', '14', '>  ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_6_yb', '近6个月销售额为0的申报次数（一般纳税人）', '4', '4', '正常', '40', '<  ', '<  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('thqx_below_30', '在本行出现了企业或法定代表人（30天以内）欠息、逾期或等级被调成关注:', '0', '0', '二级预警', '62', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('qbxse_zzl_6', '近6个月销售同比增长', '-0.4', '-0.4', '正常', '3', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('nsrzt_1', '纳税人状态是否正常', '0', '0', '正常', '9', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('hybg_12', '一年内行业发生变更的次数', '2', '2', '一级预警', '17', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yq_12', '近12个月逾期次数（逾期天数>3)', '2', '2', '正常', '22', '<= ', '<= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('yq_12', '近12个月逾期次数（逾期天数>3)', '3', '3', '一级预警', '23', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('xwfk_6', '近6个月税务行为罚款', '2', '2', '二级预警', '27', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('kszb_1', '亏损收入比', '-0.2', '-0.2', '正常', '28', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('kszb_1', '亏损收入比', '-0.2', '-0.3', '二级预警', '30', '<= ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_12_xgm', '近12个月销售额为0的申报次数（小规模纳税人）', '3', '3', '一级预警', '34', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sxbzxr_qy', '公司被列为失信被执行人', '0', '0', '一级预警', '48', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('thqx_below_30', '在本行出现了企业或法定代表人（30天以内）欠息、逾期或等级被调成关注:', '0', '0', '正常', '61', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('assb_1', '未按时申报增值税', '1', '1', '二级预警', '19', '>= ', '>= ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_12_yb', '近12个月销售额为0的申报次数（一般纳税人）', '7', '7', '二级预警', '38', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sb0_12_yb', '近12个月销售额为0的申报次数（一般纳税人）', '7', '7', '一级预警', '39', '>  ', '>  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('bzxr', '公司被列为被执行人', '0', '0', '正常', '45', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('sxbzxr_qy', '公司被列为失信被执行人', '0', '0', '正常', '47', '=  ', '=  ', 1);

insert into T_INDEX_ELY_WARNING_HBYH (INDEX_DM, INDEX_REMARK, LOWER_LIMIT, UPPER_LIMIT, WARNING_LEVEL, ID, LOWER_LAB, UPPER_LAB, FLAG)
values ('bhqx_below_30', '在本行出现了企业或法定代表人（30天以内）欠息、逾期:', '0', '0', '二级预警', '60', '>  ', '>  ', 1);

commit;