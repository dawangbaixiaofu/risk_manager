create or replace procedure p_xypf_hbyh(v_nsrsbh in varchar2,
                                        sssq     in varchar2,
                                        rzye_1   in number,
                                        ysxed    out number,
                                        rate_1   out number) as
  zzl_6               number(20, 9);
  byxs_12             number(20, 9);
  glfyzzc             number(20, 9);
  ljzjsnsr            number(20, 9);
  xssr_12             number(20, 9);
  sszbsr              number(20, 9);
  qysds_12            number(20, 9);
  znj                 int;
  fen                 number(20, 12);
  zzl_woe             number(20, 9);
  m_24_woe            number(20, 9);
  cv_woe              number(20, 9);
  GLFY_zzc_woe        number(20, 9);
  zs_znj_1_12_woe     number(20, 9);
  JLJZJ_yysr_snsr_woe number(20, 9);
  zs_sds_1_12_woe     number(20, 9);
  SSZB_yysr_bn_woe    number(20, 9);
  wfplr               number(20, 9);
  wfplr_woe           number(20, 9);
  xypj_1              varchar2(1);
  fen_1               number(20, 6);
  sssqz_max           varchar2(20);
  qbxse_12            number(20, 2);
  nsze_12             number(20, 2);
  --ysxed_1             number(20, 2);
  edxs_1 number(20, 2);
  --ysxed_2             number(20, 2);
  swjg_1           varchar2(30);
  DBR_ZJHM_1       varchar2(30);
  BALANCE_AMOUNT_1 number(20, 2);
  nsze_24   number(20, 2);
  qbxse_24  number(20, 2);
  ed_level_1    varchar2(30);
  sshydm_1     varchar2(30);
  HY_FXXS    number(20, 6);
  preCreditAmount   number(20, 0);
  dqjk_1    number(20, 2);
begin
  zzl_6    := f_sb(v_nsrsbh, sssq, 1);
  byxs_12  := f_sb(v_nsrsbh, sssq, 2);
  qysds_12 := f_sbzs(v_nsrsbh, sssq, 2);
  xssr_12  := f_sb(v_nsrsbh, sssq, 4);
  glfyzzc  := f_zcfz(v_nsrsbh, sssq, 2);
  ljzjsnsr := f_zcfz(v_nsrsbh, sssq, 3);
  sszbsr   := f_zcfz(v_nsrsbh, sssq, 4);
  wfplr    := f_zcfz(v_nsrsbh, sssq, 6);
  znj      := f_sbzs(v_nsrsbh, sssq, 1);

  --申请日前6个月
  if zzl_6 <= -0.5 then
    zzl_woe := 0.8974;
  else
    if zzl_6 > -0.5 and zzl_6 <= -0.3 then
      zzl_woe := 0.5494;
    else
      if zzl_6 > -0.3 and zzl_6 <= -0.2 then
        zzl_woe := -0.3083;
      else
        if zzl_6 > -0.2 and zzl_6 <= 0.2 then
          zzl_woe := -0.3902;
        else
          if zzl_6 > 0.2 and zzl_6 <= 0.3 then
            zzl_woe := -0.6016;
          else
            if zzl_6 > 0.3 and zzl_6 <= 0.5 then
              zzl_woe := -0.3298;
            else
              if zzl_6 > 0.5 then
                zzl_woe := 0.0455;
              else
                zzl_woe := 0.8974;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;
  --申请日前12个月全部销售额变异系数
  if byxs_12 <= 35.16860074 then
    cv_woe := -0.486244826;
  else
    if byxs_12 > 35.168600742 and byxs_12 <= 51.315527571 then
      cv_woe := -0.400386377;
    else
      if byxs_12 > 51.31552757 and byxs_12 <= 67.56801323 then
        cv_woe := 0.156799688;
      else
        if byxs_12 > 67.56801323 and byxs_12 <= 99.33988763 then
          cv_woe := 0.165801541;
        else
          if byxs_12 > 99.33988763 then
            cv_woe := 0.597665165;
          else
            cv_woe := 0.5976;
          end if;
        end if;
      end if;
    end if;
  end if;
  --管理费用/资产
  if glfyzzc <= 0.020271625 then
    GLFY_zzc_woe := 0.506934568;
  else
    if glfyzzc > 0.020271625 and glfyzzc <= 0.045108704 then
      GLFY_zzc_woe := 0.349867163;
    else
      if glfyzzc > 0.045108704 and glfyzzc <= 0.081484141 then
        GLFY_zzc_woe := 0.068152888;
      else
        if glfyzzc > 0.081484141 and glfyzzc <= 0.165180757 then
          GLFY_zzc_woe := -0.32815618;
        else
          if glfyzzc > 0.165180757 then
            GLFY_zzc_woe := -0.604561744;
          else
            GLFY_zzc_woe := '0';
          end if;
        end if;
      end if;
    end if;
  end if;
  --净累计折旧的增加/本年收入
  if ljzjsnsr <= 0.00000012223697 then
    JLJZJ_yysr_snsr_woe := 0.3147980011;
  else
    if ljzjsnsr > 0.00000012223697 and ljzjsnsr <= 0.0014082302 then
      JLJZJ_yysr_snsr_woe := 0.2692200096;
    else
      if ljzjsnsr > 0.0014082302 and ljzjsnsr <= 0.008573177 then
        JLJZJ_yysr_snsr_woe := 0.1854444681;
      else
        if ljzjsnsr > 0.008573177 and ljzjsnsr <= 0.0223985007 then
          JLJZJ_yysr_snsr_woe := -0.284134712;
        else
          if ljzjsnsr > 0.0223985007 then
            JLJZJ_yysr_snsr_woe := -0.523855124;
          else
            JLJZJ_yysr_snsr_woe := 0;
          end if;
        end if;
      end if;
    end if;
  end if;

  --申请日前12个月全部销售额
  if xssr_12 <= 1676730.965 then
    m_24_woe := 0.500482933;
  else
    if xssr_12 > 1676730.965 and xssr_12 <= 2958254.36 then
      m_24_woe := 0.1621188495;
    else
      if xssr_12 > 2958254.36 and xssr_12 <= 5493049.86 then
        m_24_woe := -0.092298478;
      else
        if xssr_12 > 5493049.86 and xssr_12 <= 10364223.18 then
          m_24_woe := -0.200670695;
        else
          if xssr_12 > 10364223.18 then
            m_24_woe := -0.364065961;
          else
            m_24_woe := 0.500482933;
          end if;
        end if;
      end if;
    end if;
  end if;
  --实收资本/本年收入
  if sszbsr <= 0.125625152 then
    SSZB_yysr_bn_woe := -0.4901664;
  else
    if sszbsr > 0.125625152 and sszbsr <= 0.251594996 then
      SSZB_yysr_bn_woe := -0.437148903;
    else
      if sszbsr > 0.251594996 and sszbsr <= 0.473576412 then
        SSZB_yysr_bn_woe := -0.244520085;
      else
        if sszbsr > 0.473576412 and sszbsr <= 0.887795412 then
          SSZB_yysr_bn_woe := 0.542017236;
        else
          if sszbsr > 0.887795412 then
            SSZB_yysr_bn_woe := 0.6476; ---
          else
            SSZB_yysr_bn_woe := 0.6476;
          end if;
        end if;
      end if;
    end if;
  end if;
  --企业所得税
  if qysds_12 <= 3391.215 then
    zs_sds_1_12_woe := 0.267436309;
  else
    if qysds_12 > 3391.215 and qysds_12 <= 12112.06 then
      zs_sds_1_12_woe := 0.029199155;
    else
      if qysds_12 > 12112.06 and qysds_12 <= 39612.505 then
        zs_sds_1_12_woe := -0.244520085;
      else
        if qysds_12 > 39612.505 then
          zs_sds_1_12_woe := -0.319770387;
        else
          zs_sds_1_12_woe := 0.267436309;
        end if;
      end if;
    end if;
  end if;
  --未分配利润的差额/资产
  if wfplr <= -0.001072484 then
    wfplr_woe := 0.4383748422;
  else
    if wfplr > -0.001072484 and wfplr <= 0.0041222314 then
      wfplr_woe := 0.1645934535;
    else
      if wfplr > 0.0041222314 and wfplr <= 0.0131651872 then
        wfplr_woe := -0.040703293;
      else
        if wfplr > 0.013165187 and wfplr <= 0.0304703061 then
          wfplr_woe := -0.493556749;
        else
          if wfplr > 0.0304703061 then
            wfplr_woe := -0.517032005;
          else
            wfplr_woe := 0.43837;
          end if;
        end if;
      end if;
    end if;
  end if;

  --滞纳金
  if znj = 0 then
    zs_znj_1_12_woe := -0.21385;
  else
    if znj = 1 then
      zs_znj_1_12_woe := 0.52884;
    else
      if znj >= 2 and znj < 4 then
        zs_znj_1_12_woe := 1.13943;
      else
        if znj >= 4 then
          zs_znj_1_12_woe := 1.38629;
        else
          zs_znj_1_12_woe := -0.21385;
        end if;
      end if;
    end if;
  end if;

  fen := zzl_woe * -0.7729 + cv_woe * -0.3039 + m_24_woe * -0.3324 +
         zs_sds_1_12_woe * -0.6511 + GLFY_zzc_woe * -0.6266 +
         SSZB_yysr_bn_woe * -0.5096 + JLJZJ_yysr_snsr_woe * -0.6204 +
         wfplr_woe * -0.5772 + zs_znj_1_12_woe * -1.1087 - 0.00187;
  fen := -fen;

  fen_1 := round(1 / (1 + exp(-fen)), 4);
  if fen_1 <= 0.1486 then
    xypj_1 := 'A';
    edxs_1 := 1;
  else
    if fen_1 <= 0.3195 then
      xypj_1 := 'B';
      edxs_1 := 0.9;
    else
      if fen_1 <= 0.5 then
        xypj_1 := 'C';
        edxs_1 := 0.8;
      else
        if fen_1 <= 0.7315 then
          xypj_1 := 'D';
        else
          xypj_1 := 'E';
        end if;
      end if;
    end if;
  end if;

/*
  select max(sssqz)
    into sssqz_max
    from zx_sbxx a
   where nsrsbh = v_nsrsbh
     and not exists (select 1
            from zx_sbxx b
           where a.LRSJ < b.lrsj - 130 / 24 / 60 / 60
             and b.nsrsbh = v_nsrsbh)
     and sssqz <= sssq;

  with sbzsxx as
   (select distinct nsrsbh, sssq_q, sssq_z, jkqx, jkfsrq, se, skzl_mc
      from zx_sbzsxx a
     where not exists
     (select 1
              from zx_sbzsxx b
             where b.nsrsbh = v_nsrsbh
               and a.lrsj < b.lrsj - 3 / 24 / 60)
       and sssq_z >= to_char(add_months(sysdate, -30), 'yyyy-mm-dd')
       and nsrsbh = v_nsrsbh)
  select sum(case
               when sssq_z >
                    to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -24),
                            'yyyy-mm-dd') and skzl_mc != '滞纳金' then
                se
             end) / 2
    into nsze_12
    from sbzsxx a;

  select t_mod_ind_cal_result_hbyh.qbxse_12
    into qbxse_12
    from t_mod_ind_cal_result_hbyh
   where nsrsbh_1 = v_nsrsbh;
*/
  select decode(substr(swjg_dm, 2, 4), '4201', '4201', '0000'),SSHYDM
    into swjg_1,sshydm_1
    from (select *
            from zx_nsrjcxx
           where nsrsbh = v_nsrsbh
           order by lrsj desc)
   where rownum = 1;

  select DBR_ZJHM
    into DBR_ZJHM_1
    from (select DBR_ZJHM
            from zx_lxrxx
           where nsrsbh = v_nsrsbh
             and bssf = 1
           order by lrsj desc)
   where rownum = 1;

  select nvl(max(BALANCE_AMOUNT), 0)
    into BALANCE_AMOUNT_1
    from (select sum(BALANCE_AMOUNT) BALANCE_AMOUNT
            from bank_balance_loan a
           where IDENTITY_NO = DBR_ZJHM_1
             and not exists
           (select *
                    from bank_balance_loan b
                   where a.IDENTITY_NO = b.IDENTITY_NO
                     and a.CREATE_TIME < b.CREATE_TIME));

  /*
  select max(RATE)
    INTO rate_1
    from SYS_RATE_CONFIGURE
   where GRADE = xypj_1
     and dq = swjg_1;
   */
   
   rate_1 := 0.0775;
   

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
       and ZSXMMC IN ('消费税','增值税','企业所得税')
       and not exists (select 1
              from zx_sbxx b
             where b.nsrsbh = v_nsrsbh
               and t.lrsj < b.lrsj - 3 / 24 / 60))

    select nvl(zzs24, 0)  + nvl(qysds24, 0) + nvl(xfs24, 0),
              qbxse24,
              qbxse12
    into  nsze_24, 
            qbxse_24,
            qbxse_12
    from (select  sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -24),
                                    'yyyy-mm-dd') and zsxmmc = '消费税' then
                        ybtse
                     end) xfs24,
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
                                               -24),
                                    'yyyy-mm-dd') AND ZSXMMC IN ('企业所得税') then
                        ybtse
                     end) qysds24,
           sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -24),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse24,
                sum(case
                       when sssqz >
                            to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'),
                                               -12),
                                    'yyyy-mm-dd') and ZSXMMC IN ('增值税') then
                        qbxse
                     end) qbxse12
         from sbxx);

  -- 行业额度系数
  if qbxse_12 <= 5000000 then
      ed_level_1 := 'A';
  ELSE
    IF qbxse_12 > 30000000 THEN
      ed_level_1 := 'C';
    ELSE
      ed_level_1 := 'B';
    END IF;
  END IF;

  SELECT nvl(max(edxs),0.5) INTO HY_FXXS
  FROM T_HYDM_EDXS_HBYH
  WHERE ED_LEVEL = ed_level_1
  AND HYDM_2 = substr(sshydm_1,-4, 2);
  
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
  select 
		 sum(case
               when xm like '%短期借款%' then
                qmye
             end)
    into dqjk_1 
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


  preCreditAmount := round(least(500000,
                                 ((qbxse_24/2 -dqjk_1 )*0.15*0.7 +((nsze_24/2)*5*0.3) ) *hy_fxxs )
							, -3);
 

  /* ysxed := qbxse_12 * 0.15 * edxs_1 * 0.7 + nsze_12 * 5 * edxs_1 * 0.3;*/

  ysxed := nvl(preCreditAmount - nvl(rzye_1,0) - nvl(BALANCE_AMOUNT_1, 0), -1);

  if ysxed < 0 then
     ysxed := 0;
  end if;

  delete t_zbb_hbyh where nsrsbh = v_nsrsbh;
  insert into t_zbb_hbyh
    (lrsj,
     nsrsbh,
     sssq,
     rzye_1,
     ysxed,
     rate_1,
     zzl_6,
     byxs_12,
     glfyzzc,
     ljzjsnsr,
     xssr_12,
     sszbsr,
     qysds_12,
     znj,
     fen,
     zzl_woe,
     m_24_woe,
     cv_woe,
     glfy_zzc_woe,
     zs_znj_1_12_woe,
     jljzj_yysr_snsr_woe,
     zs_sds_1_12_woe,
     sszb_yysr_bn_woe,
     wfplr,
     wfplr_woe,
     xypj_1,
     fen_1,
     qbxse_12,
     nsze_12,
     swjg_1,
     lv_1)
  values
    (sysdate,
     v_nsrsbh,
     sssq,
     rzye_1 + BALANCE_AMOUNT_1,
     ysxed,
     rate_1,
     zzl_6,
     byxs_12,
     glfyzzc,
     ljzjsnsr,
     xssr_12,
     sszbsr,
     qysds_12,
     znj,
     fen,
     zzl_woe,
     m_24_woe,
     cv_woe,
     glfy_zzc_woe,
     zs_znj_1_12_woe,
     jljzj_yysr_snsr_woe,
     zs_sds_1_12_woe,
     sszb_yysr_bn_woe,
     wfplr,
     wfplr_woe,
     xypj_1,
     fen_1,
     qbxse_12,
     nsze_12,
     swjg_1,
     rate_1);
  commit;
exception
  when others then
    ysxed := -1;
end;
