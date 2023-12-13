#staload
"./../../../mylib/mylib.dats"
#staload "./../midterm.sats"//opened


typedef stringlst = mylist(string)

typedef code_with_hoists = (string, string)

typedef c_envir = string

fun
term_compile(term): string
fun
term_compile1(term, c_envir): code_with_hoists
fun
termlst_compile1(termlst, c_envir): (stringlst, string)
//
