create or replace procedure p_xypf_hbyh_zr(v_nsrsbh in varchar2,
                                        sssq     in varchar2,
                                        xypj_1   out varchar2) as
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
  fen_1               number(20, 6);
  sssq_1              varchar2(30);
begin
  if sssq is null then
    sssq_1 := to_char(sysdate, 'yyyy-mm-dd');
  else
    sssq_1 := sssq;
  end if;

  zzl_6    := f_sb(v_nsrsbh, sssq_1, 1);
  byxs_12  := f_sb(v_nsrsbh, sssq_1, 2);
  qysds_12 := f_sbzs(v_nsrsbh, sssq_1, 2);
  xssr_12  := f_sb(v_nsrsbh, sssq_1, 4);
  glfyzzc  := f_zcfz(v_nsrsbh, sssq_1, 2);
  ljzjsnsr := f_zcfz(v_nsrsbh, sssq_1, 3);
  sszbsr   := f_zcfz(v_nsrsbh, sssq_1, 4);
  wfplr    := f_zcfz(v_nsrsbh, sssq_1, 6);
  znj      := f_sbzs(v_nsrsbh, sssq_1, 1);

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
  else
    if fen_1 <= 0.3195 then
      xypj_1 := 'B';
    else
      if fen_1 <= 0.5 then
        xypj_1 := 'C';
      else
        if fen_1 <= 0.7315 then
          xypj_1 := 'D';
        else
          xypj_1 := 'E';
        end if;
      end if;
    end if;
  end if;
exception
  when others then
    xypj_1 := 'E';
end;
/
