report ytut07_1_exit_continue.

types:
  begin of ty_sales_report,
    number   type c length 10,
    amount   type p length 6 decimals 2,
  end of ty_sales_report.

data sales_report   type table of ty_sales_report.
data report_line    like line of sales_report.

**********************************************************************

report_line-number    = 'INV01'.
report_line-amount    = '1234.00'.
append report_line to sales_report.

report_line-number    = 'INV02'.
report_line-amount    = '5000.00'.
append report_line to sales_report.

report_line-number    = 'INV03'.
report_line-amount    = '9000.00'.
append report_line to sales_report.

report_line-number    = 'INV04'.
report_line-amount    = '900.00'.
append report_line to sales_report.

**********************************************************************

" Every second invoice

write: / 'Every second invoice'.
loop at sales_report into report_line.
  if sy-tabix mod 2 = 1.
    continue.
  endif.
  write: / sy-tabix, report_line-number, report_line-amount.
endloop.

" All invoice > 4000

skip. write: / 'All invoices > 4000'.
loop at sales_report into report_line. " where amount > '4000'
  check report_line-amount > '4000'.
*  if report_line-amount <= '4000'.
*    continue.
*  endif.
  write: / sy-tabix, report_line-number, report_line-amount.
endloop.

" Exit operator

data total like report_line-amount.

skip. write: / 'List invoices not to exceed 7000 total'.
loop at sales_report into report_line.
  if total + report_line-amount > 7000.
    exit.
  endif.
  total = total + report_line-amount.

  write: / sy-tabix, report_line-number, report_line-amount.
endloop.

write: /13(10) 'Total:', total.
