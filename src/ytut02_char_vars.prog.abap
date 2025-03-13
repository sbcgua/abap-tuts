report ytut02_char_vars.

data:
  user_name type c length 10,
  user_name2 type string,
  users type string.

user_name  = 'Taras'.
user_name2 = 'Bohdan'.

users = user_name && ', ' && user_name2.
write: / 'Hello', users.

users = user_name && `, ` && user_name2.
write: / 'Hello', users.

data greeting type string.

greeting = |Hello { user_name } and { user_name2 }|.

write: / greeting.
