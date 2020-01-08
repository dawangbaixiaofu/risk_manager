create or replace procedure p_mx_hbyh(v_nsrsbh     in varchar2,
                                      v_out_result out varchar2,
                                      v_out        out varchar2) as
  term_1        int default 0;
  ysx_1         int default 0;
  sshydm_1      varchar2(10);
  xydj_1        varchar2(10);
  nsrzt_1       varchar2(30);
  qs_1          int default 0;
  kyrq_1        number(10, 2);
  qbxse_12      number(20, 2);
  qbxse_24      number(20, 2);
  wfwz_1        int;
  sssqz_max_sb  varchar2(30);
  nsze_12       number(20, 2);
  xwfk_1        int;
  DJZCLXMC_1    varchar2(300);
  sssqq_min_sb  varchar2(30);
  swsjyxx_1     int;
  znj_12        int;
  znj_6         int;
  znj_24        int;
  sb0_max       int;
  sb0_1         int;
  nsze_24       number(20, 2);
  syzqy_1       number(20, 2);
  lrze_1        number(20, 2);
  qbxse_6       number(20, 2);
  qbxse_1_6     number(20, 2);
  qbxse_2       number(20, 2);
  lrze_2        number(20, 2);
  sql1          varchar2(3000);
  DBRZJHM_1     varchar2(30);
  nl_1          int;
  bgcs_fr       int;
  bgrq_fr       varchar2(30);
  qbxse_last    number(20, 2);
  term_or_value varchar2(30);
  term_2        int default 0;
  fr_chigu      number(20, 2);
  dbrmc_1       varchar2(30);
  lsxs_12       number(20, 4);
  qysds_12      number(20, 4);
  v_nsrmc       varchar(300);
  nslxmc_1      int;
  bzxr_1        int;
  shixin_bzxr   int;
  cpws_ccbq     int;
  XZCF_GS       int;
  nsrzt_gs      int;
  fr_chigu_gs   number(20, 4);
  fr_chigu_gs_1 number(20, 4);
  fr_gs         varchar(60);
  YZWFWZ_GS     int; --工商与税务法人匹配
  xypj_1        varchar2(30);
begin
  select decode(xydj,
                'null',
                '未评级',
                'NULL',
                '未评级',
                '',
                '未评级',
                xydj),
         sshydm,
         NSRZTMC,
         round((sysdate - to_date(substr(kyrq, 1, 10), 'yyyy-mm-dd')) / 365,
               2),
         DJZCLXMC,
         nsrmc,
         decode(nslxmc, '一般纳税人', 1, 3)
    into xydj_1, sshydm_1, nsrzt_1, kyrq_1, DJZCLXMC_1, v_nsrmc, nslxmc_1
    from (select *
            from zx_nsrjcxx t
           where nsrsbh = v_nsrsbh
           order by lrsj desc) a
   where rownum < 2;

  --工商状态
  select count(*)
    into nsrzt_gs
    from (select *
            from HSJ_BASIC
           where ent_name = v_nsrmc
           order by lrsj desc)
   where rownum = 1
     and ent_status in ('吊销', '注销');

  --禁入行业
  --select count(*) into sshydm_1 from t_dm_hbyh_hyjr where sshydm_1 = DM_HY; 注释掉，修改为
  select count(*) into sshydm_1 from t_dm_hbyh_hyjr
  where DM_HY = substr(sshydm_1, -4, 4)
    or DM_HY = substr(sshydm_1, -4, 3)
    or DM_HY = substr(sshydm_1, -4, 2);

  --申报信息
  with sbxx as
   (select distinct nsrsbh,
                    t.sssqq,
                    t.sssqz,
                    t.qbxse,
                    t.ysxssr,
                    t.ybtse,
                    t.yjse,
                    t.sbrq,
                    t.sbqx,
                    t.zsxmmc,
                    max(sssqz) over() sssqz_max,
                    min(case
                          when QBXSE > 0 then
                           sssqq
                        end) over() sssqq_min
      from zx_sbxx t
     where t.nsrsbh = v_nsrsbh
       and sssqq >= to_char(sysdate - 365 * 3, 'yyyy-mm-dd')
       and ZSXMMC IN ('增值税', '企业所得税')
       and not exists (select 1
              from zx_sbxx b
             where b.nsrsbh = v_nsrsbh
               and t.lrsj < b.lrsj - 3 / 24 / 60))
  select sssqz_max,
         sssqq_min,
         qbxse12,
         qbxse24,
         qbxse6,
         qbxse61,
         qbxse2,
         qbxselast,
         zzs12 + nvl(qysds12, 0),
         zzs24 + nvl(qysds24, 0),
         nvl(qysds12, 0)
    into sssqz_max_sb,
         sssqq_min_sb,
         qbxse_12,
         qbxse_24,
         qbxse_6,
         qbxse_1_6,
         qbxse_2,
         qbxse_last,
         nsze_12,
         nsze_24,
         qysds_12
    from (select max(sssqz_max) sssqz_max,
                 min(sssqq_min) sssqq_min,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse12,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -24),
                                    'yyyy-mm-dd') and
                            sssqz <=
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse24,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -6),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse6,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -18),
                                    'yyyy-mm-dd') and
                            sssqz <=
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse61,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -2),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse2,
                 sum(case
                       when substr(sssqz, 1, 4) = substr(sssqz_max, 1, 4) - 1 and
                            ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxselast,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') AND ZSXMMC IN ('增值税') then
                        nvl(yjse, 0) + ybtse
                     end) zzs12,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -24),
                                    'yyyy-mm-dd') AND ZSXMMC IN ('增值税') then
                        nvl(yjse, 0) + ybtse
                     end) zzs24,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') AND ZSXMMC IN ('企业所得税') then
                        ybtse
                     end) qysds12,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -24),
                                    'yyyy-mm-dd') AND ZSXMMC IN ('企业所得税') then
                        ybtse
                     end) qysds24
            from sbxx t);

  if sssqz_max_sb >=
     to_char(trunc(add_months(sysdate, -nslxmc_1 + 1) - 25, 'mm') - 1,
             'yyyy-mm-dd') then
    swsjyxx_1 := 0;
  else
    swsjyxx_1 := 1;
  end if;

  --征收信息
  with sbzsxx as
   (select distinct nsrsbh,
                    sssq_q,
                    sssq_z,
                    jkqx,
                    jkfsrq,
                    se,
                    zsxm_mc,
                    SKZL_MC
      from zx_sbzsxx a
     where not exists
     (select 1
              from zx_sbzsxx b
             where b.nsrsbh = v_nsrsbh
               and a.lrsj < b.lrsj - 3 / 24 / 60)
       and sssq_z >= to_char(add_months(sysdate, -30), 'yyyy-mm-dd')
       and nsrsbh = v_nsrsbh)
  select nvl(sum(case
                   when sssq_z = sssqz_max_sb and
                        (jkfsrq is null or jkfsrq = 'NULL') and
                        jkqx < to_char(sysdate, 'yyyy-mm-dd') and se > 1 then
                    1
                 end),
             0),
         nvl(sum(case
                   when sssq_z >= to_char(add_months(sysdate, -12), 'yyyy-mm-dd') and
                        skzl_mc in ('行为罚款', '涉税罚款', '没收非法所得') then
                    1
                 end),
             0),
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -12),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金' then
                    1
                 end),
             0),
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -6),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金' then
                    1
                 end),
             0),
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -24),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金' then
                    1
                 end),
             0)
    into qs_1, xwfk_1, znj_12, znj_6, znj_24
    from sbzsxx a;
--违法违章
  select count(*)
    into wfwz_1
    from (select distinct djrq, zywfwzsddm, wfwzlxdm, wfwzztdm
            from zx_wfwzxx a
           where djrq >= to_char(add_months(sysdate, -12), 'yyyy-mm-dd')
             and not exists (select 1
                    from zx_wfwzxx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60)
             and nsrsbh = v_nsrsbh
             and wfwzlxdm in ('01', '02', '03'));
  --法人
  select max(trim(DBR_ZJHM)), max(dbrmc)
    into DBRZJHM_1, dbrmc_1
    from (select DBR_ZJHM, dbrmc
            from zx_lxrxx a
           where nsrsbh = v_nsrsbh
             and bssf = 1
           order by lrsj desc)
   where rownum = 1;

  select max(FR_NAME)
    into fr_gs
    from (select *
            from hsj_basic t
           where ent_name = v_nsrmc
           order by cast(lrsj as date) desc)
   where rownum = 1;

  if fr_gs = dbrmc_1 then
    YZWFWZ_GS := 0;
  else
    YZWFWZ_GS := 1;
  end if;

  if length(DBRZJHM_1) = 18 then
    nl_1 := extract(year from sysdate) - substr(DBRZJHM_1, 7, 4);
  else
    if length(DBRZJHM_1) = 15 then
      nl_1 := extract(year from sysdate) - (19 || substr(DBRZJHM_1, 7, 2));
    end if;
  end if;

  select max(regexp_replace(FUNDED_RATIO, '%', ''))
    into fr_chigu_gs
    from (select *
            from HSJ_SHARE_HOLDER t
           where (trim(BLIC_NO) = DBRZJHM_1 or dbrmc_1 = SHARE_HOLDER_NAME)
             and ENT_NAME = v_nsrmc
           order by lrsj desc)
   where rownum = 1;

  select max(regexp_replace(ratio, '%', ''))
    into fr_chigu_gs_1
    from (select *
            from HSJ_TOP_TEN_SHARE_HOLDER t
           where ent_name = v_nsrmc
             and share_holder_name = dbrmc_1
           order by lrsj desc)
   where rownum = 1;
  fr_chigu_gs := nvl(fr_chigu_gs, fr_chigu_gs_1);

  select max(tzbl)
    into fr_chigu
    from (select distinct nsrmc, tzfmc, tzbl, zjhm, tzje
            from zx_tzfxx a
           where not exists (select *
                    from zx_tzfxx b
                   where b.nsrsbh = v_nsrsbh
                     and a.lrsj < b.lrsj - 1 / 24 / 60)
             and nsrsbh = v_nsrsbh)
   where trim(zjhm) = DBRZJHM_1
      or dbrmc_1 = TZFMC;
  fr_chigu := nvl(fr_chigu_gs, fr_chigu);

  with sbxx as
   (select distinct t.sssqq, t.sssqz, sum(t.qbxse) qbxse
      from (select distinct t.sssqq, t.sssqz, t.qbxse
              from zx_sbxx t
             where t.nsrsbh = v_nsrsbh
               and not exists (select 1
                      from zx_sbxx b
                     where b.nsrsbh = v_nsrsbh
                       and t.lrsj < b.lrsj - 3 / 24 / 60)
               and ZSXMmc = '增值税'
               and sssqz > to_char(add_months(to_date(sssqz_max_sb,
                                                      'yyyy-mm-dd'),
                                              -12),
                                   'yyyy-mm-dd')
               and sssqz <= sssqz_max_sb) t
     group by sssqq, sssqz)
  select nvl(MAX(NVL(next_qbxse_1, RN) - RN + 1), 0),
         nvl(max(sum_qbxse), 0)
    into sb0_max, --最大连续0申报
         sb0_1 --累计0申报
    from (select a.*,
                 decode(NEXT_QBXSE,
                        0,
                        lead(rn, 1, rn) over(order by sssqz desc)) next_qbxse_1
            from (select a.*,
                         row_number() over(order by sssqz desc) rn,
                         lag(qbxse, 1, 1) over(order by sssqz desc) prev_qbxse,
                         lead(qbxse, 1, 1) over(order by sssqz desc) next_qbxse,
                         sum(case
                               when qbxse = 0 then
                                1
                               else
                                0
                             end) over() sum_qbxse
                    from sbxx a) a
           where QBXSE = 0
             AND (PREV_QBXSE <> 0 OR NEXT_QBXSE <> 0));

  with zcfzbxx as
   (select distinct a.nsrsbh,
                    a.skssqq,
                    a.skssqz,
                    trim(a.xm) xm,
                    a.qmye,
                    a.BSRQ
      from zx_zcfzbxx a
     where not exists (select *
              from zx_zcfzbxx b
             where b.nsrsbh = v_nsrsbh
               and a.lrsj < b.lrsj - 5 / 24 / 60)
       and nsrsbh = v_nsrsbh)
  select sum(case
               when xm like '%所有者%' and xm not like '负债%' then
                qmye
             end)
    into syzqy_1
    from (select distinct a.nsrsbh,
                          a.skssqq,
                          a.skssqz,
                          trim(a.xm) xm,
                          a.qmye,
                          a.BSRQ
            from zcfzbxx a
           where a.skssqz = (select max(b.skssqz) from zcfzbxx b)
             and not exists (select 1
                    from zcfzbxx b
                   where b.skssqz = a.skssqz
                     and a.skssqq > b.skssqq)
             and not exists (select 1
                    from zcfzbxx b
                   where b.skssqz = a.skssqz
                     and a.skssqq = b.skssqq
                     and a.BSRQ < b.BSRQ));

  with lrbxx as
   (select distinct nsrsbh, bsrq, skssqq, skssqz, xm, a.mc, bqje, sqje, bys
      from zx_lrbxx a
     where not exists (select *
              from zx_lrbxx b
             where b.nsrsbh = v_nsrsbh
               and a.lrsj < b.lrsj - 5 / 24 / 60)
       and nsrsbh = v_nsrsbh
       and substr(skssqz, 5, 6) = '-12-31')
  select sum(case
               when substr(skssqz, 1, 4) = substr(sssqz_max_sb, 1, 4) - 1 and
                    xm like '%利润总额%' and xm not like '%会计%' then
                bqje
             end),
         sum(case
               when substr(skssqz, 1, 4) = substr(sssqz_max_sb, 1, 4) - 2 and
                    xm like '%利润总额%' and xm not like '%会计%' then
                bqje
             end)
    into lrze_1, lrze_2
    from lrbxx a
   where skssqz in
         (select max(c.skssqz) from lrbxx c group by substr(c.skssqz, 1, 4))
     and not exists (select 1
            from lrbxx b
           where a.skssqz = b.skssqz
             and a.skssqq > b.skssqq)
     and not exists (select 1
            from lrbxx b
           where a.skssqz = b.skssqz
             and a.skssqq = b.skssqq
             and a.bsrq < b.bsrq);

  select count(*),
         round(sysdate - to_date(nvl(max(substr(bgrq, 1, 10)), '2011-01-01'),
                                 'yyyy-mm-dd'))
    into bgcs_fr, bgrq_fr
    from (select distinct bgrq, bgqnr, bghnr
            from ZX_BGDJXX a
           where bgxmmc in ('法定代表人', '法定代表人（负责人）姓名')
             and nsrsbh = v_nsrsbh
             and bgrq > = to_char(sysdate - 365 * 2, 'yyyy-mm-dd')
             and bgqnr != bghnr
             and not exists
           (select *
                    from ZX_BGDJXX b
                   where b.nsrsbh = v_nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60));
  --增加
  select STDdEV(qbxse) / decode(avg(qbxse), 0, null, avg(qbxse))
    into lsxs_12
    from (select sssqz, sum(qbxse) qbxse
            from (select distinct t.sssqq, t.sssqz, t.qbxse, t.sbrq
                    from zx_sbxx t
                   where t.nsrsbh = v_nsrsbh
                     and not exists
                   (select *
                            from zx_sbxx b
                           where b.nsrsbh = v_nsrsbh
                             and t.lrsj < b.lrsj - 3 / 24 / 60)
                     and to_date(t.sssqz, 'yyyy-mm-dd') >
                         add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -12)
                     and zsxmmc in ('增值税'))
           group by sssqz);

  --被执行人
  select count(*)
    into bzxr_1
    from HSJ_LAWSUIT_DETAIL_ZXGG
   where ent_name = v_nsrmc
     and (pname = v_nsrmc or pname = dbrmc_1)
     and sort_time > to_char(sysdate - 365, 'yyyy-mm-dd');

  --失信被执行人
  select count(*)
    into shixin_bzxr
    from hsj_lawsuit_detail_shixin
   where SORT_TIME > to_char(sysdate - 365 * 3, 'yyyy-mm-dd')
     and ent_name = v_nsrmc
     and (pname = v_nsrmc or pname = dbrmc_1);

  --涉诉信息裁判文书财产保全
  select count(*)
    into cpws_ccbq
    from hsj_lawsuit_detail_cpws a, hsj_lawsuit_detail_cpws_partys b
   where a.cpws_id = b.cpws_id
     and (PNAME = a.ent_name or pname = dbrmc_1)
     and b.status in ('应诉方')
     and sort_time >= to_char(sysdate - 365 * 2, 'yyyy-mm-dd')
     and a.ent_name = v_nsrmc;

  select count(*)
    into XZCF_GS
    from HSJ_LAWSUIT_DETAIL_BGT
   where SORT_TIME > to_char(sysdate - 365 * 5, 'yyyy-mm-dd')
     and ent_name = v_nsrmc
     and (pname = v_nsrmc or pname = dbrmc_1);

  delete t_mod_ind_cal_result_hbyh where nsrsbh_1 = v_nsrsbh;
  insert into t_mod_ind_cal_result_hbyh
    (nl_1,
     tzbl_1,
     jynx_1,
     bgrq_fr,
     bgcs_fr,
     xydj_1,
     nsrzt_1,
     assb_1,
     xwfk_1,
     scbs_1,
     qs_1,
     nsze_1,
     yq_24,
     yq_12,
     yq_6,
     jlr_1,
     syzqy_1,
     kszb_1,
     qbxse_12,
     qbxse_2,
     qbxse_zzl_6,
     qbxse_zzl_12,
     nsze_zzl_12,
     nsze_zz_12,
     sb0_lj,
     sb0_max,
     hy_1,
     nsrsbh_1,
     byxs_12,
     qysds_12,
     WFWZ_1,
     bzxr_1,
     shixin_bzxr,
     cpws_ccbq,
     XZCF_GS,
     nsrzt_gs,
     YZWFWZ_GS)
  values
    (nl_1,
     fr_chigu,
     kyrq_1,
     bgrq_fr,
     bgcs_fr,
     xydj_1,
     nsrzt_1,
     swsjyxx_1,
     xwfk_1,
     round(months_between(sysdate, to_date(sssqq_min_sb, 'yyyy-mm-dd')), 2),
     qs_1,
     nsze_12,
     znj_24,
     znj_12,
     znj_6,
     lrze_1,
     syzqy_1,
     round((-lrze_1) / decode(qbxse_last, 0, 0.1, qbxse_last), 2),
     qbxse_12,
     qbxse_2,
     round((qbxse_6 - qbxse_1_6) / decode(qbxse_1_6, 0, 0.1, qbxse_1_6), 2),
     round((qbxse_12 - qbxse_24) / decode(qbxse_24, 0, 0.1, qbxse_24), 2),
     round((nsze_12 - (nsze_24 - nsze_12)) /
           decode((nsze_24 - nsze_12), 0, 0.1, (nsze_24 - nsze_12)),
           2),
     2 * nsze_12 - nsze_24,
     sb0_1,
     sb0_max,
     sshydm_1,
     v_nsrsbh,
     lsxs_12 * 100,
     qysds_12,
     WFWZ_1,
     bzxr_1,
     shixin_bzxr,
     cpws_ccbq,
     XZCF_GS,
     nsrzt_gs,
     YZWFWZ_GS);
  commit;
  declare
    cursor a_corsor is
      select a.index_dm,
             b.index_value,
             v_nsrsbh,
             DIRECTION,
             a.RULE_LIMIT,
             rule_no,
             rule_description,
             same_or
        from TAX_RULE_SET_INFO_hbyh a,
             (select *
                from t_mod_ind_cal_result_hbyh unpivot(index_value for index_1 in(nl_1,
                                                                                  tzbl_1,
                                                                                  jynx_1,
                                                                                  bgrq_fr,
                                                                                  bgcs_fr,
                                                                                  xydj_1,
                                                                                  nsrzt_1,
                                                                                  assb_1,
                                                                                  xwfk_1,
                                                                                  scbs_1,
                                                                                  qs_1,
                                                                                  nsze_1,
                                                                                  yq_24,
                                                                                  yq_12,
                                                                                  yq_6,
                                                                                  jlr_1,
                                                                                  syzqy_1,
                                                                                  kszb_1,
                                                                                  qbxse_12,
                                                                                  qbxse_2,
                                                                                  qbxse_zzl_6,
                                                                                  qbxse_zzl_12,
                                                                                  nsze_zzl_12,
                                                                                  nsze_zz_12,
                                                                                  sb0_lj,
                                                                                  sb0_max,
                                                                                  hy_1,
                                                                                  qysds_12,
                                                                                  wfwz_1,
                                                                                  bzxr_1,
                                                                                  shixin_bzxr,
                                                                                  cpws_ccbq,
                                                                                  XZCF_GS,
                                                                                  nsrzt_gs,
                                                                                  YZWFWZ_GS))
               where nsrsbh_1 = v_nsrsbh) b
       where index_dm = index_1(+)
         and flag = 1
         and lower(SAME_OR) = '且';
    corsor_1 a_corsor%rowtype;
  begin
    for corsor_1 in a_corsor loop
      sql1 := 'select count(*) from dual where ' || '''' ||
              corsor_1.index_value || '''' || ' ' || corsor_1.DIRECTION || ' ' ||
              corsor_1.RULE_LIMIT;
      --dbms_output.put_line(sql1);
      execute immediate sql1
        into term_1;
      if term_1 >= 1 then
        term_1 := 0;
      else
        term_1 := 1;
        v_out  := v_out || corsor_1.rule_description ||
                  corsor_1.index_value || ';';
      end if;
      --dbms_output.put_line(term_1);
      ysx_1 := ysx_1 + term_1;
      --dbms_output.put_line(v_out);
    end loop;
  end;

  declare
    cursor b_corsor is
      select substr(rule_no, 1, 4) rule_no,
             count(*) cnt,
             wm_concat(RULE_DESCRIPTION) RULE_DESCRIPTION
        from TAX_RULE_SET_INFO_hbyh
       where flag = 1
         and lower(SAME_OR) = '或'
       group by substr(rule_no, 1, 4);
    corsor_2 b_corsor%rowtype;
  begin
    for corsor_2 in b_corsor loop
      term_1 := 0;
      declare
        cursor c_corsor is
          select a.index_dm,
                 b.index_value,
                 v_nsrsbh,
                 DIRECTION,
                 a.RULE_LIMIT,
                 rule_no,
                 rule_description,
                 same_or
            from TAX_RULE_SET_INFO_hbyh a,
                 (select *
                    from t_mod_ind_cal_result_hbyh unpivot(index_value for index_1 in(nl_1,
                                                                                      tzbl_1,
                                                                                      jynx_1,
                                                                                      bgrq_fr,
                                                                                      bgcs_fr,
                                                                                      xydj_1,
                                                                                      nsrzt_1,
                                                                                      assb_1,
                                                                                      xwfk_1,
                                                                                      scbs_1,
                                                                                      qs_1,
                                                                                      nsze_1,
                                                                                      yq_24,
                                                                                      yq_12,
                                                                                      yq_6,
                                                                                      jlr_1,
                                                                                      syzqy_1,
                                                                                      kszb_1,
                                                                                      qbxse_12,
                                                                                      qbxse_2,
                                                                                      qbxse_zzl_6,
                                                                                      qbxse_zzl_12,
                                                                                      nsze_zzl_12,
                                                                                      nsze_zz_12,
                                                                                      sb0_lj,
                                                                                      sb0_max,
                                                                                      hy_1,
                                                                                      qysds_12,
                                                                                      wfwz_1,
                                                                                      bzxr_1,
                                                                                      shixin_bzxr,
                                                                                      cpws_ccbq,
                                                                                      XZCF_GS,
                                                                                      nsrzt_gs,
                                                                                      YZWFWZ_GS))
                   where nsrsbh_1 = v_nsrsbh) b
           where index_dm = index_1(+)
             and flag = 1
             and lower(SAME_OR) = '或'
             and substr(rule_no, 1, 4) = corsor_2.rule_no;
        corsor_3 c_corsor%rowtype;
      begin
        for corsor_3 in c_corsor loop
          sql1 := 'select count(*) from dual where ' || '''' ||
                  corsor_3.index_value || '''' || ' ' || corsor_3.DIRECTION || ' ' ||
                  corsor_3.RULE_LIMIT;
          --dbms_output.put_line(sql1);
          execute immediate sql1
            into term_2;
          term_or_value := term_or_value || ';' || corsor_3.index_value;
          term_1        := term_1 + term_2;
        end loop;
      end;
      if term_1 >= 1 then
        term_1 := 0;
      else
        term_1 := 1;
        v_out  := v_out || corsor_2.rule_description || term_or_value || ';';
      end if;
      ysx_1 := ysx_1 + term_1;
      --dbms_output.put_line(term_1);
      term_or_value := '';
      term_2        := 0;
      term_1        := 0;
    end loop;
  end;
  p_xypf_hbyh_zr(v_nsrsbh, to_char(sysdate, 'yyyy-mm-dd'), xypj_1);

  if xypj_1 in ('A', 'B', 'C') then
    term_1 := 0;
  else
    term_1 := 1;
    v_out  := v_out || '信用评级为：' || xypj_1 || ';';
  end if;
  ysx_1 := ysx_1 + term_1;

  if ysx_1 = 0 then
    v_out        := '预授信通过';
    v_out_result := '00000000';
  else
    v_out        := v_out || '预授信不通过;';
    v_out_result := '22222222';
  end if;
exception
  when others then
    v_out        := v_out || '预授信不通过;';
    v_out_result := '11111111'; --表示失败
end;
