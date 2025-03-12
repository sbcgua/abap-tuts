report ytut04.

data date type d.
data char type c length 8.

date = '20250228'.
char = date.

date = date + 1.
char = char + 1.

write: / date, char.

date+4(2) = '05'.
write: / date.
