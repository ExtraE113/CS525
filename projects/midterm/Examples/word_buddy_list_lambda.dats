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

fun
TMmap(input: term, func: term): term =
TMapp(TMapp(TMmap_raw, input), func)

fun
TMbinary_opr_as_fn(opr:string) =
TMlam("arg1", TMlam("arg2", TMopr(opr, mylist_pair(TMvar"arg1", TMvar"arg2"))))


(** UNTESTED **)
val
TMzip_raw =
let
val l1_element_type = tpxyz_new()
val l2_element_type = tpxyz_new()
val input1 = TManno(TMvar"input1", TPlist(l1_element_type))
val input2 = TManno(TMvar"inpu2", TPlist(l2_element_type))
in
TMfix
(
"cont",
"input1",
TMlam(
"input2",
      TMif0(
          TMlist_nilq(input1),
          TMlist_nil(),
          TMlist_cons(
                  TMtup(TMlist_head(input1), TMlist_head(input2)),
                  TMapp(TMapp(TMvar"cont", TMlist_tail(input1)), TMlist_tail(input2))

          )
      ))
)
end

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


fun TMflatten(t:term):term =
TMapp(TMflatten_raw, t)

val () = println!("Type of TMflatten_raw is ", term_type0(TMflatten_raw))

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

//val () = println!("List concat example, example is ", term_eval0(TMlist_concat(example_list, example_list)))


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

val () = println!("Flatten list(example_list, example_list, example_list) ",
        term_eval0(TMflatten(nested_list)))
val () = println!("Should be list of int ", type_norm(term_type0(TMflatten(nested_list))))

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

//val () = println!("Type of range ", range_type)

//val () = println!("Range from 0 to 10 ", term_eval0(
//        TMapp(TMapp(TMrange, TMint(0)), TMint(10))
//        ))

//val () = println!("Type of TMapp(TMbinary_opr_as_fn(\"str_get_at\"), input): ", term_type0(TMapp(TMbinary_opr_as_fn("str_get_at"), TMstr"love")))

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



//val () = println!("type of TMstring_to_char_list ", term_type0(TMstring_to_char_list))
//
//val () = println!("List of chars in 'love'", term_eval0(TMapp(TMstring_to_char_list, TMstr"love")))