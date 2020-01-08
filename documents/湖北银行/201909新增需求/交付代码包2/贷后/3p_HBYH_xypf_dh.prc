create or replace procedure p_HBYH_xypf_dh(v_nsrsbh     in varchar2,
                                         sssq         in varchar2,
                                         fen_1 out number  ) as
  
  nsrsbh       VARCHAR2(30);
  lrsj         DATE default sysdate;
  zzl_12              number(20, 2);
  nsze_12             number(20, 2);
  xyqszb_1            number(20, 2);
  znj_6               int;
  glfyzzc_1           number(20, 4);
  jlrzchj_1           number(20, 4);
  yszkyysr_1          number(20, 4);
  ljzjzzc_1           number(20, 4);
  ldzcyysr_1          number(20, 4);
  sychs_10            number(20, 4);
  xychs_10            number(20, 4);
  sygs_10             number(20, 4);
  zzl_12_x_woe        number(20, 6);
  sum_1_12_zs_zzs_woe number(20, 6);
  fir_ten_sum_xy_woe  number(20, 6);
  GLFY_ZCHJ_woe       number(20, 6);
  JLR_ZCHJ_woe        number(20, 6);
  YSZK_YYSR_woe       number(20, 6);
  JLJZJ_ZCHJ_woe      number(20, 6);
  LDZCHJ_YYSR_woe     number(20, 6);
  znj_6_woe           number(20, 6);
  sy_ch_count_10_woe  number(20, 6);
  xy_ch_count_10_woe  number(20, 6);
  count_sy_bn_woe     number(20, 6);
  v_out_result             varchar2(30);
  sssq_1              varchar2(30);
  sssqz_max_sb     varchar2(30);
begin

  if sssq is null then
    sssq_1 := to_char(sysdate, 'yyyy-mm-dd');
  else
    sssq_1 := sssq;
  end if;

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

  select zzs12,
            sssqz_max
    into  nsze_12,sssqz_max_sb
    from (select  max(sssqz_max) sssqz_max,
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

  select   nvl(sum(case
                   when sssq_z >
                        to_char(add_months(to_date(sssqz_max_sb, 'yyyy-mm-dd'), -6),
                                'yyyy-mm-dd') and skzl_mc = '滞纳金' then
                    1
                 end),
             0) znj6
    into znj_6
    from sbzsxx a;

  zzl_12     := f_sb(v_nsrsbh, sssq_1, 9);
  xyqszb_1   := f_jydx(v_nsrsbh, sssq_1, 5);
  glfyzzc_1  := f_zcfz(v_nsrsbh, sssq_1, 2);
  jlrzchj_1  := f_zcfz(v_nsrsbh, sssq_1, 9);
  yszkyysr_1 := f_zcfz(v_nsrsbh, sssq_1, 7);
  ljzjzzc_1  := f_zcfz(v_nsrsbh, sssq_1, 10);
  ldzcyysr_1 := f_zcfz(v_nsrsbh, sssq_1, 11);
  sychs_10   := f_jydx(v_nsrsbh, sssq_1, 7);
  xychs_10   := f_jydx(v_nsrsbh, sssq_1, 1);
  sygs_10    := f_jydx(v_nsrsbh, sssq_1, 6);

  if zzl_12 <= -0.3429 then
    zzl_12_x_woe := 1.4677;
  else
    if zzl_12 > -0.3429 and zzl_12 <= -0.1426 then
      zzl_12_x_woe := 0.3933;
    else
      if zzl_12 > -0.1426 and zzl_12 <= 0.0073 then
        zzl_12_x_woe := 0.1980;
      else
        if zzl_12 > 0.0073 and zzl_12 <= 0.1896 then
          zzl_12_x_woe := -0.0890;
        else
          if zzl_12 > 0.1896 and zzl_12 <= 0.4242 then
            zzl_12_x_woe := -0.2332;
          else
            if zzl_12 > 0.4242 then
              zzl_12_x_woe := -0.7972;
            else
              zzl_12_x_woe := 0;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;

  if nsze_12 <= 26941.2750 then
    sum_1_12_zs_zzs_woe := 0.5093;
  else
    if nsze_12 > 26941.2750 and nsze_12 <= 53199.3900 then
      sum_1_12_zs_zzs_woe := 0.0894;
    else
      if nsze_12 > 53199.3900 and nsze_12 <= 91056.9300 then
        sum_1_12_zs_zzs_woe := 0.0874;
      else
        if nsze_12 > 91056.9300 and nsze_12 <= 152692.2300 then
          sum_1_12_zs_zzs_woe := 0.0131;
        else
          if nsze_12 > 152692.2300 and nsze_12 <= 291800.3800 then
            sum_1_12_zs_zzs_woe := -0.1600;
          else
            if nsze_12 > 291800.3800 then
              sum_1_12_zs_zzs_woe := -0.5402;
            else
              sum_1_12_zs_zzs_woe := 0;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;

  if xyqszb_1 <= 0.4641 then
    fir_ten_sum_xy_woe := -0.4867;
  else
    if xyqszb_1 > 0.4641 and xyqszb_1 <= 0.6924 then
      fir_ten_sum_xy_woe := -0.2721;
    else
      if xyqszb_1 > 0.6924 and xyqszb_1 <= 0.9532 then
        fir_ten_sum_xy_woe := -0.0398;
      else
        if xyqszb_1 > 0.9532 then
          fir_ten_sum_xy_woe := 0.4587;
        else
          fir_ten_sum_xy_woe := 0;
        end if;
      end if;
    end if;
  end if;

  if glfyzzc_1 <= 0.0180 then
    GLFY_ZCHJ_woe := 0.6508;
  else
    if glfyzzc_1 > 0.0180 and glfyzzc_1 <= 0.0426 then
      GLFY_ZCHJ_woe := 0.3689;
    else
      if glfyzzc_1 > 0.0426 and glfyzzc_1 <= 0.0748 then
        GLFY_ZCHJ_woe := 0.0874;
      else
        if glfyzzc_1 > 0.0748 and glfyzzc_1 <= 0.1243 then
          GLFY_ZCHJ_woe := -0.3212;
        else
          if glfyzzc_1 > 0.1243 then
            GLFY_ZCHJ_woe := -0.3863;
          else
            GLFY_ZCHJ_woe := 0;
          end if;
        end if;
      end if;
    end if;
  end if;

  if jlrzchj_1 <= 0.0126 then
    JLR_ZCHJ_woe := 0.3250;
  else
    if jlrzchj_1 > 0.0126 and jlrzchj_1 <= 0.0263 then
      JLR_ZCHJ_woe := -0.1600;
    else
      if jlrzchj_1 > 0.0263 then
        JLR_ZCHJ_woe := -0.4084;
      else
        JLR_ZCHJ_woe := 0;
      end if;
    end if;
  end if;

  if yszkyysr_1 <= 0.2496 then
    YSZK_YYSR_woe := -0.2400;
  else
    if yszkyysr_1 > 0.2496 and yszkyysr_1 <= 0.3891 then
      YSZK_YYSR_woe := -0.1155;
    else
      if yszkyysr_1 > 0.3891 and yszkyysr_1 <= 0.6632 then
        YSZK_YYSR_woe := 0.0855;
      else
        if yszkyysr_1 > 0.6632 then
          YSZK_YYSR_woe := 0.7847;
        else
          YSZK_YYSR_woe := 0;
        end if;
      end if;
    end if;
  end if;

  if ljzjzzc_1 <= 0.0031 then
    JLJZJ_ZCHJ_woe := 0.2558;
  else
    if ljzjzzc_1 > 0.0031 and ljzjzzc_1 <= 0.0270 then
      JLJZJ_ZCHJ_woe := 0.1423;
    else
      if ljzjzzc_1 > 0.0270 and ljzjzzc_1 <= 0.1527 then
        JLJZJ_ZCHJ_woe := -0.0691;
      else
        if ljzjzzc_1 > 0.1527 then
          JLJZJ_ZCHJ_woe := -0.2604;
        else
          JLJZJ_ZCHJ_woe := 0;
        end if;
      end if;
    end if;
  end if;

  if ldzcyysr_1 <= 0.2524 then
    LDZCHJ_YYSR_woe := -0.5756;
  else
    if ldzcyysr_1 > 0.2524 and ldzcyysr_1 <= 0.4088 then
      LDZCHJ_YYSR_woe := -0.2874;
    else
      if ldzcyysr_1 > 0.4088 and ldzcyysr_1 <= 0.5832 then
        LDZCHJ_YYSR_woe := -0.1995;
      else
        if ldzcyysr_1 > 0.5832 and ldzcyysr_1 <= 0.8626 then
          LDZCHJ_YYSR_woe := -0.0745;
        else
          if ldzcyysr_1 > 0.8626 and ldzcyysr_1 <= 1.4482 then
            LDZCHJ_YYSR_woe := 0.2087;
          else
            if ldzcyysr_1 > 1.4482 then
              LDZCHJ_YYSR_woe := 0.9828;
            else
              LDZCHJ_YYSR_woe := 0;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;

  if znj_6 = 0 then
    znj_6_woe := -0.1370;
  else
    if znj_6 = 1 then
      znj_6_woe := 0.8764;
    else
      if znj_6 = 2 then
        znj_6_woe := 0.9163;
      else
        if znj_6 = 3 then
          znj_6_woe := 1.8281;
        else
          if znj_6 >= 4 then
            znj_6_woe := 1.9169;
          else
            znj_6_woe := 0;
          end if;
        end if;
      end if;
    end if;
  end if;

  if sychs_10 in (0, 1, 2) then
    sy_ch_count_10_woe := 0.6523;
  else
    if sychs_10 in (3, 4) then
      sy_ch_count_10_woe := 0.0393;
    else
      if sychs_10 in (5, 6, 7) then
        sy_ch_count_10_woe := -0.4409;
      else
        if sychs_10 >= 8 then
          sy_ch_count_10_woe := -0.5427;
        else
          sy_ch_count_10_woe := 0;
        end if;
      end if;
    end if;
  end if;

  if xychs_10 in (0, 1) then
    xy_ch_count_10_woe := 0.5120;
  else
    if xychs_10 in (2, 3) then
      xy_ch_count_10_woe := 0.2641;
    else
      if xychs_10 in (4, 5) then
        xy_ch_count_10_woe := -0.1002;
      else
        if xychs_10 in (6, 7) then
          xy_ch_count_10_woe := -0.2898;
        else
          if xychs_10 >= 8 then
            xy_ch_count_10_woe := -1.3560;
          else
            xy_ch_count_10_woe := 0;
          end if;
        end if;
      end if;
    end if;
  end if;

  if sygs_10 in (0, 1) then
    count_sy_bn_woe := 2.4080;
  else
    if sygs_10 in (2, 3) then
      count_sy_bn_woe := 1.6685;
    else
      if sygs_10 in (4, 5) then
        count_sy_bn_woe := 1.1768;
      else
        if sygs_10 in (6, 7, 8) then
          count_sy_bn_woe := 1.0047;
        else
          if sygs_10 = 9 then
            count_sy_bn_woe := 0.7045;
          else
            if sygs_10 >= 10 then
              count_sy_bn_woe := -0.1763;
            else
              count_sy_bn_woe := 0;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;
  fen_1 := 0.024 + 0.7798 * zzl_12_x_woe + 0.9713 * znj_6_woe +
           0.2837 * sum_1_12_zs_zzs_woe + 0.4184 * sy_ch_count_10_woe +
           0.627 * xy_ch_count_10_woe + 0.5488 * fir_ten_sum_xy_woe +
           0.5208 * count_sy_bn_woe + 0.454 * GLFY_ZCHJ_woe +
           0.4718 * JLR_ZCHJ_woe + 0.2277 * YSZK_YYSR_woe +
           0.7512 * JLJZJ_ZCHJ_woe + 0.2707 * LDZCHJ_YYSR_woe;
  fen_1 := 1 / (1 + exp(-fen_1));

  delete T_ZBB_DH_HBYH where nsrsbh = v_nsrsbh;
  insert into T_ZBB_DH_HBYH
    (nsrsbh,
     lrsj,
     zzl_12,
     znj_6,
     sum_1_12_zs_zzs,
     sy_ch_count_10,
     xy_ch_count_10,
     fir_ten_sum_xy,
     count_sy_bn,
     GLFY_ZCHJ,
     JLR_ZCHJ,
     YSZK_YYSR,
     JLJZJ_ZCHJ,
     LDZCHJ_YYSR,
     zzl_12_x_woe,
     znj_6_woe,
     sum_1_12_zs_zzs_woe,
     sy_ch_count_10_woe,
     xy_ch_count_10_woe,
     fir_ten_sum_xy_woe,
     count_sy_bn_woe,
     GLFY_ZCHJ_woe,
     JLR_ZCHJ_woe,
     YSZK_YYSR_woe,
     JLJZJ_ZCHJ_woe,
     LDZCHJ_YYSR_woe,
     fen_1
     )
  values
    (v_nsrsbh,
     lrsj,
     zzl_12,
     znj_6,
     nsze_12,
     sychs_10,
     xychs_10,
     xyqszb_1,
     sygs_10,
     glfyzzc_1,
     jlrzchj_1,
     yszkyysr_1,
     ljzjzzc_1,
     ldzcyysr_1,
     zzl_12_x_woe,
     znj_6_woe,
     sum_1_12_zs_zzs_woe,
     sy_ch_count_10_woe,
     xy_ch_count_10_woe,
     fir_ten_sum_xy_woe,
     count_sy_bn_woe,
     GLFY_ZCHJ_woe,
     JLR_ZCHJ_woe,
     YSZK_YYSR_woe,
     JLJZJ_ZCHJ_woe,
     LDZCHJ_YYSR_woe,
     fen_1
     );
  commit;
    v_out_result := 0;
exception
  when others then
    v_out_result := 1;
end;
/
