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
  --�������Ź���

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
     and CLASS5_STATE in ('��ע')
     and GUARANTEE_BALANCE > 0;

  select count(*)
    into guarantee_bl
    from zx_icr_guarantee
   where REPORT_NO = v_REPORT_NO
     and CLASS5_STATE in ('����')
     and GUARANTEE_BALANCE > 0;

  select sum(CURR_OVERDUE_AMOUNT)
    into OVERDUE_AMOUNT_loancard
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO; --C102 ��������ÿ����ڽ���

  select sum(CURR_OVERDUE_AMOUNT)
    into OVERDUE_AMOUNT_loan
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO; --C101 ����˴������ڽ���

  select max(max_number(regexp_replace(latest_24_state, '[^0-9]')))
    into loan_24_state_lx
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO;

  select sum(length(regexp_replace(latest_24_state, '[^0-9]')))
    into loan_24_state_lj
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO; --����˴���������������

  select max(max_number(regexp_replace(latest_24_state, '[^0-9]')))
    into loancard_24_state_lx
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO;

  select sum(length(regexp_replace(latest_24_state, '[^0-9]')))
    into loancard_24_state_lj
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO; --��������ÿ�������������

  select count(*)
    into state_loan
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO
     and STATE in ('����', '����');

  select count(distinct FINANCE_ORG)
    into FINANCE_ORG_1
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO
     and loantype = '���˾�Ӫ�Դ���'
	 and finance_org not like '%��������%'; --20191029 add

  select sum(QUERIER_cnt)
    into query_1
	from
	(select  substr(query_date,1,7) query_month,count(distinct QUERIER) QUERIER_cnt
    from zx_icr_record_detail
   where query_date > to_char(sysdate - 365 * 1 / 2, 'yyyy.mm.dd')
     and query_reason = '��������'
     and REPORT_NO = v_REPORT_NO
     and QUERIER not like '%��������%');   --20191122 CHANGE C701

  select count(distinct QUERIER)
    into org_query_1
    from zx_icr_record_detail
   where query_date > to_char(sysdate - 365 * 1 / 2, 'yyyy.mm.dd')
     and query_reason = '��������'
     and REPORT_NO = v_REPORT_NO
     and QUERIER not like '%��������%';    --20191122 ADD C701

  select sum(BALANCE)
    into BALANCE_ed_1
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO
     and loantype like '%���˾�Ӫ�Դ���%'
	 and CURRENCY = '�����'
     and GUARANTEE_TYPE in ('����/�ⵣ��','���(����֤)����','��֤');      --20191122 ADD C501


  --20191127 ADD 
  select max(CURR_OVERDUE_CYC)
    into loan_curr
    from zx_icr_loan_info
   where REPORT_NO = v_REPORT_NO;  --������Ƿ������� = ����Ŀǰ����˴�������������� > 0

  select max(curr_overdue_cyc)
    into loancard_curr
    from zx_icr_loancard_info
   where REPORT_NO = v_REPORT_NO;   --������Ƿ������� = ����Ŀǰ��������ÿ������������ > 0

/*
  select sum(BALANCE)
    into BALANCE_ed
    from zx_icr_loan_info a
   where REPORT_NO = v_REPORT_NO
     and loantype != '����'
     and GUARANTEE_TYPE = '����/�ⵣ��';
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
    remark := remark || '��ͬ��Ϣ��ѯ�쳣��' || ht_xx || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;*/

  if guarantee_gz > 0 then
    term_1 := 1;
    remark := remark || '���ⵣ���弶����Ϊ��ע��������0��' || guarantee_gz || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if guarantee_bl > 0 then
    term_1 := 1;
    remark := remark || '���ⵣ���弶����Ϊ������������0��' || guarantee_bl || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if OVERDUE_AMOUNT_loancard > 200 then
    term_1 := 1;
    remark := remark || '���ÿ����ڽ��ޣ�' || OVERDUE_AMOUNT_loancard || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if OVERDUE_AMOUNT_loan > 200 then
    term_1 := 1;
    remark := remark || '�������ڽ��ޣ�' || OVERDUE_AMOUNT_loan || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loan_24_state_lx > 3 then
    term_1 := 1;
    remark := remark || '������������������' || loan_24_state_lx || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loan_24_state_lj > 6 then
    term_1 := 1;
    remark := remark || '�����ۼ�����������' || loan_24_state_lj || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loancard_24_state_lx > 3 then
    term_1 := 1;
    remark := remark || '���ÿ���������������' || loancard_24_state_lx || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if loancard_24_state_lj > 6 then
    term_1 := 1;
    remark := remark || '���ÿ��ۼ�����������' || loancard_24_state_lj || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if state_loan > 0 then
    term_1 := 1;
    remark := remark || '���ڴ��˻�����˻�״̬��' || state_loan || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if query_1 > 6 then   
    term_1 := 1;
    remark := remark || '�������Ŵ���������ѯ��������6��' || query_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

 --20191122 add start  C701
  if org_query_1 > 3 then
    term_1 := 1;
    remark := remark || '�������Ŵ���������ѯ����������3��' || org_query_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  --20191122 add end

 --20191122 add start  C501  20191127 change 200��
  if BALANCE_ed_1 > 2000000 then
    term_1 := 1;
    remark := remark || '����˺;�Ӫʵ����������δ����Ĵ�����>200��' || BALANCE_ed_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  --20191122 add end
  
  --20191029 add start  C201
  if FINANCE_ORG_1 > 3 then
    term_1 := 1;
    remark := remark || '�������������δ���塰���˾�Ӫ������ϸ�����Ż��������ۼƣ�3�ң��޳���������Ϊ�������У�' || FINANCE_ORG_1 || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  --20191029 add end

  --20191127 ADD 
  if loan_curr > 0 then
    term_1 := 1;
    remark := remark || 'Ŀǰ����˴�������������� > 0��' || loan_curr || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;
  
  if loancard_curr > 0 then
    term_1 := 1;
    remark := remark || 'Ŀǰ��������ÿ������������ > 0��' || loancard_curr || ';';
  else
    term_1 := 0;
  end if;
  ysx_1 := ysx_1 + term_1;

  if ht_xx = 0 then
    out_result := '33333333';
    remark     := remark || '��ͬ��Ϣ��ѯ�쳣;';
  else
    if ysx_1 = 0 and ssxed > 0 then
      out_result := '00000000';
      remark     := remark || '�������Ź�����ͨ��;';
    else
      out_result := '22222222';
      remark     := remark || '�������Ź�����δͨ��;';
      ssxed      := 0;
    end if;
  end if;
exception
  when others then
    out_result := '11111111';
    remark     := remark || '�������Ź������쳣;';
end;
