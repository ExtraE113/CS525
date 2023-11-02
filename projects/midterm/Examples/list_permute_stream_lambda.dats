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
//
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

var TMtakeout_curried =
TMlam(
        "inp",
        TMlam(
                "index",
                TMtakeout(TMvar"inp", TMvar"index")
                )
        )

val one_to_three = TMapp(TMapp(TMlazy_range, TMint(100)), TMint(104))

//val takeout_two = TMtakeout(one_to_three, TMint(2))
//val takeout_two   = TMapp(TMtakeout_from_argtuple, TMtup(TMint(2), one_to_three))
//val () = println!(term_type0(takeout_two))
//val () = println!(term_eval0(takeout_two))
//val () = println!(term_eval0(
//        TMllist_next(TMsnd(takeout_two))
//        ))
//val () = println!(term_eval0(
//                TMllist_next(TMllist_next(TMsnd(takeout_two)))
//                ))


//val () = println!(term_type0(TMtakeout_from_argtuple))

// ok, now we're ready

val takeouts =
        TMlazy_map(
                enumerated_lists,
                TMtakeout_from_argtuple
        )
val () = println!(term_type0(takeouts))