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


fun TMllist_next(t: term): term =
TMapp(TMllist_next_raw, t) where {
val TMllist_next_raw =
        TMlam("input",
              TMeval(TMllist_tail(TMvar"input"))
        )
}

fun TMllist_enumerate(t: term): term =
TMapp(TMapp(TMllist_enumerate_raw, t), TMint(0))
where {
    val TMllist_enumerate_raw =
let
var input_type = tpxyz_new()
var input = TManno(TMvar"input", TPllist(input_type))
var cur_index = TManno(TMvar"cur_index", TPint)
in
TMfix("cont",
      "input",
      TMlam(
              "cur_index",
              TMif0(
                  TMllist_nilq(input),
                  TMllist_nil(),
                  TMllist_cons(
                          TMtup(cur_index, TMllist_head(input)),
                          TMlazy(
                                  TMapp(
                                          TMapp(TMvar"cont", TMllist_next(input)),
                                          TMadd(cur_index, TMint(1))
                                          )
                                  )
                          )
                  )
              )
      )
end
}

//val () = println!(term_type0(TMenumerate_raw))

val TMlazy_range =
TMfix(
"cont",
"from",
TMlam(
"to",
TMif0(
        TMeq(TMvar"to", TMvar"from"),
        TMllist_nil(),
        TMllist_cons(
                TMvar"from",
                TMlazy(TMapp(TMapp(TMvar"cont", TMadd(TMvar"from", TMint(1))), TMvar"to"))
                )
        )
    )
)

// okay, now time for takeouts
// a function that, given a list, returns a list of tuples where each tuple consists of
// an element from the original list and the remainder of the list without that element.
// eg lst = [1, 2, 3]
// [(1, [2, 3]), (2, [1, 3]), (3, [1, 2])]
// step one: a function that takes a list and an index and returns the list minus the index
// eg. lst[:i] + lst[i+1:]

val TMskip_index =
let
var element_type = tpxyz_new()
var input = TManno(TMvar"input", TPllist(element_type))
var index = TManno(TMvar"index", TPint)
in
TMfix(
        "cont",
        "input",
        TMlam(
            "index",
            TMif0(
                    TMllist_nilq(input),
                    TMllist_nil(),
                    TMlet(
                            "element",
                            TMllist_head(input),
                            TMlet(
                                    "next_elements",
                                    TManno(TMapp(TMapp(TMvar"cont", TMllist_next(input)), TMsub(index, TMint(1))),
                                           TPllist(element_type)),
                                    TMif0(
                                        TMeq(index, TMint(0)),
                                        TMvar"next_elements",
                                        TMllist_cons(TManno(TMvar"element", element_type), TMlazy(TMvar"next_elements"))
                                        )
                                )
                            )
                    )
            )
    )
end

//val () = println!("type of TMskip_index ", term_type0(TMskip_index))
val zero_to_five = TMapp(TMapp(TMlazy_range, TMint(0)), TMint(5))
//
//val zero_to_five_no_1 = TMapp(TMapp(TMskip_index, zero_to_five), TMint(2))
//
//val () = println!(term_eval0(zero_to_five_no_1))
//val () = println!(term_eval0(
//        TMllist_next(zero_to_five_no_1)
//        ))
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(zero_to_five_no_1))
//))
//
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(TMllist_next(zero_to_five_no_1)))
//))
//
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(TMllist_next(TMllist_next(zero_to_five_no_1))))
//))
//

// now we need to get the nth element of a list.
// It would be more efficient to set up a reference
// and set it as we traverse the list for TMskip_index,
// but that has side effects (isn't functional exactly)
// and I don't want to. Instead, we'll just traverse the
// list a second time and grab it. Besides, we can probably
// use this function again later.
//
// we could do this with a filter and enumerate, but we'll
// just do it by hand.

fun TMllist_get_at(t:term, ind: term) : term =
TMapp(TMapp(TMllist_get_at_raw, t), ind) where {
val TMllist_get_at_raw =
let
var element_type = tpxyz_new()
var input = TManno(TMvar"input", TPllist(element_type))
var index = TManno(TMvar"index", TPint)
in
TMfix(
        "cont",
        "input",
        TMlam(
                "index",
                TMif0(
                        TMeq(index, TMint(0)),
                        TMllist_head(input),
                        TMapp(TMapp(TMvar"cont", TMllist_next(input)), TMsub(index, TMint(1)))
                        )
                )
        )
end
}
//val () = println!(term_type0(TMllist_get_at))

//val () = println!(term_eval0(TMllist_get_at(zero_to_five, TMint(0))))  //should print 0
//val () = println!(term_eval0(TMllist_get_at(zero_to_five, TMint(3))))  //should print 3


// with this we finally have the ability to write the take out function
// from (index, llist) to (list[index], llist[:index] + llist[index+1:])

fun TMtakeout(t:term, ind: term) : term =
TMapp(TMapp(TMtakeout_raw, t), ind) where {
var TMtakeout_raw =
let
var element_type = tpxyz_new()
var input = TManno(TMvar"input", TPllist(element_type))
var index = TManno(TMvar"index", TPint)
in
TMlam(
        "input",
        TMlam(
                "index",
                TMtup(
                        TMllist_get_at(input, index),
                        TMapp(TMapp(TMskip_index, input), index)
                        )
                )
        )
end
}

//val () = println!(term_type0(TMtakeout))

// now we need a lazy map.
fun
TMlazy_map(input: term, func: term): term =
TMapp(TMapp(TMlazy_map_raw, input), func) where {
val
TMlazy_map_raw =
let
val before_type = tpxyz_new()
val after_type = tpxyz_new()
val input = TManno(TMvar"input", TPllist(before_type))
val func = TManno(TMvar"func", TPfun(before_type, after_type))
in
TMfix
(
"cont",
"input",
TMlam(
"func",
      TMif0(
          TMllist_nilq(input),
          TMllist_nil(),
          TMllist_cons(
                  TMapp(func, TMllist_head(input)),
                  TMlazy(TMapp(TMapp(TMvar"cont", TMllist_next(input)), func))

          )
      ))
)
end
}

//val () = println!(term_type0(TMlazy_map_raw))

// let's test our map
//val TMincrement = TMlam(
//        "input",
//        TMadd(TMvar"input", TMint(1))
//)
//
//var one_to_six = TMlazy_map(zero_to_five, TMincrement)

//val () = println!(term_type0(one_to_six))
//val () = println!(term_eval0(
//        one_to_six
//        ))
//val () = println!(term_eval0(
//        TMllist_next(one_to_six)
//))
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(one_to_six))
//))
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(TMllist_next(one_to_six)))
//))
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(TMllist_next(TMllist_next(one_to_six))))
//))
//val () = println!(term_eval0(
//        TMllist_next(TMllist_next(TMllist_next(TMllist_next(TMllist_next(one_to_six)))))
//))

// now all we need for `takeouts` is to map the enumerate
// results of the input list on our takeout function
// first real quick let's write a function to go from our 2-tuple
// to a call to takeout

fun
TMtakeout_curried() =
TMtakeout_curried_raw where {
    var TMtakeout_curried_raw =
        TMlam(
                "inp",
                TMlam(
                        "index",
                        TMtakeout(TMvar
"inp", TMvar"index")
)
)
}

val enumerate_tuple_to_index =
TMlam(
        "inp",
        TMfst(TMvar"inp")
        )

val TMrange_len =
        TMlam(
                "inp",
                TMlazy_map(
                        TMllist_enumerate(TMvar"inp"),
                        enumerate_tuple_to_index
                        )
                )

val ten_to_fourteen = TMapp(TMapp(TMlazy_range, TMint(10)), TMint(14))


//val range_len_10_14 = TMapp(TMrange_len, ten_to_fourteen)
//val () = println!(term_eval0(range_len_10_14))
//val () = println!(term_eval0(TMllist_next(range_len_10_14)))

// ok, now we're ready

val TMtakeouts =
        TMlam(
            "input",
            TMlazy_map(
                TMapp(TMrange_len, TMvar"input"),
                TMapp(TMtakeout_curried(), TMvar"input")
            )
        )

//val takeouts = TMapp(TMtakeouts, zero_to_five)

//val () = println!(term_type0(takeouts))

val TMllist_to_list =
TMfix(
        "cont",
        "input",
        TMif0(
                TMllist_nilq(TMvar"input"),
                TMlist_nil(),
                TMlist_cons(
                        TMllist_head(TMvar"input"),
                        TMapp(TMvar"cont", TMllist_next(TMvar"input"))
                        )
                )
        )

//val TMtuple_element_llist_to_tuple_element_list =
//TMlam(
//        "inp",
//        TMtup(
//                TMfst(TMvar"inp"),
//                TMapp(TMllist_to_list, TMsnd(TMvar"inp"))
//                )
//        )
//
//val () = println!(term_eval0(
//        TMapp(TMllist_to_list,
//              TMlazy_map(takeouts, TMtuple_element_llist_to_tuple_element_list)
//              )
//        ))

//def ordered_permute(lst):
//    if not lst:
//        yield []
//    else:
//        for elem, remainder in takeouts(lst):
//            for p in ordered_permute(remainder):
//                yield [elem] + p

//def ordered_permute(lst):
//    if not lst:
//        yield []
//    else:
//        for elem_remainder_tuple in takeouts(lst):
//            for p in ordered_permute(elem_remainder_tuple.2):
//                yield [elem_remainder_tuple.1] + p

val TMllist_concat_raw =
let
val element_type = tpxyz_new()
val input1 = TManno(TMvar"input1", TPllist(element_type))
val input2 = TManno(TMvar"input2", TPllist(element_type))
in
TMfix
(
"cont",
"input1",
TMlam(
"input2",
      TMif0(
          TMllist_nilq(input1),
          input2,
          TMllist_cons(
                  TMllist_head(input1),
                  TMlazy(TMapp(TMapp(TMvar"cont", TMllist_next(input1)), input2))

          )
      ))
)
end

fun
TMllist_concat(a: term, b: term): term =
TMapp(TMapp(TMllist_concat_raw, a), b)


fun TMlazy_flatten(t:term):term =
TMapp(TMlazy_flatten_raw, t) where {
val TMlazy_flatten_raw =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPllist(TPllist(element_type)))
in
TMfix
(
"cont",
"input",
  TMif0(
      TMllist_nilq(input),
      TMllist_nil(),
      TMllist_concat(TMllist_head(input),
                    TMapp(TMvar"cont", TMllist_next(input))
        )
  )
)
end
}

val nested_list = TMllist_cons(
        zero_to_five,
        TMlazy(TMllist_cons(
                zero_to_five,
                TMlazy(TMllist_nil())
        ))
)



val flattened = TMlazy_flatten(
        nested_list
)
//
//val () = println!(term_eval0(
//            flattened
//        ))

//val () = println!(term_type0(nested_list))
//val () = println!(type_norm(term_type0(TMlazy_flatten_raw)))
//val () = println!(term_eval0(TMapp(TMllist_to_list, flattened)))




val TMordered_permute =
let
val element_type = TPint
val input_type = TPllist(element_type)
val lst = TManno(TMvar"lst", input_type)
in
TMfix(
        "cont",
        "lst",
        TMif0(
                TMllist_nilq(lst),
                TMllist_nil(),
                TMif0(
                        TMllist_nilq(TMllist_next(lst)),
                        TMllist_cons(lst, TMlazy(TMllist_nil())),
                        TMlet(
                        "elem_remainder_tuples_list",
                        TManno(TMapp(TMtakeouts, lst), TPllist(TPtup(element_type, input_type))),
                        TManno(
                                TMlazy_flatten(TMlazy_map(
                                    TManno(TMvar"elem_remainder_tuples_list", TPllist(TPtup(element_type, input_type))),
                                    TManno(
                                            TMlam(
                                                "elem_remainder_tuple",
                                                        TMlet("recursive_result", TManno(TMapp(TMvar"cont", TManno(TMsnd(TMvar"elem_remainder_tuple"), input_type)), TPllist(input_type)),
                                                            TMlazy_map(
                                                                TMvar"recursive_result",
                                                                TMlam(
                                                                        "x",
                                                                        TManno(TMllist_cons(TMfst(TMvar"elem_remainder_tuple"), TMlazy(TManno(TMvar"x", input_type))), input_type)
                                                                      )
                                                            )
                                                        )
                                            ),
                                         TPfun(TPtup(element_type, input_type), TPllist(input_type)))
                                    )),
                                    TPllist(input_type)
                                )
                        ))
                )
        )
end
//
val () = println!(term_type0(TMordered_permute))

val one_to_three_inclusive = TMapp(TMapp(TMlazy_range, TMint(1)), TMint(4))

val () = println!(term_eval0(
        TMapp(TMllist_to_list, TMlazy_map(TMapp(TMordered_permute, one_to_three_inclusive), TMllist_to_list))
        ))
val () = println!("")
val () = println!("*************")
val () = println!("")

val () = println!(term_eval0(TMfst(
        TMlazy_map(TMapp(TMordered_permute, zero_to_five), TMllist_to_list)
)))

val () = println!(term_eval0(TMfst(
        TMllist_next(TMlazy_map(TMapp(TMordered_permute, zero_to_five), TMllist_to_list))
)))

val () = println!(term_eval0(TMfst(
        TMllist_next(TMllist_next(TMlazy_map(TMapp(TMordered_permute, zero_to_five), TMllist_to_list)))
)))

val () = println!(term_eval0(TMfst(
        TMllist_next(TMllist_next(TMllist_next(TMlazy_map(TMapp(TMordered_permute, zero_to_five), TMllist_to_list))))
)))

val () = println!(term_eval0(TMfst(
        TMllist_next(TMllist_next(TMllist_next(TMllist_next(TMlazy_map(TMapp(TMordered_permute, zero_to_five), TMllist_to_list)))))
)))

val () = println!(term_eval0(TMfst(
        TMllist_next(TMllist_next(TMllist_next(TMllist_next(TMllist_next(TMlazy_map(TMapp(TMordered_permute, zero_to_five), TMllist_to_list))))))
)))
