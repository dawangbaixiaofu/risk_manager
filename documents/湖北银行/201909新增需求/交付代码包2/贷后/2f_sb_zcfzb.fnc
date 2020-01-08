create or replace function f_sb_zcfzb(v_nsrsbh in varchar2,
                                      sssq     in varchar2,
                                      flag     in varchar2) return number is
  zzs_6     number(20, 10);
  zzs_1_6   number(20, 10);
  lsxs_12   number(20, 10);
  qysds_12  number(20, 10);
  qbxse_24  number(20, 10);
  qbxse_1_1 number(20, 10);
  qbxse_1   number(20, 10);
  sssqz_max varchar2(15);
  qbxse_2   number(20, 10);
  qbxse_2_2 number(20, 10);
  qbxse_12  number(20, 10);
begin

  sssqz_max := sssq;
  if flag in (5, 1) then
    select decode(qbxse11, 0, null, qbxse11),
           qbxse22,
           decode(qbxse12, 0, null, qbxse12)
      into qbxse_1_1, qbxse_2_2, qbxse_12
      from (select sum(case
                         when substr(sssqz, 1, 4) = substr(sssqz_max, 1, 4) - 1 and
                              t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qbxse11,
                   sum(case
                         when substr(sssqz, 6, 2) > substr(sssqz_max, 6, 2) and
                              substr(sssqz, 1, 4) = substr(sssqz_max, 1, 4) - 1 and
                              t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qbxse22,
                   sum(case
                         when sssqz <= sssqz_max and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                              'yyyy-mm-dd') and

                              t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qbxse12
              from (select distinct nsrsbh,
                                    SBRQ,
                                    sssqq,
                                    zsxmmc,
                                    sssqz,
                                    YBTSE,
                                    QBXSE
                      from zx_sbxx a
                     where nsrsbh = v_nsrsbh
                       and not exists
                     (select 1
                              from zx_sbxx b
                             where a.LRSJ < b.lrsj - 130 / 24 / 60 / 60
                               and b.nsrsbh=v_nsrsbh)) t);
    --离散系数

    if flag = 5 then
      return(qbxse_2_2 / qbxse_1_1);
    end if;

    if flag = 1 then
      return(qbxse_12);
    end if;
  end if;
end;
/
