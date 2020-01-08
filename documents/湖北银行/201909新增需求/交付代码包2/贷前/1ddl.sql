
insert into TAX_RULE_SET_INFO_HBYH (RULE_NO, RULE_NAME, RULE_LIMIT, SQL_1, CREATE_TIME, UPDATE_TIME, DIRECTION, RULE_DESCRIPTION, FLAG, SAME_OR, INDEX_DM)
values ('G101', '借款人投资占比', '10', null, to_date('29-10-2019 18:27:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-10-2019 18:27:00', 'dd-mm-yyyy hh24:mi:ss'), '>=', '借款人投资占比＜10%：', 1, '且', 'TZBL_1');

insert into TAX_RULE_SET_INFO_HBYH (RULE_NO, RULE_NAME, RULE_LIMIT, SQL_1, CREATE_TIME, UPDATE_TIME, DIRECTION, RULE_DESCRIPTION, FLAG, SAME_OR, INDEX_DM)
values ('G102_1', '法定代表人变更时间', '180', null, to_date('29-10-2019 18:27:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-10-2019 18:27:00', 'dd-mm-yyyy hh24:mi:ss'), '>=', '法定代表人的变更时间距申请日＜180天：', 1, '且', 'BGRQ_FR');

insert into TAX_RULE_SET_INFO_HBYH (RULE_NO, RULE_NAME, RULE_LIMIT, SQL_1, CREATE_TIME, UPDATE_TIME, DIRECTION, RULE_DESCRIPTION, FLAG, SAME_OR, INDEX_DM)
values ('G102_2', '法定代表人变更时间', '3', null, to_date('29-10-2019 18:27:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('29-10-2019 18:27:00', 'dd-mm-yyyy hh24:mi:ss'), '<=', '法定代表人更换频率两年大于3次：', 1, '且', 'BGCS_FR');

commit;


-- Create table
create table T_HYDM_EDXS_HBYH
(
  ed_level VARCHAR2(10),
  hydm_2   VARCHAR2(10),
  edxs     NUMBER(10,2)
);


--insert data
insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '51', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '51', 0.45);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '51', 0.31);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '52', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '52', 0.45);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '52', 0.31);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '08', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '08', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '08', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '09', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '09', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '09', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '10', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '10', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '10', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '25', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '25', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '25', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '29', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '29', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '29', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '30', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '30', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '30', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '31', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '31', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '31', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '32', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '32', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '32', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '33', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '33', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '33', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '34', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '34', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '34', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '35', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '35', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '35', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '36', 0.70);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '36', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '36', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '13', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '13', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '13', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '14', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '14', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '14', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '15', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '15', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '15', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '17', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '17', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '17', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '18', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '18', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '18', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '19', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '19', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '19', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '20', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '20', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '20', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '21', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '21', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '21', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '22', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '22', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '22', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '24', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '24', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '24', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '27', 0.61);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '27', 0.48);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '27', 0.43);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '23', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '23', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '23', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '64', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '64', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '64', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '65', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '65', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '65', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '66', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '66', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '66', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '71', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '71', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '71', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '73', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '73', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '73', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '74', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '74', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '74', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '75', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '75', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '75', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '77', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '77', 0.60);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '77', 0.58);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '80', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '80', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '80', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '81', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '81', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '81', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '72', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '72', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '72', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '61', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '61', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '61', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '62', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '62', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '62', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '44', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '44', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '44', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '45', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '45', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '45', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '46', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '46', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '46', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '82', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '82', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '82', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '83', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '83', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '83', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '86', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '86', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '86', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '87', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '87', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '87', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '89', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '89', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '89', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '78', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '78', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '78', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '79', 0.50);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '79', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '79', 0.40);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '47', 0.79);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '47', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '47', 0.82);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '48', 0.79);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '48', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '48', 0.82);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '49', 0.79);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '49', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '49', 0.82);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '50', 0.79);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '50', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '50', 0.82);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '70', 0.79);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '70', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '70', 0.82);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '54', 0.44);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '54', 0.35);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '54', 0.32);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '55', 0.44);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '55', 0.35);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '55', 0.32);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '58', 0.44);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '58', 0.35);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '58', 0.32);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '59', 0.44);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '59', 0.35);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '59', 0.32);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '26', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '26', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '26', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '28', 0.93);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '28', 0.63);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '28', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '01', 0.90);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '01', 0.97);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '01', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '02', 0.90);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '02', 0.97);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '02', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '03', 0.90);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '03', 0.97);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '03', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '04', 0.90);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '04', 0.97);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '04', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '05', 0.90);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '05', 0.97);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '05', 0.53);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '60', 0.25);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '60', 0.27);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '60', 0.47);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('A', '63', 0.25);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('B', '63', 0.27);

insert into T_HYDM_EDXS_HBYH (ED_LEVEL, HYDM_2, EDXS)
values ('C', '63', 0.47);

commit;


delete T_DM_HBYH_HYJR;
commit;

insert into T_DM_HBYH_HYJR (DM_HY)
values ('66');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('67');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('68');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('69');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('70');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('71');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('7212');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('3110');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('3120');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('3130');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('3140');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('0810');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('301');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('302');

insert into T_DM_HBYH_HYJR (DM_HY)
values ('3041');

commit;



update SYS_RATE_CONFIGURE t set rate = 0.12
where ID_ = 4;
commit;