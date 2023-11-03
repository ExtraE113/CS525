(* ****** ****** *)
(*
CS525-2023-Fall: midterm
*)
(* ****** ****** *)
#include "share/atspre_staload.hats"

(* ****** ****** *)
//
#staload "./../midterm.sats" //opened
//
(* ****** ****** *)
#staload "./../../../mylib/mylib.dats"
//
(* ****** ****** *)
#include "../MySolution/header.dats"

(* ****** ****** *)
(* ****** ****** *)

val TMchange_letter =
let
val word = TManno(TMvar"word", TPstr)
val index = TManno(TMvar"index", TPint)
in
TMlam(
    "word",
    TMlam(
        "index",
        index
    )
)
end


fun
TMmap(input: term, func: term): term =
TMapp(TMapp(TMmap_raw, input), func) where {
val
TMmap_raw =
let
val before_type = tpxyz_new()
val after_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(before_type))
val func = TManno(TMvar"func", TPfun(before_type, after_type))
in
TMfix
(
"cont",
"input",
TMlam(
"func",
      TMif0(
          TMlist_nilq(input),
          TMlist_nil(),
          TMlist_cons(
                  TMapp(func, TMlist_head(input)),
                  TMapp(TMapp(TMvar"cont", TMlist_tail(input)), func)

          )
      ))
)
end

}

fun
TMbinary_opr_as_fn(opr:string) =
TMlam("arg1", TMlam("arg2", TMopr(opr, mylist_pair(TMvar"arg1", TMvar"arg2"))))


fun
TMternary_opr_as_fn(opr:string) =
TMlam("arg1", TMlam("arg2", TMlam("arg3", TMopr(opr, mylist_cons(TMvar"arg1", mylist_pair(TMvar"arg2", TMvar"arg3"))))))


val TMlist_concat_raw =
let
val element_type = tpxyz_new()
val input1 = TManno(TMvar"input1", TPlist(element_type))
val input2 = TManno(TMvar"input2", TPlist(element_type))
in
TMfix
(
"cont",
"input1",
TMlam(
"input2",
      TMif0(
          TMlist_nilq(input1),
          input2,
          TMlist_cons(
                  TMlist_head(input1),
                  TMapp(TMapp(TMvar"cont", TMlist_tail(input1)), input2)

          )
      ))
)
end

fun
TMlist_concat(a: term, b: term): term =
TMapp(TMapp(TMlist_concat_raw, a), b)





fun TMflatten(t:term):term =
TMapp(TMflatten_raw, t) where {
val TMflatten_raw =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(TPlist(element_type)))
in
TMfix
(
"cont",
"input",
  TMif0(
      TMlist_nilq(input),
      TMlist_nil(),
      TMlist_concat(TMlist_head(input),
                    TMapp(TMvar"cont", TMlist_tail(input))
                    )
  )
)
end
}

//val () = println!("Type of TMflatten_raw is ", term_type0(TMflatten_raw))

val example_list = TMlist_cons(
        TMint(1),
        TMlist_cons(
                TMint(2),
                TMlist_cons(
                        TMint(3),
                        TMlist_nil()
                        )
                )
        )

val () = println!("List concat example, example is ", term_eval0(TMlist_concat(example_list, example_list)))


val TMincrement = TMlam(
    "input",
    TMadd(TMvar"input", TMint(1))
)

//val () = println!("type of TMmap_raw is ", type_norm(term_type0(TMmap_raw)))
//val () = println!("increment example list ", term_eval0(
//        TMmap(example_list, TMincrement)
//        ))

val nested_list = TMlist_cons(
        example_list,
        TMlist_cons(
                example_list,
                TMlist_cons(
                        example_list,
                        TMlist_nil()
                )
        )
)

//val () = println!("Flatten list(example_list, example_list, example_list) ",
//        term_eval0(TMflatten(nested_list)))
//val () = println!("Should be list of int ", type_norm(term_type0(TMflatten(nested_list))))

val TMrange =
TMfix(
"cont",
"from",
TMlam(
"to",
TMif0(
        TMeq(TMvar"to", TMvar"from"),
        TMlist_nil(),
        TMlist_cons(
                TMvar"from",
                TMapp(TMapp(TMvar"cont", TMadd(TMvar"from", TMint(1))), TMvar"to")
                )
        )
    )
)

val range_type: type = term_type0(TMrange)

val () = println!("Type of range ", range_type)

val () = println!("Range from 0 to 10 ", term_eval0(
        TMapp(TMapp(TMrange, TMint(0)), TMint(10))
        ))

val () = println!("Type of TMapp(TMbinary_opr_as_fn(\"str_get_at\"), input): ", term_type0(TMapp(TMbinary_opr_as_fn("str_get_at"), TMstr"love")))

val TMstring_to_char_list =
let
var input = TManno(TMvar("input"), TPstr)
var len = TManno(TMvar"len", TPint)
var list_indexes = TManno(TMvar"list_indexes", TPlist(TPint))

in
TMlam(
    "input",
    TMlet(
            "len",
            TMstr_len(input),
            TMlet(
                    "list_indexes",
                    TMapp(TMapp(TMrange, TMint(0)), len),
                    TMlet("charize",
                          TMapp(TMbinary_opr_as_fn("str_get_at"), input),
                          TMmap(list_indexes, TMvar"charize")
                          )
                    )
            )
)
end



val () = println!("type of TMstring_to_char_list ", term_type0(TMstring_to_char_list))

val () = println!("List of chars in 'love'", term_eval0(TMapp(TMstring_to_char_list, TMstr"love")))

val () = println!("Change 1st char of 'love' to 'd' ", term_eval0(
        TMopr("str_set_at",
              mylist_cons(TMstr"love",
                          mylist_pair(TMint(0),
                                      TMchr('d'))
                          )
              )
        ))

//val TMenumerate_at =
//let
//val index = TManno(TMvar"index", TPint)
//val input = TManno(TMvar"input", TPstr)
//val letters = TManno(TMvar"letters", TPlist(TPchr))
//in
//TMlam(
//        "index",
//        TMlam(
//                "input",
//                TMlam(
//                        "letters",
//                        TMmap(letters, TMapp(TMapp(TMternary_opr_as_fn("str_set_at"), input), index))
//                        )
//                )
//        )
//end

val index = TManno(TMvar"index", TPint)
val input = TManno(TMvar"input", TPstr)
val letters = TManno(TMvar"letters", TPlist(TPchr))

val alphabet_letters = TMstr"abcdefghijklmnopqrstuvwxyz"

val alphabet_list = TManno(TMapp(TMstring_to_char_list, alphabet_letters), TPlist(TPchr))
val set_zeroth_char = TMapp(
        TMapp(TMternary_opr_as_fn("str_set_at"), TMstr"love"), TMint(0)
)

val () = println!("Alphabet list type ", term_type0(alphabet_list))
val () = println!("Set zeroth char type ", term_type0(set_zeroth_char))

val TMset_nth_char =
let
val index = TManno(TMvar"index", TPint)
val inp = TManno(TMvar"inp", TPstr)
in
TMlam(
    "inp",
    TMlam(
            "index",
                TMapp(
                        TMapp(TMternary_opr_as_fn("str_set_at"), inp), index
                )
            ))
end


val all_nth_chars =
        TMlam(
            "inp",
            TMlam(
                "index",
                TMmap(
                     alphabet_list,
                     TMapp(TMapp(TMset_nth_char, TMvar"inp"), TMvar"index")
                )
            )
        )

//val () = println!("Type of TMmap_raw ", term_type0(TMmap_raw))

val () = println!("should be (str -> int -> list<string>) ",
        term_type0(
                all_nth_chars
                )
        )


fun TMfilter(imp_list: term, test: term): term =
TMapp(TMapp(TMfilter_raw, imp_list), test) where {
val TMfilter_raw =
let
val inp_type = tpxyz_new()
val inp = TManno(TMvar"inp", TPlist(inp_type))
val test_fun = TManno(TMvar"test_fun", TPfun(inp_type, TPbtf))
in
TMfix(
      "cont",
      "inp",
      TMlam(
              "test_fun",
              TMif0(
                      TMlist_nilq(inp),
                      TMlist_nil(),
                      TMif0(
                      TMapp(test_fun, TMlist_head(inp)),
                      TMlist_cons(
                              TMlist_head(inp), TMapp(TMapp(TMvar"cont", TMlist_tail(inp)), test_fun)
                              ),
                      TMapp(TMapp(TMvar"cont", TMlist_tail(inp)), test_fun)
                      )
              )))
end
val () = println!("Filter is of type ", term_type0(TMfilter_raw))

}

val TMis_even =
TMlam("inp", TMeq(TMmod(TMvar"inp", TMint(2)), TMint(0)))

val even_numbers = TMfilter(
        TMapp(TMapp(TMrange, TMint(0)), TMint(10)),
        TMis_even
)


val () = println!("Even numbers type ", term_type0(even_numbers))
//
val () = println!("Even numbers are ", term_eval0(even_numbers))


val TMall_doublets =
TMlam(
        "inp",
        TMfilter(TMflatten(
                TMmap(
                    TMapp(TMapp(TMrange, TMint(0)), TMopr("str_len", mylist_sing(TMvar"inp"))),
                    TMapp(all_nth_chars, TMvar"inp")
                )
            ),
            TMlam("candidate", TMopr("not", mylist_sing(TMopr("str_eq", mylist_pair(TMvar"candidate", TMvar"inp")))))
            ))



val () = println!("All *ove: ", term_eval0(TMapp(TMapp(all_nth_chars, TMstr"love"), TMint(1))))

val () = println!("All doublets type ", term_type0(TMall_doublets))

val () = println!("All love-lets ", term_eval0(TMapp(TMall_doublets, TMstr"love")))
