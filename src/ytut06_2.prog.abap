report ytut06_2.

types:
  begin of ty_sales_report,
    date     type d,
    number   type c length 10,
  end of ty_sales_report.

data sales_report type table of ty_sales_report.
data report_line like line of sales_report.

**********************************************************************

* Adding records

report_line-date      = '20250227'.
report_line-number    = 'INV01'.
append report_line to sales_report.

report_line-date      = '20250228'.
report_line-number    = 'INV02'.
insert report_line into table sales_report.

report_line-date      = '20250310'.
report_line-number    = 'INV03'.
insert report_line into sales_report index 2.

write: / 'Invoice list'.
loop at sales_report into report_line.
  write: / report_line-date dd/mm/yy, report_line-number.
endloop.

* Reading specific index

skip. " write /.
read table sales_report into report_line index 3.
write: / 'Invoice #3:', report_line-date dd/mm/yy, report_line-number.

* Deleting records

delete sales_report index 1.

skip.
write: / 'Deleted by index'.
loop at sales_report into report_line.
  write: / report_line-date dd/mm/yy, report_line-number.
endloop.

delete sales_report where date <= '20250228'.

skip.
write: / 'Deleted by condition'.
loop at sales_report into report_line.
  write: / report_line-date dd/mm/yy, report_line-number.
endloop.

* Deleting duplicates

report_line-date      = '20250228'.
report_line-number    = 'INV02'.
append report_line to sales_report.
append report_line to sales_report.
insert report_line into sales_report index 1.

sort sales_report by date.
delete adjacent duplicates from sales_report comparing date.

skip.
write: / 'Deleting duplicates'.
loop at sales_report into report_line.
  write: / report_line-date dd/mm/yy, report_line-number.
endloop.
