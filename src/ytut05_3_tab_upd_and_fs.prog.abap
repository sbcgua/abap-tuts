report ytut05_3_tab_upd_and_fs.

types:
  begin of ty_sales_report,
    date     type d,
    number   type c length 10,
  end of ty_sales_report.

data sales_report type table of ty_sales_report.
data report_line  like line of sales_report.

**********************************************************************

* Data initiation

report_line-date      = '20250227'.
report_line-number    = 'INV01'.
append report_line to sales_report.

report_line-date      = '20250228'.
report_line-number    = 'INV02'.
append report_line to sales_report.

report_line-date      = '20250310'.
report_line-number    = 'INV03'.
append report_line to sales_report.

* Update with MODIFY

read table sales_report into report_line index 2.
report_line-number = 'MODIFIED'.
modify sales_report index 2 from report_line transporting number.

* Update with FS

field-symbols <rec> like line of sales_report.
read table sales_report assigning <rec> index 2.
<rec>-number = 'MODIFIED+'.

if sy-subrc <> 0.
  write: / 'ERROR!'.
  return. " Exit program
endif.

* Show the result

write: / 'Invoice list'.
loop at sales_report into report_line.
  write: / report_line-date dd/mm/yy, report_line-number.
endloop.

* Loop with FS

loop at sales_report assigning <rec>.
  <rec>-number = <rec>-number && '+'.
endloop.

skip.
write: / 'Invoice list after modification'.
loop at sales_report assigning <rec>.
  write: / <rec>-date dd/mm/yy, <rec>-number.
endloop.
