#include "list_permute_stream_lambda.dats"
// lets start by implementing this function
// def conflict(board, i, j):
//    return board[i] == board[j] or abs(i-j) == abs(board[i]-board[j])

// first things first, a get_at function for lists.
fun
TMget_at(t: term, i: term) : term =
TMapp(TMapp(TMget_at_raw, t), i) where {
val TMget_at_raw =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPlist(element_type))
val index = TManno(TMvar"index", TPint)
in
TMfix(
        "cont",
        "input",
        TMlam(
                "index",
                TMif0(
                        TMeq(index, TMint(0)),
                        TMlist_head(input),
                        TMapp(TMapp(TMvar"cont", TMlist_tail(input)), TMsub(index, TMint(1)))
                      )
                )
        )
end
}
val board = TMlist_cons(TMint(0), TMlist_cons(TMint(2), TMlist_cons(TMint(4), TMlist_cons(TMint(6), TMlist_cons(TMint(1), TMlist_cons(TMint(3), TMlist_cons(TMint(5), TMlist_cons(TMint(7), TMlist_nil()))))))))

//val () = println!("get at 0 ", term_eval0(TMget_at(board, TMint(0))))
//
//val () = println!("get at 1 ", term_eval0(TMget_at(board, TMint(1))))
//
//val () = println!("get at 3 ", term_eval0(TMget_at(board, TMint(3))))


// now an abs function, I guess
val TMabs =
TMlam(
        "a",
        TMif0(
                TMlt(TMvar"a", TMint(0)),
                     TMmul(TMvar"a", TMint(~1)),
                     TMvar"a"
                 )
            )

(*
val () = println!(type_norm(term_type0(TMabs)))

val () = println!(term_eval0(
        TMapp(TMabs, TMint(~5))
        ))

val () = println!(term_eval0(
        TMapp(TMabs, TMint(25))
))
*)
// ok, back to this
// def conflict(board, i, j):
//    return board[i] == board[j] or abs(i-j) == abs(board[i]-board[j])
//
// we don't have the primitive logic operators "and" and "or", so we have to use nested ifs
// def conflict(board, i, j):
//    if board[i] == board[j]:
//          return true
//    else:
//          if abs(i-j) == abs(board[i]-board[j]):
//              return true
//          else:
//              return false

val TMconflict = 
let
val board = TManno(TMvar"board", TPlist(TPint))
val i = TManno(TMvar"i", TPint)
val j = TManno(TMvar"j", TPint)
in
TMlam(
    "board",
    TMlam(
        "i",
        TMlam(
            "j",
            TMlet(
                "board[i]",
                TMget_at(board, i),
                TMlet(
                    "board[j]",
                    TMget_at(board, j),
                    TMif0(
                        TMeq(TMvar"board[i]", TMvar"board[j]"),
                        TMbtf(true),
                        TMif0(
                            //if abs(i-j) == abs(board[i]-board[j]):
                            TMeq(TMapp(TMabs, TMsub(i, j)), TMapp(TMabs, TMsub(TMvar"board[i]", TMvar"board[j]"))),
                            TMbtf(true),
                            TMbtf(false)
                            )
                        )
                    )
                )
            )
        )
    )
end

(*
val () = println!(type_norm(term_type0(
        TMconflict
        )))



val board = TMlist_cons(TMint(0), TMlist_cons(TMint(2), TMlist_cons(TMint(4), TMlist_cons(TMint(6), TMlist_cons(TMint(1), TMlist_cons(TMint(3), TMlist_cons(TMint(5), TMlist_cons(TMint(7), TMlist_nil()))))))))
val () = println!("should be false", term_eval0(
        TMapp(TMapp(TMapp(TMconflict, board), TMint(1)), TMint(2))
))


val board = TMlist_cons(TMint(1), TMlist_cons(TMint(1), TMlist_cons(TMint(2), TMlist_cons(TMint(3), TMlist_cons(TMint(4), TMlist_cons(TMint(5), TMlist_cons(TMint(6), TMlist_cons(TMint(7), TMlist_nil()))))))))
val () = println!("should be true", term_eval0(
        TMapp(TMapp(TMapp(TMconflict, board), TMint(0)), TMint(1))
))

val board = TMlist_cons(TMint(0), TMlist_cons(TMint(2), TMlist_cons(TMint(3), TMlist_cons(TMint(5), TMlist_cons(TMint(1), TMlist_cons(TMint(4), TMlist_cons(TMint(6), TMlist_cons(TMint(7), TMlist_nil()))))))))
val () = println!("should be true", term_eval0(
        TMapp(TMapp(TMapp(TMconflict, board), TMint(1)), TMint(2))
))
val () = println!("should be true", term_eval0(
        TMapp(TMapp(TMapp(TMconflict, board), TMint(6)), TMint(7))
))

*)

// Now we need to do this:
// pairs = [(i, j) for i in range(len(board)) for j in range(i+1, len(board))]
// we can do this with a map and a range.
// we map over the range, and at each do a range from that element up to 8. Inside that map call,
// do another map call to return the tuple.

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


val pairs = TMflatten(TMmap(
        TMapp(TMapp(TMrange, TMint(0)), TMint(8)),
        TMlam(
                "x",
                TMmap(TMapp(TMapp(TMrange, TMadd(TMvar"x", TMint(1))), TMint(8)),
                    TMlam(
                            "y",
                            TMtup(TMvar"x", TMvar"y")
                          )
                    )
                )
        ))

val TMpairs_until_row =
TMlam(
        "row",
        TMflatten(TMmap(
        TMapp(TMapp(TMrange, TMint(0)), TMvar"row"),
        TMlam(
                "x",
                TMmap(TMapp(TMapp(TMrange, TMadd(TMvar"x", TMint(1))), TMint(8)),
                    TMlam(
                            "y",
                            TMtup(TMvar"x", TMvar"y")
                          )
                    )
                )
        ))

        )
val () = println!(term_eval0(TMapp(TMpairs_until_row, TMint(3))))

//val () = println!(type_norm(term_type0(pairs)))
//val () = println!(term_eval0(pairs))

// great! we've got pairs.
// now this line:
// return all(not conflict(i, j) for i, j in pairs)
// the for is easy, just another map. but the all is slightly harder.
// an easy solution is filter & len = 0
// the test is the not function, since we're checking for the existence of "false"

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
}

val TMall =
TMlam(
        "inp",
        TMlist_nilq(
                TMfilter(TMvar"inp",
                     TMlam("x",
                           TMif0(
                                   TMvar"x",
                                   TMbtf(false),
                                   TMbtf(true)
                                   )
                           )
                     )
            )
        )

// test TMall
(*
val () = println!(type_norm(term_type0(TMall)))

val true_list = TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(true), TMlist_nil()))))
val () = println!("Should be true ", term_eval0(TMapp(TMall, true_list)))

val false_list = TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(false), TMlist_nil()))))
val () = println!("Should be false ", term_eval0(TMapp(TMall, false_list)))

val mixed_list = TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(false), TMlist_cons(TMbtf(true), TMlist_cons(TMbtf(false), TMlist_nil()))))
val () = println!("Should be false ", term_eval0(TMapp(TMall, mixed_list)))

*)

// great, now for that last line
// return all(not conflict(x, y) for x, y in pairs)


val TMcheck_board_against_pair =
TMlam(
    "b",
    TMlam(
            "tuple",
            TMlet("x", TMfst(TMvar"tuple"),
            TMlet("y", TMsnd(TMvar"tuple"),
                TMapp(TMapp(TMapp(TMconflict, TMvar"b"), TMvar"x"), TMvar"y")
                ))
            )
    )

var TMcheck_conflict =
TMlam(
        "b",
        TMlam(
                "r",
                TMapp(TMall,
                    TMmap(
                        TMapp(TMpairs_until_row, TMvar"r"),
                        TMlam(
                                "tuple",
                                TMif0(
                                        TMapp(TMapp(TMcheck_board_against_pair, TMvar"b"), TMvar"tuple"),
                                        TMbtf(false),
                                        TMbtf(true)
                                        )
                                )
                        )
                )
            )
        )






val () = println!(type_norm(term_type0(TMcheck_conflict)))
//
val example_legal_board = TMlist_cons(TMint(0), TMlist_cons(TMint(4), TMlist_cons(TMint(7), TMlist_cons(TMint(5), TMlist_cons(TMint(2), TMlist_cons(TMint(6), TMlist_cons(TMint(1), TMlist_cons(TMint(3), TMlist_nil()))))))))
val example_illegal_board = TMlist_cons(TMint(0), TMlist_cons(TMint(4), TMlist_cons(TMint(7), TMlist_cons(TMint(0), TMlist_cons(TMint(2), TMlist_cons(TMint(6), TMlist_cons(TMint(1), TMlist_cons(TMint(3), TMlist_nil()))))))))

val () = println!("should be true, no conflict and all good ", term_eval0(
        TMapp(TMapp(TMcheck_conflict, example_legal_board), TMint(8))
        ))

val () = println!("should be false, there is conflict ", term_eval0(
        TMapp(TMapp(TMcheck_conflict, example_illegal_board), TMint(8))
))

val () = println!("400", term_eval0(
        TMapp(
                TMapp(TMcheck_board_against_pair, example_illegal_board),
                        TMtup(TMint(0), TMint(3)))
        ))

val () = println!("should be true, no conflict before row 4 ", term_eval0(
        TMapp(TMapp(TMcheck_conflict, example_illegal_board), TMint(2))
))
val () = println!("should be false, there is conflict at row 4", term_eval0(
        TMapp(TMapp(TMcheck_conflict, example_illegal_board), TMint(4))
))

// if the board is illegal, returns true. else false.
//val () = println!(term_eval0(
//        TMapp(TMapp(TMcheck_board_against_pair, example_legal_board), TMtup(TMint(0), TMint(1)))
//        ))


val lazy_0_8 = TMapp(TMapp(TMlazy_range, TMint(0)), TMint(8))


val board_template = TMlist_cons(TMvar"h", TMlist_cons(TMvar"g", TMlist_cons(TMvar"f", TMlist_cons(TMvar"e", TMlist_cons(TMvar"d", TMlist_cons(TMvar"c", TMlist_cons(TMvar"b", TMlist_cons(TMvar"a", TMlist_nil()))))))))



val all_posib =
TMlazy_flatten(TMlazy_map(lazy_0_8,
TMlam("a",
 TMlazy_flatten(TMlazy_map(lazy_0_8,
      TMlam("b",
            TMlazy_flatten(TMlazy_map(lazy_0_8,
                       TMlam("c",
                             TMlazy_flatten(TMlazy_map(lazy_0_8,
                                            TMlam("d",
                                                TMlazy_flatten(TMlazy_map(lazy_0_8,
                                                                          TMlam("e",
                                                                                TMlazy_flatten(TMlazy_map(lazy_0_8,
                                                                                        TMlam("f",
                                                                                              TMlazy_flatten(TMlazy_map(lazy_0_8,
                                                                                                      TMlam("g",
                                                                                                            TMlazy_map(lazy_0_8,
                                                                                                                       TMlam("h", board_template)
                                                                                                                       )
                                                                                                            )
                                                                                                      ))
                                                                                              )
                                                                                        ))
                                                                                )
                                                                          ))
                                            )
                                        ))
                            )
                       ))
        )
  ))
 )
))

val TMlist_len =
TMfix(
        "cont",
        "l",
        TMlam("i",
              TMif0(
                      TMlist_nilq(TMvar"l"),
                      TMvar"i",
                      TMapp(
                              TMapp(TMvar"cont", TMlist_tail(TMvar"l")),
                              TMadd(TMvar"i", TMint(1))
                              )
                      )
              )
        )

//val () = println!(type_norm(term_type0(
//        TMlist_len
//        )))

//val () = println!(term_eval0(
//        TMapp(TMapp(TMlist_len, example_legal_board), TMint(0))
//        ))

//val () = println!(term_eval0(TMapp(TMapp(TMlist_len, TMapp(TMllist_to_list, all_posib)), TMint(0))))

// now we need to write a lazy filter

val TMlazy_filter =
let
val element_type = tpxyz_new()
val input = TManno(TMvar"input", TPllist(element_type))
val test = TManno(TMvar"test", TPfun(element_type, TPbtf))
in
TMfix(
        "cont",
        "input",
        TMlam("test",
              TMif0(
                      TMapp(test, TMllist_head(input)),
                      TMllist_cons(
                              TMllist_head(input),
                              TMlazy(TMapp(TMapp(TMvar"cont", TMllist_next(input)), test))
                              ),
                      TMapp(TMapp(TMvar"cont", TMllist_next(input)), test)
                      )
              )
        )
end

//val () = println!(type_norm(term_type0(TMlazy_filter)))


//val TMis_pow_ten =
//TMlam(
//        "x",
//        TMeq(TMmod(TMvar"x", TMint(10)), TMint(0))
//        )
//
//val lazy_big_list = TMapp(TMapp(TMlazy_range, TMint(0)), TMint(800000000))
//
//val filter_test = TMapp(TMapp(
//        TMlazy_filter,
//        lazy_big_list
//), TMis_pow_ten)
//
//val () = println!(term_eval0(
//        TMllist_next(filter_test)
//        ))

