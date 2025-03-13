report ytut05_5_tab_recindex.

types:
  begin of ty_sales_report,
    date     type d,
    number   type c length 10,
    paid     type c length 1,
  end of ty_sales_report.

data sales_report   type table of ty_sales_report.
data report_line    like line of sales_report.
field-symbols <rec> like line of sales_report.

**********************************************************************

* Data initiation

report_line-date      = '20250227'.
report_line-number    = 'PAID INV01'.
report_line-paid      = 'X'.
append report_line to sales_report.

clear report_line.
report_line-date      = '20250228'.
report_line-number    = 'INV02'.
append report_line to sales_report.

append initial line to sales_report assigning <rec>.
<rec>-date      = '20250310'.
<rec>-number    = 'INV03'.

append initial line to sales_report assigning <rec>.
<rec>-date      = '20250313'.
<rec>-number    = 'INV04'.

*report_line-date      = '20250310'.
*report_line-number    = 'INV03'.
*append report_line to sales_report.
*
*report_line-date      = '20250313'.
*report_line-number    = 'INV04'.
*append report_line to sales_report.

* Listing with line number

write: / 'Numbered invoice list'.
loop at sales_report into report_line.
  " line = line + 1 ...
  write: / sy-tabix, report_line-date dd/mm/yy, report_line-number.
endloop.

* Listing unpaid invoices

*delete sales_report where paid = 'X'. " The best way in this particular case

loop at sales_report into report_line.
  if report_line-paid = 'X'.
    delete sales_report index sy-tabix.
  endif.
endloop.

skip. write: / 'Unpaid invoice list'.
loop at sales_report into report_line.
  write: / sy-tabix, report_line-date dd/mm/yy, report_line-number.
endloop.

* More complex logic ... and caveats !

data paid_invoices type table of ty_sales_report-number.
append 'INV03' to paid_invoices.
append 'INV04' to paid_invoices.

data idx like sy-tabix. " i

loop at sales_report into report_line.
  idx = sy-tabix.
  read table paid_invoices " into ???
    with key table_line = report_line-number
    transporting no fields.
  if sy-subrc = 0.
    delete sales_report index idx. " sy-tabix? Nope! Homework !!
  endif.
endloop.

skip. write: / 'Unpaid invoice list (COMPLEX CASE)'.
loop at sales_report into report_line.
  write: / sy-tabix, report_line-date dd/mm/yy, report_line-number.
endloop.
