report ytut04_structures.

" INVOICE DOCUMENT
" HEADER (1)
"   date
"   number
"   customer
" LINES (many)
"   no
"   material
"   quantity
"   price
"   amount

types ty_invoice_number type c length 20.

types:
  begin of ty_invoice_header,
    date     type d,
    number   type ty_invoice_number,
    customer type c length 40,
  end of ty_invoice_header.

data invoice_head type ty_invoice_header.

invoice_head-date     = '20250228'.
invoice_head-number   = 'INV1/1'.
invoice_head-customer = 'The Best Customer'.

write: / 'Invoice:', invoice_head-date, invoice_head-number, invoice_head-customer.

types:
  begin of ty_sales_report,
    date         type d,
    number       type ty_invoice_number,
    customer     type c length 40,
    total_amount type p length 10 decimals 2,
    transport_costs type p length 10 decimals 2,
  end of ty_sales_report.

data report_line type ty_sales_report.

move-corresponding invoice_head to report_line.

write: / 'Sales report:', report_line-date, report_line-number, report_line-customer.
