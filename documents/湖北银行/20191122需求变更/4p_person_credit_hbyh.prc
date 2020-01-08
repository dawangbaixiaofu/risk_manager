create or replace procedure p_person_credit_hbyh(v_REPORT_NO in varchar2,
                                                 v_nsrsbh    in varchar2,
                                                 out_result  out varchar2,
                                                 remark      out varchar2,
                                                 ssxed       out number,
                                                 lv          out number) as

  guarantee_gz            int;
  guarantee_bl            int;
  OVERDUE_AMOUNT_loancard number(20, 2);
  OVERDUE_AMOUNT_loan     number(20, 2);
  loan_24_state_lx        int;
  loan_24_state_lj        int;
  loancard_24_state_lx    int;
  loancard_24_state_lj    int;
  state_loan              int;
  FINANCE_ORG_1           int;
  query_1                 int;
  org_query_1             int;
  term_1                  int;
  ysx_1                   int default 0;
  BALANCE_ed              number(20, 2);
  BALANCE_ed_1            number(20, 2);
  rzye                    number(20, 2);
  DBR_ZJHM_1              varchar2(30);
  ht_xx                   int;
  loan_curr               int;    --20191127 ADD 
  loancard_curr           int;      --20191127 ADD 
begin
  --个人征信规则

  select DBR_ZJHM
    into DBR_ZJHM_1
    from (select *
            from zx_lxrxx
           where nsrsbh = v_nsrsbh
             and trim(bssf) = 1
           order by lrsj desc)
   where rownum = 1;

  select count(*)
    into ht_xx
    from zx_icr_report_info
   where ID_NO = DBR_ZJHM_1
     and to_char(sysdate, 'yyyy-mm-dd') = substr(CREATE_TIME, 1, 10);

  select count(*)
    into guarantee_gz
    from zx_icr_guarantee
   where REPORT_NO = v_REPORT_NO
     and CLASS5_STATE in ('关注')
     and GUARANTEE_BALANCE > 0;

  select count(*)
    into guarantee_bl
    from zx_icr_guarantee
   where REPORT_NO = v_REPORT_NO
     and CLASS5_STATE in ('不良')
     and GUARANTEE_BALANCE > 0;

  select sum(CURR_OVERDUE_AMOUNT)
    into OVERDUE_AMOUNT_loancard
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO; --C102 借款人信用卡逾期金额超限

  select sum(CURR_OVERDUE_AMOUNT)
    into OVERDUE_AMOUNT_loan
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO; --C101 借款人贷款逾期金额超限

  select max(max_number(regexp_replace(latest_24_state, '[^0-9]')))
    into loan_24_state_lx
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO;

  select sum(length(regexp_replace(latest_24_state, '[^0-9]')))
    into loan_24_state_lj
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO; --借款人贷款逾期期数超限

  select max(max_number(regexp_replace(latest_24_state, '[^0-9]')))
    into loancard_24_state_lx
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO;

  select sum(length(regexp_replace(latest_24_state, '[^0-9]')))
    into loancard_24_state_lj
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO; --借款人信用卡逾期期数超限

  select count(*)
    into state_loan
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO
     and STATE in ('呆账', '核销');

  select count(distinct FINANCE_ORG)
    into FINANCE_ORG_1
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO
     and loantype = '个人经营性贷款'
	 and finance_org not like '%湖北银行%'; --20191029 add

  select sum(QUERIER_cnt)
    into query_1
	from
	(select  substr(query_date,1,7) query_month,count(distinct QUERIER) QUERIER_cnt
    from zx_icr_record_detail
   where query_date > to_char(sysdate - 365 * 1 / 2, 'yyyy.mm.dd')
     and query_reason = '贷款审批'
     and REPORT_NO = v_REPORT_NO
     and QUERIER not like '%湖北银行%');   --20191122 CHANGE C701

  select count(distinct QUERIER)
    into org_query_1
    from zx_icr_record_detail
   where query_date > to_char(sysdate - 365 * 1 / 2, 'yyyy.mm.dd')
     and query_reason = '贷款审批'
     and REPORT_NO = v_REPORT_NO
     and QUERIER not like '%湖北银行%';    --20191122 ADD C701

  select sum(BALANCE)
    into BALANCE_ed_1
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO
     and loantype like '%个人经营性贷款%'
	 and CURRENCY = '人民币'
     and GUARANTEE_TYPE in ('信用/免担保','组合(含保证)担保','保证');      --20191122 ADD C501


  --20191127 ADD 
  select max(CURR_OVERDUE_CYC)
    into loan_curr
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO;  --借款人是否有征信 = 是且目前借款人贷款最大逾期期数 > 0

  select max(curr_overdue_cyc)
    into loancard_curr
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO;   --借款人是否有征信 = 是且目前借款人信用卡最大逾期期数 > 0

/*
  select sum(BALANCE)
    into BALANCE_ed
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO
     and loantype != '结清'
     and GUARANTEE_TYPE = '信用/免担保';
*/

  select nvl(rzye_1, 0), ysxed, LV_1
    into rzye, ssxed, lv
    from t_zbb_hbyh
   where nsrsbh = v_nsrsbh;

  if rzye <= 0 then
    ssxed := greatest(round(ssxed - nvl(BALANCE_ed_1, 0), -3), 0);
  else
    ssxed := greatest(round(ssxed, -3), 0);
  end if;

  ----------------------------------------------------------------------------------
  /*if ht_xx = 0 then
    term_1 := 1;
    remark := remark || '合同信息查询异常：' || ht_xx || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;*/

  if guarantee_gz > 0 then
    term_1 := 1;
    remark := remark || '对外担保五级分类为关注且余额大于0：' || guarantee_gz || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if guarantee_bl > 0 then
    term_1 := 1;
    remark := remark || '对外担保五级分类为不良且余额大于0：' || guarantee_bl || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if OVERDUE_AMOUNT_loancard > 200 then
    term_1 := 1;
    remark := remark || '信用卡逾期金额超限：' || OVERDUE_AMOUNT_loancard || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if OVERDUE_AMOUNT_loan > 200 then
    term_1 := 1;
    remark := remark || '贷款逾期金额超限：' || OVERDUE_AMOUNT_loan || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loan_24_state_lx > 3 then
    term_1 := 1;
    remark := remark || '贷款连续逾期期数：' || loan_24_state_lx || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loan_24_state_lj > 6 then
    term_1 := 1;
    remark := remark || '贷款累计逾期期数：' || loan_24_state_lj || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loancard_24_state_lx > 3 then
    term_1 := 1;
    remark := remark || '信用卡连续逾期期数：' || loancard_24_state_lx || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loancard_24_state_lj > 6 then
    term_1 := 1;
    remark := remark || '信用卡累计逾期期数：' || loancard_24_state_lj || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if state_loan > 0 then
    term_1 := 1;
    remark := remark || '存在呆账或核销账户状态：' || state_loan || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if query_1 > 6 then   
    term_1 := 1;
    remark := remark || '个人征信贷款审批查询次数大于6：' || query_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

 --20191122 add start  C701
  if org_query_1 > 3 then
    term_1 := 1;
    remark := remark || '个人征信贷款审批查询机构数大于3：' || org_query_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  --20191122 add end

 --20191122 add start  C501  20191127 change 200万
  if BALANCE_ed_1 > 2000000 then
    term_1 := 1;
    remark := remark || '借款人和经营实体在征信中未结清的贷款额度>200万：' || BALANCE_ed_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  --20191122 add end
  
  --20191029 add start  C201
  if FINANCE_ORG_1 > 3 then
    term_1 := 1;
    remark := remark || '借款人在申请日未结清“个人经营贷”明细中授信机构数量累计＞3家，剔除本机构作为授信银行：' || FINANCE_ORG_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  --20191029 add end

  --20191127 ADD 
  if loan_curr > 0 then
    term_1 := 1;
    remark := remark || '目前借款人贷款最大逾期期数 > 0：' || loan_curr || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  
  if loancard_curr > 0 then
    term_1 := 1;
    remark := remark || '目前借款人信用卡最大逾期期数 > 0：' || loancard_curr || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if ht_xx = 0 then
    out_result := '33333333';
    remark     := remark || '合同信息查询异常;';
  else
    if ysx_1 = 0 and ssxed > 0 then
      out_result := '00000000';
      remark     := remark || '个人征信规则检查通过;';
    else
      out_result := '22222222';
      remark     := remark || '个人征信规则检查未通过;';
      ssxed      := 0;
    end if;
  end if;
exception
  when others then
    out_result := '11111111';
    remark     := remark || '个人征信规则检查异常;';
end;
