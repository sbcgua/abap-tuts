report ytut07_2_do_while.

" Do

data ntimes type i.
ntimes = 3.

skip. write: / 'Count to 3 with DO'.
do ntimes times.
  write: / sy-index.
enddo.

" While

data counter type i.

skip. write: / 'Count to 3 with WHILE'.
while sy-index <= 3. " counter < 3.
  counter = counter + 1.
  write: / counter.
endwhile.
