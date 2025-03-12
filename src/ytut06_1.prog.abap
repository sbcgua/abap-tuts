report ytut06_1.

types:
  begin of ty_sales_report,
    date     type d,
    number   type c length 10,
    customer type c length 15,
    amount   type p length 6 decimals 2,
  end of ty_sales_report.

data sales_report type table of ty_sales_report.
data report_line like line of sales_report.

report_line-date      = '20250228'.
report_line-number    = 'INV02/1'.
report_line-customer  = 'Customer1'.
report_line-amount    = 10000.
append report_line to sales_report.

report_line-date      = '20250228'.
report_line-number    = 'INV02/2'.
report_line-customer  = 'Customer2'.
report_line-amount    = 30000.
append report_line to sales_report.

report_line-date      = '20250301'.
report_line-number    = 'INV03/1'.
report_line-customer  = 'Customer1'.
report_line-amount    = 20000.
append report_line to sales_report.

**********************************************************************

read table sales_report into report_line with key number = 'INV02/2'.
write: / 'Invoice1:', report_line-date, report_line-customer, report_line-number, report_line-amount.

read table sales_report into report_line with key customer = 'Customer1' date = '20250228'.
write: / 'Invoice2:', report_line-date, report_line-customer, report_line-number, report_line-amount.

read table sales_report into report_line with key date = '20250228'.
write: / 'Invoice3:', report_line-date, report_line-customer, report_line-number, report_line-amount.

read table sales_report into report_line with key date = '20250201'. " No such invoice !
if sy-subrc = 0.
  write: / 'Invoice on 20250201 found:', report_line-number.
else.
  write: / 'Invoice on 20250201 NOT found'.
endif.

loop at sales_report into report_line where date <= '20250228'.
  write: / 'Loop Invoice', report_line-date, report_line-number.
endloop.
