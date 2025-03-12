report ytut06.

" INVOICE DOCUMENT
" HEADER (1)
"   date
"   number
"   customer
" LINES (many)
"   no
"   material
"   quantity
"   unit
"   price
"   amount

types:
  begin of ty_invoice_line,
    no       type i,
    material type c length 20,
    qty      type p length 5 decimals 3,
    unit     type c length 3,
    price    type p length 8 decimals 2,
    amount   type p length 10 decimals 2,
  end of ty_invoice_line.

data invoice_lines type table of ty_invoice_line.

data one_line like line of invoice_lines.
*data one_line2 type ty_invoice_line.
*data lines like table of one_line2.

one_line-no       = 1.
one_line-material = 'Laptop'.
one_line-qty      = '10'.
one_line-unit     = 'PC'. " Piece
one_line-price    = '1000'.
one_line-amount   = '10000'.
append one_line to invoice_lines.

clear one_line.
one_line-no       = 2.
one_line-material = 'Mouse'.
one_line-qty      = '10'.
one_line-unit     = 'PC'. " Piece
one_line-price    = '200'.
one_line-amount   = '2000'.
append one_line to invoice_lines.

write: / 'Invoice lines:'.

loop at invoice_lines into one_line.
  one_line-amount = one_line-price * one_line-qty.
  write: / one_line-no, one_line-material, one_line-qty, one_line-unit, one_line-price, one_line-amount.
endloop.
