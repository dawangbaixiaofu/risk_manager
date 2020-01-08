create or replace function f_jydx(v_nsrsbh in varchar2,
                                  ssq      in varchar2,
                                  flag     in varchar2) return number is
  chkh_10   number(20, 2);
  chgys_10  number(20, 2);
  khxszb_5  number(20, 2);
  gyszb_10  number(20, 2);
  sssq_1    varchar2(15);
  qbxse_1   number(15, 2);
  term_fp   int;
  khxszb_10 number(20, 2);
  sygs_10   int;
  xychgs_10 int;
begin
  sssq_1 := ssq;
  if substr(ssq, 6, 2) < 6 then
    sssq_1 := substr(ssq, 1, 4) - 1 || '-12-31';
  end if;
  select count(*)
    into term_fp
    from zx_jydx
   where nsrsbh = v_nsrsbh
     and sssq = substr(sssq_1, 1, 4);
  if term_fp = 0 then
    return(null);
  else
    if flag = 1 then
      with jydx as
       (select *
          from zx_jydx a
         where nsrsbh = v_nsrsbh
           and not exists (select *
                  from zx_jydx b
                 where a.nsrsbh = b.nsrsbh
                   and a.lrsj < b.lrsj - 3 / 24 / 60))
      select nvl(count(distinct a.gfnsrsbh), 0)
        into chkh_10
        from (select distinct gfnsrsbh, jyjebl
                from jydx a
               where sssq = substr(sssq_1, 1, 4) - 1
                 and SXYBZ = 1
                 and pm <= 10) a,
             (select distinct gfnsrsbh, jyjebl
                from jydx a
               where sssq = substr(sssq_1, 1, 4)
                 and SXYBZ = 1
                 and pm <= 10) b
       where a.gfnsrsbh = b.gfnsrsbh
          or substr(a.gfnsrsbh, 3, 15) = b.gfnsrsbh
          or substr(b.gfnsrsbh, 3, 15) = a.gfnsrsbh;
      return(chkh_10);
    end if;

    if flag = 7 then
      with jydx as
       (select *
          from zx_jydx a
         where nsrsbh = v_nsrsbh
           and not exists (select *
                  from zx_jydx b
                 where a.nsrsbh = b.nsrsbh
                   and a.lrsj < b.lrsj - 3 / 24 / 60))
      select nvl(count(distinct a.xfnsrsbh), 0)
        into xychgs_10
        from (select distinct xfnsrsbh, jyjebl
                from jydx a
               where sssq = substr(sssq_1, 1, 4) - 1
                 and SXYBZ = 0
                 and pm <= 10) a,
             (select distinct xfnsrsbh, jyjebl
                from jydx a
               where sssq = substr(sssq_1, 1, 4)
                 and SXYBZ = 0
                 and pm <= 10) b
       where a.xfnsrsbh = b.xfnsrsbh
          or substr(a.xfnsrsbh, 3, 15) = b.xfnsrsbh
          or substr(b.xfnsrsbh, 3, 15) = a.xfnsrsbh;
      return(xychgs_10);
    end if;

    if flag = 2 then
      if substr(ssq, 6, 2) >= 6 then
        qbxse_1 := f_sb(v_nsrsbh, ssq, 6);
        with jydx as
         (select *
            from zx_jydx a
           where nsrsbh = v_nsrsbh
             and not exists
           (select *
                    from zx_jydx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60))
        select nvl(sum(jyje), 0) / decode(qbxse_1, 0, null, qbxse_1)
          into chgys_10
          from (select distinct b.xfnsrsbh, b.jyje
                  from (select distinct xfnsrsbh, jyjebl, jyje
                          from jydx a
                         where sssq = substr(sssq_1, 1, 4) - 1
                           and SXYBZ = 0
                           and pm <= 10) a,
                       (select distinct xfnsrsbh, jyjebl, jyje
                          from jydx a
                         where sssq = substr(sssq_1, 1, 4)
                           and SXYBZ = 0
                           and pm <= 10) b
                 where a.xfnsrsbh = b.xfnsrsbh
                    or substr(a.xfnsrsbh, 3, 15) = b.xfnsrsbh
                    or substr(b.xfnsrsbh, 3, 15) = a.xfnsrsbh);else
        qbxse_1 := f_sb(v_nsrsbh,
                        ssq,
                        8);
        with jydx as
         (select *
            from zx_jydx a
           where nsrsbh =
                 v_nsrsbh
             and not
                  exists
           (select *
                    from zx_jydx b
                   where a.nsrsbh =
                         b.nsrsbh
                     and a.lrsj <
                         b.lrsj -
                         3 / 24 / 60))
        select nvl(sum(jyje),
                   0) /
               decode(qbxse_1,
                      0,
                      null,
                      qbxse_1)
          into chgys_10
          from (select distinct a.xfnsrsbh,
                                a.jyje
                  from (select distinct xfnsrsbh,
                                        jyjebl,
                                        jyje
                          from jydx a
                         where sssq =
                               substr(sssq_1,
                                      1,
                                      4)
                           and SXYBZ = 0
                           and pm <= 10) a,
                       (select distinct xfnsrsbh,
                                        jyjebl,
                                        jyje
                          from jydx a
                         where sssq =
                               substr(sssq_1,
                                      1,
                                      4) - 1
                           and SXYBZ = 0
                           and pm <= 10) b
                 where a.xfnsrsbh =
                       b.xfnsrsbh
                    or substr(a.xfnsrsbh,
                              3,
                              15) =
                       b.xfnsrsbh
                    or substr(b.xfnsrsbh,
                              3,
                              15) =
                       a.xfnsrsbh);
      end if;
      return(chgys_10);
    end if;

    if flag = 3 then
      if substr(ssq, 6, 2) >= 6 then
        qbxse_1 := f_sb(v_nsrsbh, ssq, 6);
        with jydx as
         (select *
            from zx_jydx a
           where nsrsbh = v_nsrsbh
             and not exists
           (select *
                    from zx_jydx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60))
        select nvl(sum(jyje) / decode(qbxse_1, 0, null, qbxse_1), 0)
          into khxszb_5
          from (select distinct gfnsrsbh, jyje
                  from jydx a
                 where sssq = substr(sssq_1, 1, 4)
                   and SXYBZ = 1
                   and pm <= 5);else
        qbxse_1 := f_sb(v_nsrsbh, ssq, 8);
        with jydx as
         (select *
            from zx_jydx a
           where nsrsbh = v_nsrsbh
             and not exists
           (select *
                    from zx_jydx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj <
                         b.lrsj - 3 / 24 / 60))
        select nvl(sum(jyje) /
                   decode(qbxse_1,
                          0,
                          null,
                          qbxse_1),
                   0)
          into khxszb_5
          from (select distinct gfnsrsbh, jyje
                  from jydx a
                 where sssq = substr(sssq_1, 1, 4)
                   and SXYBZ = 1
                   and pm <= 5);
      end if;
      return(khxszb_5);
    end if;

    if flag = 4 then
      with jydx as
       (select *
          from zx_jydx a
         where nsrsbh = v_nsrsbh
           and not exists (select *
                  from zx_jydx b
                 where a.nsrsbh = b.nsrsbh
                   and a.lrsj < b.lrsj - 3 / 24 / 60))
      select nvl(sum(jyjebl), 0)
        into gyszb_10
        from (select distinct xfnsrsbh, jyjebl
                from jydx a
               where sssq = substr(sssq_1, 1, 4)
                 and SXYBZ = 0
                 and pm <= 10);
      return(gyszb_10);
    end if;

    if flag = 5 then
      if substr(ssq, 6, 2) >= 6 then
        qbxse_1 := f_sb(v_nsrsbh, ssq, 6);
        with jydx as
         (select *
            from zx_jydx a
           where nsrsbh = v_nsrsbh
             and not exists
           (select *
                    from zx_jydx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj < b.lrsj - 3 / 24 / 60))
        select nvl(sum(jyje) / decode(qbxse_1, 0, null, qbxse_1), 0)
          into khxszb_10
          from (select distinct gfnsrsbh, jyje
                  from jydx a
                 where sssq = substr(sssq_1, 1, 4)
                   and SXYBZ = 1
                   and pm <= 10);else
        qbxse_1 := f_sb(v_nsrsbh, ssq, 8);
        with jydx as
         (select *
            from zx_jydx a
           where nsrsbh = v_nsrsbh
             and not exists
           (select *
                    from zx_jydx b
                   where a.nsrsbh = b.nsrsbh
                     and a.lrsj <
                         b.lrsj - 3 / 24 / 60))
        select nvl(sum(jyje) /
                   decode(qbxse_1,
                          0,
                          null,
                          qbxse_1),
                   0)
          into khxszb_10
          from (select distinct gfnsrsbh, jyje
                  from jydx a
                 where sssq =
                       substr(sssq_1, 1, 4)
                   and SXYBZ = 1
                   and pm <= 10);
      end if;
      return(khxszb_10);
    end if;

    if flag = 6 then
      with jydx as
       (select *
          from zx_jydx a
         where nsrsbh = v_nsrsbh
           and not exists (select *
                  from zx_jydx b
                 where a.nsrsbh = b.nsrsbh
                   and a.lrsj < b.lrsj - 3 / 24 / 60))
      select count(*)
        into sygs_10
        from (select distinct gfnsrsbh, jyje
                from jydx a
               where sssq = substr(sssq_1, 1, 4)
                 and SXYBZ = 0
                 and pm <= 10);
      return(sygs_10);
    end if;

  end if;
end;
