create or replace function f_sb(v_nsrsbh in varchar2,
                                sssq     in varchar2,
                                flag     in varchar2) return number is
  zzs_6      number(20, 2);
  zzs_1_6    number(20, 2);
  lsxs_12    number(20, 2);
  qysds_12   number(20, 2);
  qbxse_12   number(20, 2);
  qbxse_1_1  number(20, 2);
  qbxse_1    number(20, 2);
  sssqz_max  varchar2(15);
  qbxse_2    number(20, 2);
  qbxse_2_2  number(20, 2);
  qxse_12xin number(20, 2);
  qxse_24xin number(20, 2);
  ybtse_12      number(20, 2); -- 近12月应补退税额
begin

  select max(sssqz)
    into sssqz_max
    from zx_sbxx a
   where nsrsbh = v_nsrsbh
     and not exists
   (select 1
            from zx_sbxx b
           where a.LRSJ < b.lrsj - 130 / 24 / 60 / 60
             and b.nsrsbh= v_nsrsbh)
     and ZSXMmc = '增值税'
     and sssqz<=sssq;

  if flag in (1, 3, 4, 5, 6, 7, 8, 9, 10) then
    select qbxse1,
           qbxse2,
           decode(qbxse11, 0, null, qbxse11),
           qbxse22,
           zzs6,
           decode(zzs16, 0, null, zzs16),
           qysds12,
           qbxse12,
           qxse12xin,
           decode(qxse24xin, 0, null, qxse24xin),
           ybtse12
      into qbxse_1,
           qbxse_2,
           qbxse_1_1,
           qbxse_2_2,
           zzs_6,
           zzs_1_6,
           qysds_12,
           qbxse_12,
           qxse_12xin,
           qxse_24xin,
           ybtse_12
      from (select sum(case
                         when substr(sssqq, 1, 4) = substr(sssqz_max, 1, 4) and t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qbxse1,
                   sum(case
                         when sssqz <= sssqz_max and substr(sssqq, 1, 4) = substr(sssqz_max, 1, 4) and
                              t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qbxse2,
                   sum(case
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
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), 0),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -6),
                                              'yyyy-mm-dd') and t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) zzs6,
                   sum(case
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -18),
                                              'yyyy-mm-dd') and t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) zzs16,

                   sum(case
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), 0),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                              'yyyy-mm-dd') and t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qxse12xin,
                   sum(case
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -24),
                                              'yyyy-mm-dd') and t.ZSXMmc = '增值税' then
                          QBXSE
                         else
                          '0'
                       end) qxse24xin,

                   sum(case
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), 0),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                              'yyyy-mm-dd') and t.ZSXMmc = '企业所得税' then
                          ybtse
                         else
                          '0'
                       end) qysds12,
                   sum(case
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), 0),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                              'yyyy-mm-dd') and t.ZSXMmc = '增值税' then
                          qbxse
                         else
                          '0'
                       end) qbxse12,
                    sum(case
                         when sssqz <= to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), 0),
                                               'yyyy-mm-dd') and
                              sssqz > to_char(add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12),
                                              'yyyy-mm-dd')  then
                          ybtse
                         else
                          '0'
                       end) ybtse12
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
                                 and b.nsrsbh= v_nsrsbh )) t);
    --离散系数
    if flag = 1 then
      return((zzs_6 - zzs_1_6) / zzs_1_6);
    else
      if flag = 3 then
        return(qysds_12);
      else
        if flag = 4 then
          return(qbxse_12);
        else
          if flag = 5 then
            return(qbxse_2_2 / qbxse_1_1);
          else
            if flag = 6 then
              return(qbxse_1);
            else
              if flag = 7 then
                return(qbxse_2);
              else
                if flag = 8 then
                  return(qbxse_1_1);
                else
                  if flag = 9 then
                    return((qxse_12xin - qxse_24xin) / qxse_24xin);
                  else
                    if flag = 10 then
                      return(ybtse_12);
                    end if;
                  end if;
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  end if;
  if flag = 2 then
    select 100 * STDdEV(qbxse) / decode(avg(qbxse), 0, null, avg(qbxse))
      into lsxs_12
      from (select sssqz, sum(qbxse) qbxse
              from (select distinct t.sssqq, t.sssqz, t.qbxse, t.sbrq
                      from zx_sbxx t
                     where t.nsrsbh = v_nsrsbh
                       and not exists
                     (select *
                              from zx_sbxx b
                             where  b.nsrsbh=v_nsrsbh
                               and t.lrsj < b.lrsj - 3 / 24 / 60)
                       and to_date(t.sssqz, 'yyyy-mm-dd') >
                           add_months(to_date(sssqz_max, 'yyyy-mm-dd'), -12)

                       and zsxmmc in ('增值税'))
             group by sssqz);
    return(lsxs_12);
  end if;
end;
/
