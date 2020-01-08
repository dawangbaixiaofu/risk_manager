create or replace function f_zcfz(v_nsrsbh in varchar2,
                                  sssq     in varchar2,
                                  flag     in varchar2) return number is
  zchj_1     number(20, 2);
  sszb_1     number(20, 2);
  glfy_1     number(20, 2);
  glfy_1_1   number(20, 2);
  ljzj_1     number(20, 2);
  ljzj_1_1   number(20, 2);
  skssqz_max varchar2(30);
  xssr_1_1   number(20, 2);
  xssr_1     number(20, 2);
  yszk_1     number(20, 2);
  wfplr_1    number(20, 2);
  wfplr_1_1  number(20, 2);
  sssq_1     varchar2(15);
  qbxse_1_1  number(20, 2);
  zchj_1_1   number(20, 2);
  lrze_1     number(20, 2);
  jlr_1      number(20, 2);
  jlr_1_1    number(20, 2);
  ldzc_1     number(20, 2);
  qbxse_12   number(20, 2);
  fzhj_1     number(20, 2); --负债合计
  sds_1      number(20, 2); --所得税费用

begin
  select max(skssqz)
    into skssqz_max
    from zx_zcfzbxx a
   where not exists (select *
            from zx_zcfzbxx b
           where  b.nsrsbh= v_nsrsbh
             and a.lrsj < b.lrsj - 5 / 24 / 60)
     and nsrsbh = v_nsrsbh
     and skssqz<=sssq;
  sssq_1 := substr(skssqz_max, 6, 2);
  if sssq_1 < 6 then
    skssqz_max := substr(skssqz_max, 1, 4) - 1 || '-12-31';
  end if;
  with zcfzbxx as
   (select distinct nsrsbh,
                    bsrq,
                    skssqq,
                    skssqz,
                    TO_MULTI_BYTE(trim(xm)) xm,
                    mc,
                    qmye
      from zx_zcfzbxx a
     where not exists (select *
              from zx_zcfzbxx b
             where b.nsrsbh=v_nsrsbh
               and a.lrsj < b.lrsj - 5 / 24 / 60)
       and nsrsbh = v_nsrsbh
       and skssqz <= skssqz_max)
  select decode(zchj1, 0, null, zchj1),
         decode(zchj11, 0, null, zchj11),
         sszb1,
         ljzj1,
         ljzj11,
         yszk1,
         wfplr1,
         wfplr11,
         ldzc1,
         decode(fzhj1, 0, null, fzhj1)
    into zchj_1,
         zchj_1_1,
         sszb_1,
         ljzj_1,
         ljzj_1_1,
         yszk_1,
         wfplr_1,
         wfplr_1_1,
         ldzc_1,
         fzhj_1
    from (select sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '流动资产合计%') then
                        qmye
                       else
                        0
                     end) ldzc1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '资产合计%' or xm like '资产总计%') then
                        qmye
                       else
                        0
                     end) zchj1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            (xm like '资产合计%' or xm like '资产总计%') then
                        qmye
                       else
                        0
                     end) zchj11,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm = '实收资本（或股本）') then
                        qmye
                       else
                        0
                     end) sszb1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '%累计折旧%') then
                        qmye
                     end) ljzj1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            (xm like '%累计折旧%') then
                        qmye
                     end) ljzj11,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            ((xm like '应收帐款%') or (xm like '应收账款%')) then
                        qmye
                       else
                        0
                     end) yszk1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            ((xm like '未分配利润')) then
                        qmye
                       else
                        0
                     end) wfplr1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            ((xm like '未分配利润')) then
                        qmye
                       else
                        0
                     end) wfplr11,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '%负债合计%') and instr(xm,'流动')=0 then
                        qmye
                       else
                        0
                     end) fzhj1
            from zcfzbxx a
           where a.skssqz in (select max(c.skssqz)
                                from zcfzbxx c
                               group by substr(skssqz, 1, 4))
             and not exists (select *
                    from zcfzbxx d
                   where d.skssqz = a.skssqz
                     and a.skssqq > d.skssqq)
             and not exists (select *
                    from zcfzbxx d
                   where d.skssqz = a.skssqz
                     and a.skssqq = d.skssqq
                     and a.bsrq < d.bsrq));

  with lrbxx as
   (select distinct nsrsbh, bsrq, skssqq, skssqz, xm, a.mc, bqje, sqje, bys
      from zx_lrbxx a
     where not exists (select *
              from zx_lrbxx b
             where b.nsrsbh=v_nsrsbh
               and a.lrsj < b.lrsj - 5 / 24 / 60)
       and nsrsbh = v_nsrsbh
       and skssqz <= skssqz_max)
  select jlr1,
         jlr11,
         lrze1,
         glfy1,
         glfy11,
         decode(xssr1, 0, null, xssr1),
         decode(xssr11, 0, null, xssr11),
         sds
    into jlr_1, jlr_1_1, lrze_1, glfy_1, glfy_1_1, xssr_1, xssr_1_1, sds_1
    from (select sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '%净利润%') then
                        bqje
                       else
                        0
                     end) jlr1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            (xm like '%净利润%') then
                        bqje
                       else
                        0
                     end) jlr11,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '%利润总额%') then
                        bqje
                       else
                        0
                     end) lrze1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '%管理费用%') then
                        bqje
                       else
                        0
                     end) glfy1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            (xm like '%管理费用%') then
                        bqje
                       else
                        0
                     end) glfy11,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) and
                            (xm like '%营业收入%' or xm like '%主营业务收入%') then
                        bqje
                       else
                        0
                     end) xssr1,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            (xm like '%营业收入%' or xm like '%主营业务收入%') then
                        bqje
                       else
                        0
                     end) xssr11,
                 sum(case
                       when substr(skssqz, 1, 4) = substr(skssqz_max, 1, 4) - 1 and
                            (xm like '%所得税费用%') then
                        bqje
                       else
                        0
                     end) sds
            from lrbxx a
           where skssqz in (select max(c.skssqz)
                              from lrbxx c
                             group by substr(skssqz, 1, 4))
             and not exists (select 1
                    from lrbxx b
                   where a.skssqz = b.skssqz
                     and a.skssqq > b.skssqq)
             and not exists (select 1
                    from lrbxx b
                   where a.skssqz = b.skssqz
                     and a.skssqq = b.skssqq
                     and a.bsrq < b.bsrq));
  sssq_1 := substr(skssqz_max, 6, 2);
  if sssq_1 >= 6 then
    if flag = 13 then
      qbxse_1_1 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 5);
      return((glfy_1 + glfy_1_1 * qbxse_1_1) / fzhj_1);
    end if;
    if flag = 12 then
      qbxse_1_1 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 5);
      return((sds_1 + qbxse_1_1 * sds_1) / zchj_1);
    end if;
    if flag = 11 then
      qbxse_1_1 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 5);
      return(ldzc_1 / (xssr_1 + qbxse_1_1 * xssr_1_1));
    end if;
    if flag = 10 then
      return(ljzj_1 / zchj_1);
    end if;
    if flag = 9 then
      qbxse_1_1 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 5);
      return((jlr_1 + jlr_1_1 * qbxse_1_1) / zchj_1);
    end if;
    if flag = 8 then
      return(lrze_1);
    end if;
    if flag = 2 then
      qbxse_1_1 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 5);
      return((glfy_1 + glfy_1_1 * qbxse_1_1) / zchj_1);
    end if;
    if flag = 3 then
      return((ljzj_1 - ljzj_1_1) / zchj_1);
    end if;
    if flag = 4 then
      qbxse_12 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 1);
      return(sszb_1 / qbxse_12);
    end if;
    if flag = 6 then
      return((wfplr_1 - wfplr_1_1) / zchj_1);
    end if;
    if flag = 7 then
      qbxse_12 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 1);
      return(yszk_1 / qbxse_12);
    end if;
  else
    if flag = 13 then
      return(glfy_1 / fzhj_1);
    end if;
    if flag = 12 then
      return(sds_1 / zchj_1);
    end if;
    if flag = 11 then
      return(ldzc_1 / xssr_1);
    end if;
    if flag = 10 then
      return(ljzj_1 / zchj_1);
    end if;
    if flag = 9 then
      return(jlr_1 / zchj_1);
    end if;
    if flag = 8 then
      return(lrze_1);
    end if;
    if flag = 2 then
      return(glfy_1_1 / zchj_1);
    end if;
    if flag = 3 then
      return((ljzj_1 - ljzj_1_1) / zchj_1);
    end if;
    if flag = 4 then
      qbxse_12 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 1);
      return((sszb_1) / qbxse_12);
    end if;
    if flag = 6 then
      return((wfplr_1 - wfplr_1_1) / zchj_1);
    end if;
    if flag = 7 then
      qbxse_12 := f_sb_zcfzb(v_nsrsbh, skssqz_max, 1);
      return(yszk_1 / qbxse_12);
    end if;
  end if;
exception
  when others then
   return(null);
end;
/
