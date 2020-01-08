create or replace procedure p_MX_HBYH_dh(v_nsrsbh       in varchar2,
                                         v_out            out varchar2,
                                         v_out_result  out varchar2,
										 fxdj_1   out varchar2
                                                                     ) as
  term_1                           INTEGER;
  nsrsbh                           VARCHAR2(30);
  nsrmc_1                        VARCHAR2(300);
  lrsj                                 DATE default sysdate;
  sql1                               varchar2(1000);
  --sssq_1                           varchar2(32);
  dbrmc_1                       VARCHAR2(300);
  yq_12                            int;  -- 近12个月逾期次数（逾期天数>3)
  yzwfwz_1                       int;  -- 近1月是否严重违法违章（偷、逃、骗税）
  yq_6                              int; -- 近6个月逾期次数
  yq_24                             int; -- 近24个月逾期次数
  assb_1                           int;  -- 未按时申报增值税
  znj_6                             int; -- 近6个月滞纳金次数
  xwfk_6                          int;  -- 近6个月税务行为罚款
  qbxse_zzl_6                   number(20,6);  -- 近6个月销售同比增长
  zzl_12                           number(20,6);  -- 近12个月销售同比增长
  kszb_1                          number(20,6);  -- 上年度 亏损收入比
  kszb_2                          number(20,6);  -- 上上年度 亏损收入比
  lrze_1                            number(20,6);  -- 上一年度利润总额
  lrze_2                            number(20,6);  -- 上上年度利润总额
  lxks_2                           NUMBER(15, 2);  -- 企业连续两期亏损且每期亏损额超过收入的20%
  qs_1                             int;  -- 当月欠税
  xydj_1                          varchar2(32); -- 纳税人信用等级
  hybg_12                       int;  -- 一年内行业发生变更的次数
  nsrzt_1                         varchar2(32);  --纳税人状态
  nslxmc_1                      varchar2(32);  --纳税人类型
  fen_1                            number(20,6);  --微众评分
  sssqz_max_sb                varchar2(32);   --最大申报日期
  qbxse12                        number(20,6);  -- 近12个月全部销售额
  qbxse_last                     number(20,6); 
  qbxse_last2                   number(20,6); 
  sb0_6                            int;
  sb0_6_yb                       int;   --一般纳税人 近6个月累计0申报
  sb0_6_xgm                    int;  --小规模纳税人 近6个月累计0申报
  sb0_12                          int;
  sb0_12_yb                     int;  --一般纳税人 近12个月累计0申报
  sb0_12_xgm                  int;  --小规模纳税人 近12个月累计0申报
  sxbzxr_fr                    int;
  nsrzt_gs                    int;
  bzxr                       int;
  frbg_cs                      int;
  ssxx                        int;
  sxbzxr_qy                      int;
  skssqz_max_lrb          varchar2(32); 
  bhqx_over_30    int;
  thqx_over_30    int;
  bhqx_below_30   int;
  thqx_below_30   int;
begin 
   /*
  if sssq is null then
    sssq_1 := to_char(sysdate, 'yyyy-mm-dd');

  else
    sssq_1 := sssq;
  end if;*/

  /*基本信息*/

  --纳税评级，纳税人状态，纳税人名称，纳税人类型
  select decode(XYDJ, 'D', '4', 'C', '3', 'B', '2', 'A', '1', 'M', '5', '0'),
         decode(NSRZTMC, '正常', '0', '开业', '0', '1'),
         nsrmc,
         decode(nslxmc, '一般纳税人', '1','3')
    into xydj_1, nsrzt_1, nsrmc_1, nslxmc_1
    from (select *
            from zx_nsrjcxx t
           where nsrsbh = v_nsrsbh
           order by lrsj desc)
   where rownum < 2;

  --法人姓名
  select max(dbrmc)  into dbrmc_1 
  from   (select * from
                     (select distinct DBR_ZJHM, dbrmc,dbr_zjlx_mc,lrsj
                         from zx_lxrxx a
                         where nsrsbh = v_nsrsbh
                         and bssf = 1
                         order by lrsj desc ) 
              where rownum < 2);
       
  --违法违章次数
  select NVL(SUM(case
                   when wfwzlxdm in ('01', '02', '03') then
                    1
                   else
                    0
                 end),
             0)
    into yzwfwz_1
    from (select distinct djrq, zywfwzsddm, wfwzlxdm, wfwzztdm
            from zx_wfwzxx a
           where djrq >= to_char(sysdate - 365, 'yyyy-mm-dd')
             and not exists (select 1
                    from zx_wfwzxx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60)
             and nsrsbh = v_nsrsbh);

  --变更信息
  select  count(case when bgrq > = to_char(sysdate - 365, 'yyyy-mm-dd')
                     and bgxmmc like '%国标行业%'
                     then 1 else null
                     end)
    into hybg_12
    from (select distinct bgrq, bgqnr, bghnr, bgxmmc
            from ZX_BGDJXX a
           where nsrsbh = v_nsrsbh
             and bgqnr != bghnr
             and not exists
             (select *
                    from ZX_BGDJXX b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60));

   /*申报表信息*/
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
             where t.nsrsbh = b.nsrsbh
               and t.lrsj < b.lrsj - 3 / 24 / 60))

  select decode((qbxse6 - qbxse61) / decode(qbxse61, 0, 1, qbxse61),'','null',
                        (qbxse6 - qbxse61) / decode(qbxse61, 0, 1, qbxse61)),
         sssqz_max,
         qbxse12,
         decode((qbxse12 - qbxse24)/decode(qbxse12,0,1,qbxse12),'','null',
                      (qbxse12 - qbxse24)/decode(qbxse12,0,1,qbxse12)),
         swsjyxx1
    into   qbxse_zzl_6,
              sssqz_max_sb,
              qbxse12,
              zzl_12,
              assb_1
    from (select max(sssqz_max) sssqz_max,
                 sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -6),
                                    'yyyy-mm-dd')  and ZSXMMC IN ('增值税') then
                        qbxse
                       else
                        '0'
                     end) qbxse6,
                 nvl(sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -18),
                                    'yyyy-mm-dd') and
                            sssqz <=
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                       else
                        '0'
                     end),0) qbxse61,
              sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                       else
                        '0'
                     end) qbxse12,
              sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -24),'yyyy-mm-dd')
                              and      sssqz <=
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                       else
                        '0'
                     end) qbxse24,
                  nvl(sum(case
                           when sssqz = sssqz_max and sbrq > sbqx and
                                ZSXMMC IN ('增值税') then
                            1
                         end),
                     0) swsjyxx1,
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
                                               -12),
                                    'yyyy-mm-dd') AND ZSXMMC IN ('增值税') then
                        nvl(yjse, 0) + ybtse
                     end) zzs12
            from sbxx t);


      --一般纳税人/小规模纳税人 是否按时申报
      if sssqz_max_sb >=
         to_char(trunc(add_months(sysdate, -nslxmc_1 + 1) - 22, 'mm') - 1,
                 'yyyy-mm-dd') then
        assb_1 := 0;
      else
        assb_1 := 1;
      end if;

  with sbxx as
   (select distinct t.sssqq, t.sssqz, sum(t.qbxse) qbxse
      from (select distinct t.sssqq, t.sssqz, t.qbxse
              from zx_sbxx t
             where t.nsrsbh = v_nsrsbh
               and not exists
             (select 1
                      from zx_sbxx b
                     where t.nsrsbh = b.nsrsbh
                       and t.lrsj < b.lrsj - 3 / 24 / 60)
               and ZSXMmc = '增值税'
               and sssqz >
                   to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -6),
                           'yyyy-mm-dd')
               and sssqz <= sssqz_max_sb) t
     group by sssqq, sssqz)
  select sum_qbxse
    into sb0_6
    from (select sum(case
                       when qbxse = 0 then
                        1
                       else
                        0
                     end) sum_qbxse
            from sbxx a);

  if nslxmc_1 = '1' then
    sb0_6_yb := sb0_6;  --一般纳税人
    sb0_6_xgm := 0;   --赋值 否则报错
  else
    sb0_6_xgm := sb0_6;   --小规模纳税人
    sb0_6_yb := 0;   --赋值 否则报错
  end if;

  with sbxx as
   (select distinct t.sssqq, t.sssqz, sum(t.qbxse) qbxse
      from (select distinct t.sssqq, t.sssqz, t.qbxse
              from zx_sbxx t
             where t.nsrsbh = v_nsrsbh
               and not exists (select 1
                      from zx_sbxx b
                     where t.nsrsbh = b.nsrsbh
                       and t.lrsj < b.lrsj - 3 / 24 / 60)
               and ZSXMmc = '增值税'
               and sssqz > to_char(add_months(to_date(sssqz_max_sb,
                                                      'yyyy-mm-dd'),
                                              -12),
                                   'yyyy-mm-dd')
               and sssqz <= sssqz_max_sb) t
     group by sssqq, sssqz)
  select sum_qbxse
    into sb0_12
    from (select sum(case
                       when qbxse = 0 then
                        1
                       else
                        0
                     end) sum_qbxse
            from sbxx a);

  if nslxmc_1 = '1' then
    sb0_12_yb := sb0_12;   --一般纳税人
    sb0_12_xgm := 0;   --赋值 否则报错
  else
    sb0_12_xgm := sb0_12;  --小规模纳税人
    sb0_12_yb := 0; --赋值 否则报错
  end if;

    /*征收表信息*/
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
             where a.nsrsbh = b.nsrsbh
               and a.lrsj < b.lrsj - 3 / 24 / 60)
       and sssq_z >= to_char(add_months(sysdate, -30), 'yyyy-mm-dd')   --30个月的数据
       and nsrsbh = v_nsrsbh)

   --欠税，逾期次数（>3天 ）、行为罚款次数
  select nvl(sum(case
                   when sssq_z = sssqz_max_sb and
                        (jkfsrq is null or jkfsrq = 'NULL') and
                        jkqx < to_char(sysdate, 'yyyy-mm-dd')  then
                    se
                 end),
             0) qs_dh,
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -6),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金'
                        and  to_date(jkfsrq, 'yyyy-mm-dd') - to_date(jkqx, 'yyyy-mm-dd') > 3
                        then
                    1
                 end),
             0)  yqcs_6,
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -12),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金'
                        and  to_date(jkfsrq, 'yyyy-mm-dd') - to_date(jkqx, 'yyyy-mm-dd') > 3
                        then
                    1
                 end),
             0)  yqcs_12,
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -24),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金'
                        and  to_date(jkfsrq, 'yyyy-mm-dd') - to_date(jkqx, 'yyyy-mm-dd') > 3
                        then
                    1
                 end),
             0)  yqcs_24,
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -6),
                                'yyyy-mm-dd') and skzl_mc in ('行为罚款', '涉税罚款', '没收非法所得','没收违法所得')  then
                    1
                 end),
             0) xwfk_6,
         nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -6),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金' then
                    1
                 end),
             0) znj6
    into qs_1, yq_6, yq_12, yq_24, xwfk_6,znj_6
    from sbzsxx a;

    /*利润表信息*/
  --利润表
  with lrbxx as
   (select distinct nsrsbh,
                    bsrq,
                    skssqq,
                    skssqz,
                    xm,
                    a.mc,
                    bqje,
                    sqje,
                    bys,
                    max(skssqz) over() skssqz_max_lrb
      from zx_lrbxx a
     where nsrsbh = v_nsrsbh
       and  not exists (select *
              from zx_lrbxx b
             where b.nsrsbh = a.nsrsbh
               and a.lrsj < b.lrsj - 5 / 24 / 60)
       and skssqz >= to_char(sysdate - 365 * 2, 'yyyy')
       )
 
 select sum(case
               when skssqz = skssqz_max_lrb and
                    xm like '%净利润%' and xm not like '%经营%' and xm not like '%归属%'
          then bqje
             end),
         sum(case
               when substr(skssqz, 1, 4) = substr(skssqz_max_lrb, 1, 4) - 1 and
                    xm like '%净利润%' and xm not like '%经营%' and xm not like '%归属%' and 
                    substr(skssqz, 5, 6) = '-12-31'  then
                bqje
             end),
       max(skssqz_max_lrb)
    into lrze_1, lrze_2, skssqz_max_lrb
    from lrbxx a
   where skssqz in (select max(c.skssqz)
                      from lrbxx c
                     where a.nsrsbh = c.nsrsbh
                     group by substr(c.skssqz, 1, 4))
     and not exists (select 1
            from lrbxx b
           where a.nsrsbh = b.nsrsbh
             and a.skssqz = b.skssqz
             and a.skssqq > b.skssqq)
     and not exists (select 1
            from lrbxx b
           where a.nsrsbh = b.nsrsbh
             and a.skssqz = b.skssqz
             and a.skssqq = b.skssqq
             and a.bsrq < b.bsrq);


  /*申报表信息*/
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
       and ZSXMMC IN ('增值税')
       and not exists (select 1
              from zx_sbxx b
             where t.nsrsbh = b.nsrsbh
               and t.lrsj < b.lrsj - 3 / 24 / 60))

  select  qbxselast,qbxselast2
    into    qbxse_last, qbxse_last2
    from (select nvl(sum(case
                       when substr(sssqz, 1, 4) = substr(skssqz_max_lrb, 1, 4)
                        then qbxse
                     end),0) qbxselast,
                 nvl(sum(case
                       when substr(sssqz, 1, 4) = substr(skssqz_max_lrb, 1, 4) - 1 
             then qbxse
                     end),0) qbxselast2
            from sbxx t);

   --连续两期亏损占比
   select round(decode(lrze_1,null,0,lrze_1) / decode(qbxse_last, 0, 1, qbxse_last), 2),
            round(decode(lrze_2,null,0,lrze_2) / decode(qbxse_last2, 0, 1, qbxse_last2), 2)
   into kszb_1,kszb_2
   from dual;

   --连续两期亏损预警
   if lrze_1 < 0 and lrze_2 < 0 and kszb_1 < -0.2 and kszb_2 < -0.2 then
     lxks_2 := 1;
   else
     lxks_2 := 0;
   end if;

  --工商状态
  select count(*)
    into nsrzt_gs
    from (select *
            from HSJ_BASIC
           where ent_name = nsrmc_1
           order by lrsj desc)
   where rownum = 1
     and ent_status in ('吊销','注销','其他');

    select count(*) 
    into frbg_cs
    from HSJ_ALTER 
    where ent_name = nsrmc_1
    and alt_item like  '%法定代表人%' 
    and alt_date>= to_char(sysdate - 180,'yyyy-mm-dd');
    
  /*司法信息*/
  --被执行人
  select count(distinct case_no)
    into bzxr
    from HSJ_LAWSUIT_DETAIL_ZXGG a
   where ent_name = nsrmc_1
     and (pname = nsrmc_1 or pname = dbrmc_1)
     and sort_time > to_char(sysdate - 365, 'yyyy-mm-dd')
	 and not exists(select *
                    from HSJ_LAWSUIT_DETAIL_ZXGG b
                    where b.ent_name = a.ent_name
                    and a.lrsj < b.lrsj - 3 / 24 / 60);

  --失信被执行人
  select count(distinct yj_code)
    into sxbzxr_fr
    from hsj_lawsuit_detail_shixin a
   where SORT_TIME > to_char(sysdate - 365 * 3, 'yyyy-mm-dd')
     and pname = dbrmc_1
	 and not exists(select *
                    from hsj_lawsuit_detail_shixin b
                    where b.ent_name = a.ent_name
                    and a.lrsj < b.lrsj - 3 / 24 / 60);
					
  select count(distinct yj_code)
    into sxbzxr_qy
    from hsj_lawsuit_detail_shixin a
   where SORT_TIME > to_char(sysdate - 365 * 3, 'yyyy-mm-dd')
     and pname = nsrmc_1
	 and not exists(select *
                    from hsj_lawsuit_detail_shixin b
                    where b.ent_name = a.ent_name
                    and a.lrsj < b.lrsj - 3 / 24 / 60);


  --涉诉信息裁判文书财产保全
  select count(distinct a.cpws_id)
    into ssxx
    from hsj_lawsuit_detail_cpws a, hsj_lawsuit_detail_cpws_partys b
   where a.cpws_id = b.cpws_id
     and sort_time >= to_char(sysdate - 365 * 1, 'yyyy-mm-dd')
     and (case_cause like '%申请诉前财产保全%' or  
            case_cause like '%借款合同纠纷%' or 
            case_cause like '%买卖合同纠纷%')
     and PNAME in (dbrmc_1 ,nsrmc_1);

    --征信
    select count(*)  into bhqx_over_30 from ZX_ICR_LOAN_INFO t
    where t.balance > 0 and t.finance_org like '%湖北银行%'
    and t.curr_overdue_amount>0
    and ( t.overdue_31_to_60_amount > 0 or
             t.overdue_61_to_90_amount > 0 or
             t.overdue_91_to_180_amount > 0 or
             t.overdue_over_180_amount > 0 or
             t.class_5_state in ('关注','次级','可疑','损失')
             )
     and t.NSRSBH = v_nsrsbh;
             
    select count(*)  into thqx_over_30 from ZX_ICR_LOAN_INFO t
    where t.balance > 0 and t.finance_org not like '%湖北银行%'
    and t.curr_overdue_amount>0
    and ( t.overdue_31_to_60_amount > 0 or
             t.overdue_61_to_90_amount > 0 or
             t.overdue_91_to_180_amount > 0 or
             t.overdue_over_180_amount > 0 or
             t.class_5_state in ('关注','次级','可疑','损失')
             )
     and t.NSRSBH = v_nsrsbh;
             
    select count(*)  into bhqx_below_30 from ZX_ICR_LOAN_INFO t
    where t.balance > 0 and t.finance_org like '%湖北银行%'
    and  t.curr_overdue_amount>0
    and  t.overdue_31_to_60_amount = 0 
    and  t.overdue_61_to_90_amount = 0
    and  t.overdue_91_to_180_amount = 0 
    and  t.overdue_over_180_amount = 0
    and t.NSRSBH = v_nsrsbh;


    select count(*)  into thqx_below_30 from ZX_ICR_LOAN_INFO t
    where t.balance > 0 and t.finance_org not like '%湖北银行%'
    and  t.curr_overdue_amount>0
    and  t.overdue_31_to_60_amount = 0 
    and  t.overdue_61_to_90_amount = 0
    and  t.overdue_91_to_180_amount = 0 
    and  t.overdue_over_180_amount = 0    
    and t.NSRSBH = v_nsrsbh;
    
  p_HBYH_xypf_dh(v_nsrsbh,'',fen_1 )  ;
  
  delete t_warning_index_values_HBYH where nsrsbh_1 = v_nsrsbh;
  insert into t_warning_index_values_HBYH
      (nsrsbh_1, 
        yzwfwz_1, 
        assb_1, 
        nsrzt_1, 
        xydj_1, 
        qs_1, 
        yq_6, 
        yq_12, 
        yq_24, 
        sb0_6_yb, 
        sb0_12_yb, 
        sb0_6_xgm, 
        sb0_12_xgm, 
        qbxse_zzl_6, 
        hybg_12, 
        xwfk_6, 
        kszb_1, 
        lxks_2, 
        xypf_wz, 
        nsrzt_gs, 
        bzxr, 
        frbg_cs, 
        ssxx, 
        sxbzxr_qy, 
        sxbzxr_fr,
        bhqx_over_30, 
        thqx_over_30, 
        bhqx_below_30, 
        thqx_below_30 )
  values
        (v_nsrsbh, 
        yzwfwz_1, 
        assb_1, 
        nsrzt_1, 
        xydj_1, 
        qs_1, 
        yq_6, 
        yq_12, 
        yq_24, 
        sb0_6_yb, 
        sb0_12_yb, 
        sb0_6_xgm, 
        sb0_12_xgm, 
        qbxse_zzl_6, 
        hybg_12, 
        xwfk_6, 
        kszb_1, 
        lxks_2, 
        fen_1, 
        nsrzt_gs, 
        bzxr, 
        frbg_cs, 
        ssxx, 
        sxbzxr_qy, 
        sxbzxr_fr,
        bhqx_over_30, 
        thqx_over_30, 
        bhqx_below_30, 
        thqx_below_30 );
  commit;


  delete t_warning_result_HBYH
   where nsrsbh = v_nsrsbh
     and WARNING_MONTH = to_char(sysdate, 'yyyy-mm');
  delete T_WARNING_RESULT_DES_HBYH where nsrsbh = v_nsrsbh;

  declare
    cursor a_corsor is
      select index_dm,
             index_remark,
             lower_limit,
             upper_limit,
             warning_level,
             id,
             lower_lab,
             upper_lab,
             flag,
             index_value
        from t_index_ely_warning_HBYH a,
             (select *
                from t_warning_index_values_HBYH t unpivot(index_value for index_1 in(    yzwfwz_1    ,
                                                                                                                                        assb_1      ,
                                                                                                                                        nsrzt_1     ,
                                                                                                                                        xydj_1      ,
                                                                                                                                        qs_1        ,
                                                                                                                                        yq_6        ,
                                                                                                                                        yq_12       ,
                                                                                                                                        yq_24       ,
                                                                                                                                        sb0_6_yb    ,
                                                                                                                                        sb0_12_yb   ,
                                                                                                                                        sb0_6_xgm   ,
                                                                                                                                        sb0_12_xgm  ,
                                                                                                                                        qbxse_zzl_6 ,
                                                                                                                                        hybg_12     ,
                                                                                                                                        xwfk_6      ,
                                                                                                                                        kszb_1      ,
                                                                                                                                        lxks_2      ,
                                                                                                                                        XYPF_WZ     ,
                                                                                                                                        nsrzt_gs    ,
                                                                                                                                        bzxr        ,
                                                                                                                                        frbg_cs     ,
                                                                                                                                        ssxx        ,
                                                                                                                                        sxbzxr_qy   ,
                                                                                                                                        sxbzxr_fr    ,
                                                                                                                                        bhqx_over_30, 
                                                                                                                                        thqx_over_30, 
                                                                                                                                        bhqx_below_30, 
                                                                                                                                        thqx_below_30 ) )
               where nsrsbh_1 = v_nsrsbh) b
       where upper(index_dm) = upper(index_1(+))
         and flag = 1;
    corsor_1 a_corsor%rowtype;

  begin
    for corsor_1 in a_corsor loop
      sql1 := 'select count(*) from dual where ' || corsor_1.index_value || ' ' ||
              corsor_1.lower_lab || corsor_1.lower_limit || ' and ' ||
              corsor_1.index_value || ' ' || corsor_1.upper_lab ||
              corsor_1.upper_limit;
      dbms_output.put_line(sql1);
      execute immediate sql1
        into term_1;
      --dbms_output.put_line(term_1);
      if term_1 >= 1 then
        insert into t_warning_result_HBYH   --分表
          (nsrsbh, index_dm, remark, index_value, warning_levl, NSRMC)
        values
          (v_nsrsbh,
           corsor_1.index_dm,
           corsor_1.index_remark,
           corsor_1.index_value,
           corsor_1.warning_level,
           NSRMC_1);
        if corsor_1.warning_level != '正常' then
          v_out_result := v_out_result || corsor_1.index_remark || ':' ||
                   corsor_1.index_value || ':' || corsor_1.warning_level || ';';
        end if;
      end if;
      commit;
    end loop;
       --预警表
    insert into T_WARNING_RESULT_DES_HBYH
     (nsrsbh, nsrmc, des, lrsj, nsrsbh_wj)
     values
     (v_nsrsbh, nsrmc_1, decode(v_out_result,'','正常',v_out_result), sysdate, v_nsrsbh);
     commit;
   end;

   if  v_out_result is null  then
       v_out := '0';
       v_out_result := '正常';
   else
       v_out := '1';
   end if;

   select case
           when des like '%一级预警%' then
            '一级预警'
           when des like '%二级预警%' then
            '二级预警'
           when des like '%三级预警%' then
            '三级预警'
           else
            '正常'
         end
    into fxdj_1
    from (select * from T_WARNING_RESULT_DES_HBYH order by lrsj desc)
   where rownum <= 1;


exception
  when others then
    v_out := '9';
    v_out_result := substr(sqlerrm,1,200);
     insert into T_WARNING_RESULT_DES_HBYH
     (nsrsbh, nsrmc, des, lrsj, nsrsbh_wj)
     values
     (v_nsrsbh, nsrmc_1,v_out_result, sysdate, v_nsrsbh);
     commit;
end;
/
