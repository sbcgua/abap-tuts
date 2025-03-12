report ytut03.

data integer type i.
data float type f.
data packed type p length 10 decimals 2.

integer = '5.5'.
float = '5.3'.
packed = '5.3'.

write: / integer.
write: / float.
write: / packed.

float = ( float + 1 - 2 ) * 80 / 100.
